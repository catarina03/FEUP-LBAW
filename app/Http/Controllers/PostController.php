<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Photo;
use App\Models\Tag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

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
        //
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

        //checkar se está autenticado
        //se o post existir vai buscar o necessario para mostrar o post e chama a sua view
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
        $post = Post::find($id);
        //chamar a view do edit post com esta informaçao
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
