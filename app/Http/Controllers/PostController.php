<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Photo;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\PostPolicy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Auth;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        // ver se está autenticado 

        return view('pages.createpost', ['user' => 'visitor', 'needsFilter' => 0]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //checkar se tem autorizaçao
        $validator = Validator::make($request->all(),
        [
            'title' => ['required', 'string', 'max:120'],
            'thumbnail' => ['required', 'string'],
            'content' => ['required', 'string', 'max:5000'],
            'is_spoiler' => ['boolean'],
            'type' => ['required', 'string'], 
            'category' => ['required', 'string'], 
            'user_id' => ['required', 'int'],
            'photos' => ['array'],
            'tags' => ['array', "min:2", "max:10"],
        ],
        [
            'title.required' => 'Title can not be empty',
            'title.string' => 'Title must be a string',
            'title.max' => 'Title is too big, max of 120 characters',
            'thumbnail.required' => 'A thumbnail must be uploaded',
            'content.required' => 'Content can not be empty',
            'content.string' => 'Content must be a string',
            'content.max' => 'Content is too big, max of 5000 characters',
            'is_spoiler.boolean' => 'is_spoiler must be a boolean',
            'type.required' => 'Type must be filled',
            'type.string' => 'Type must be a string',
            'category.required' => 'Category must be filled',
            'category.string' => 'Category must be string',
            'user_id.required' => 'User ID is required',
            'user_id.int' => 'User ID must be an integer',
            'tag.min' => 'Must add at least 2 tags',
            'tag.max' => 'Must add at maximum 10 tags',
        ]);
         if ($validator->fails()) {
            return Redirect::back()->withErrors($validator->errors())->withInput();
        }

        $post = new Post();
        $post->title = $request->input('title');
        $post->thumbnail = $request->input('thumbnail');
        $post->content = $request->input('content');
        $post->is_spoiler = $request->input('is_spoiler');
        $post->type = $request->input('type');
        $post->category = $request->input('category');
        $post->user_id =  Auth::user()->id;
        $post->save();


        foreach($request->input('tags') as $tag){
            //inserir tag na tabela post_tags e na tag se nao existir ainda
            $t =  DB::table('tag')->select('id')->where('name', '=', $tag)->get(); 
            if($t != null){
                $post->post_tag()->create(['post_id'=> $post->id, 'tag_id' => $t]);
            }
            else{
                $new_tag = new Tag();
                $new_tag->name = $tag;
                $new_tag->save();
                $post->post_tag()->create(['post_id'=> $post->id, 'tag_id' => $new_tag->id]);
            }
        }


        foreach($request->input('photos') as $f){//add each photo to Photo table
            $photo = new Photo();
            $photo->photo = $f;
            $photo->post_id = $post->post_id;
            $photo->save();
        }

        return view('pages.newPost', ['user' => $user]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $post = Post::find($id);
        if(!$post)
            return view('pages.pagenotfound',['user' => 'visitor','needsFilter' => 0]);
        if(Auth::check())
            $user = Auth::user()->id == $post->user_id? 'authenticated_owner' : 'authenticated_user';
        else
            $user = 'visitor';
        $user = 'authenticated_owner';
        $post->timestamps = false;
        $post->increment('n_views');
        $USER = AuthenticatedUser::find($post->user_id);
        $comments = Comment::where('post_id',$id)->get()->count();
        $votes = DB::table("vote_post")->where("post_id",$id);
        $temp = $votes->get()->count();
        $likes = $votes->where("like",true)->get()->count();
        $dislikes = $temp - $likes;
        $tags = DB::select(DB::raw("select t.name
        FROM post_tag,tag as t
        WHERE post_tag.post_id=$id AND t.id = post_tag.tag_id;"));
        $date = date("F j, Y", strtotime($post['created_at']));

        $metadata = ['comments'=>$comments,'author'=>$USER['name'],'views' => $post->n_views,
                     'likes' => $likes,'tags' => $tags,'date'=>$date];
        //checkar se está autenticado e se é o dono

        
        return view('pages.post', ['user' => $user, 'needsFilter' => 0,'post' => $post,"metadata"=> $metadata] );
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //$post = Post::find($id);
        //chamar a view do edit post com esta informaçao
        return view('pages.editpost', ['user' => 'visitor', 'needsFilter' => 0] ); //['post'=> $post]
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $post_id)
    {
        //checkar se está autenticado   

        $validator = Validator::make($request->all(),
        [
            'title' => ['required', 'string', 'max:120'],
            'thumbnail' => ['required',''],
            'content' => ['required', 'string', 'max:5000'],
            'is_spoiler' => ['boolean', 'required'],
            'type' => ['required', 'string'], 
            'category' => ['required', 'string'], 
            'user_id' => ['required', 'int'],
            'photos' => ['array'],
            'tags' => ['array'],
        ],
        [
            'title.required' => 'Title can not be empty',
            'title.max' => 'Title is too big, max of 120 characters',
            'thumbnail.required' => 'A thumbnail must be uploaded',
            'content.required' => 'Content can not be empty',
            'is_spoiler' => 'Must be filled',
            'type' => 'Type must be filled',
            'category' => 'Category must be filled',
            'tag' => 'Must add at least one tag'
        ]);

        if ($validator->fails()) {
            return Redirect::back()->withErrors($validator->errors())->withInput();
        }

        //update das fotos e tags
        
        $post = Post::find($post_id);
        if($post != null){
            $post->title = $request->input('title');
            $post->thumbnail = $request->input('thumbnail');
            $post->content = $request->input('content');
            $post->is_spoiler = $request->input('is_spoiler');
            $post->type = $request->input('type');
            $post->category = $request->input('category');
            $post->user_id = Auth::user()->id;
            $post->save();
            return; //dar return da view do post
        }
        else return; //dá return da view do post
        
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function destroy($post_id)
    {
        //checkar se está autenticado

        $post = Post::find($post_id);
        if($post != null){
            if ($post->delete()) {
                return; //dar return da view da homepage
            } else {
                return; // dar return da view do post
            }
        }
    }

    /**
     * Reports the post
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function report(Request $request, $post_id){
        //checkar se está autenticado
        $validator = Validator::make($request->all(),
        [
            'motive' => ['required', 'string', 'max:200'],
        ],
        [
            'motive.required' => 'Motive can not be empty',
            'motive.max' => 'Motive is too long, max 200 characters'
        ]);

        if ($validator->fails()) {
            return Redirect::back()->withErrors($validator->errors())->withInput();
        }
        $post = Post::find($post_id);
        if($post != null){
            $report = new Report();
            $report->motive = $request->input('motive');
            $report->user_reporting = Auth::user()->id;
            $report->post_reported = $post->id;
            $report->save();

            return; //redirect para a pagina do post  
        }
        else return; //nao sei para onde vai 

        
    }
}
