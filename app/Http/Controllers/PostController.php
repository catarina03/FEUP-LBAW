<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Photo;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\PostPolicy;
use App\Models\Report;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;
//use Auth;

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

        return view('pages.createpost', ['needsFilter' => 0]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        Validator::extend('minTags', function($attribute, $value, $parameters) {
            $min = (int) $parameters[0];
            $tagList = explode(",", $value);
            return count($tagList) >= $min;
        });

        Validator::extend('maxTags', function($attribute, $value, $parameters) {
            $max = (int) $parameters[0];
            $tagList = explode(",", $value);
            return count($tagList) <= $max;
        });

        Validator::extend('noDups', function($attribute, $value, $parameters) {
            $tagList = explode(",", $value);
            return count($tagList) === count(array_flip($tagList));
        });

        //dd($request->input());
        //checkar se tem autorizaçao
        $validator = Validator::make($request->all(),
        [
            'title' => ['required', 'string', 'max:120'],
            'thumbnail' => ['required', 'image', 'mimes:jpeg,jpg,png,gif'],
            'content' => ['required', 'string', 'max:5000'],
            'is_spoiler' => ['boolean'],
            'type' => ['required', 'string'],
            'category' => ['required', 'string'],
            'user_id' => ['required', 'int'],
            'photos' => ['array'],
            'tag-input' => ['string', "minTags:2", "maxTags:10", "noDups"],
        ],
        [
            'title.required' => 'Title can not be empty',
            'title.string' => 'Title must be a string',
            'title.max' => 'Title is too big, max of 120 characters',
            'thumbnail.required' => 'A thumbnail must be uploaded',
            'thumbnail.image' => 'A thumbnail must be a jpeg,jpg,png,gif image',
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
            'tag-input.min' => 'Must add at least 2 tags',
            'tag-input.max' => 'Must add at maximum 10 tags',
        ]);
         if ($validator->fails()) {
             //dd($validator->errors());
             //dd($request->all());
             return redirect(url()->previous())->withErrors($validator)->withInput();

        }

        $post = new Post();
        $post->title = $request->input('title');

        // function assumes that the image is valid and verification was done before
        $date = date('Y-m-d H:i:s');
        $imageSalt = random_bytes(5);
        $imageName = hash("sha256", $request->file('thumbnail')->getFilename() . $date . $imageSalt) . "." . $request->file('thumbnail')->getClientOriginalExtension();
        // Generate filenames for original, small and medium files
        //$request->file('thumbnail')->move(storage_path(public_path().'/images'), $imageName);
        //$image_path = Storage::disk('public')->putFile('images', $request->file('thumbnail'));
        $request->thumbnail->move(public_path('images'), $imageName);

        $post->thumbnail = $imageName;
        $post->content = $request->input('content');
        $post->is_spoiler = $request->input('is_spoiler');
        $post->type = $request->input('type');
        $post->category = $request->input('category');
        $post->user_id =  1;
        $post->save();

        //$post_id = Post::query()->where('user_id', Auth::id())->orderBy('id', 'desc')->first();
        //Storage::put(public_path().'/images/'.$post->id.'_thumb', $post->thumbnail);

        $tagArray = explode(',', $request->input('tag-input'));

        info($tagArray);

        foreach($tagArray as $tag){
            info($tag);
            //inserir tag na tabela post_tags e na tag se nao existir ainda

            //dd($t);
            if(DB::table('tag')->select('id')->where('name', '=', $tag)->exists()){
                $t =  DB::table('tag')->where('name', '=', $tag)->first();
                //dd($t);
                DB::table('post_tag')->insert(['post_id' => $post->id, 'tag_id' => $t->id]);
                //$post->tags()->create(['post_id'=> $post->id, 'tag_id' => $t->id]);
               // dd($t);
            }
            else{
               // dd($tag);
                $new_tag = new Tag();
                $new_tag->name = $tag;
                $new_tag->save();
                DB::table('post_tag')->insert(['post_id' => $post->id, 'tag_id' => $new_tag->id]);
                //$post->tags()->create(['post_id'=> $post->id, 'tag_id' => $new_tag->id]); TODO WHY NOT WORKING??
            }
        }

/*
        foreach($request->input('photos') as $f){//add each photo to Photo table
            $photo = new Photo();
            $photo->photo = $f;
            $photo->post_id = $post->post_id;
            $photo->save();
        }
*/

        $user = 'authenticated_user';
        //Get tags associated with current post TODO:: Use Tag Model
        $tags = DB::select(DB::raw("select t.name
        FROM post_tag,tag as t
        WHERE post_tag.post_id=$post->id AND t.id = post_tag.tag_id;"));
        //Generate metadata to send to view
        $metadata = ['comments'=>0,'author'=>AuthenticatedUser::find($post->user_id)['name'],'views' => 0,
            'likes' => 0,'tags' => $tags,'date'=>$post->created_at,'thumbnail' => '/images/'.$post->thumbnail];


        //return view('pages.post', ['user' => $user, 'needsFilter'=>0, 'post'=>$post, 'metadata'=>$metadata]); //TODO, WRONG ROUTE
        return redirect()->action([PostController::class, 'show'],['id'=>$post->id]);//'/post/'.$post->id, ['user' => $user, 'needsFilter'=>0, 'post'=>$post, 'metadata'=>$metadata]);
        //return redirect()->route("post/".$post->id, ['user' => $user, 'needsFilter'=>0, 'post'=>$post, 'metadata'=>$metadata]);
        //return \redirect()
        //return this.show($post->id);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Post  $post
     * @return
     */
    public function show($id)
    {
        //Get currnt route
        $route = \Route::current();

        //If route {id} isnt int or post doesnt exist, redirect to notfound.
        if(!is_numeric($route->parameter('id')))
            return view('pages.pagenotfound',['needsFilter' => 0]);
        $post = Post::find($id);
        if(!$post )
            return view('pages.pagenotfound',['needsFilter' => 0]);

        //Verify if user is authenticated and if user is owner of post
        $user_id = null;
        $isSaved = false;
        $liked = 0;
        if(Auth::check()){
            $user_id = Auth::user()->id;
            $isOwner = $user_id == $post->user_id? true : false;
            $isSaved = DB::table("saves")->where("user_id",$user_id)->where("post_id",$id)->get()->count() > 0;
            if(!PostPolicy::show_post(Auth::user(),$post))
                return view('pages.pagenotfound',['user' => 'visitor','needsFilter' => 0]);
            $like = DB::table("vote_post")->where("post_id",$id)->where('user_id', $user_id)->value('like');
            if($like === true) $liked = 2;
            else if($like === false) $liked = 1;
            else $liked = 0;

        }
        else
            $isOwner = false;

        $post->timestamps = false;
        $post->increment('n_views');

        //Get owner
        $USER = AuthenticatedUser::find($post->user_id);

        //Get comment count,likes and dislikes
        $comments = Comment::getPostComments($id,"desc",1);
        $comments = Comment::checkReported($comments,$user_id);
        foreach ($comments as $c){
            $like = DB::table("vote_comment")->where("comment_id",$c->id)->where('user_id', $user_id)->value('like');
            if($like === true) $liked = 2;
            else if($like === false) $liked = 1;
            else $liked = 0;
            $c->liked = $liked;
        }

        $comment_count = Comment::where('post_id',$id)->get()->count();
        $votes = DB::table("vote_post")->where("post_id",$id);
        $temp = $votes->get()->count();
        $likes = $votes->where("like",true)->get()->count();
        $dislikes = $temp - $likes;

        //Get tags associated with current post
        $tags = DB::select(DB::raw("select t.name,t.id
        FROM post_tag,tag as t
        WHERE post_tag.post_id=$id AND t.id = post_tag.tag_id;"));
        foreach($tags as $tag){
            $tag->isSaved = false;
            $tag->isSaved = Db::table("follow_tag")->where("user_id",$user_id)->where("tag_id",$tag->id)->get()->count() > 0;
        }

        //Get date and thumbnail path
        $date = date("F j, Y", strtotime($post['created_at']));
        $thumbnail = "/images/".$post->thumbnail;
        $report = Report::where("user_reporting",$user_id)->where("post_reported",$post->id)->get()->count();
        $post->reported = false;
        if($report>0)
            $post->reported = true;


        //Generate metadata to send to view
        $metadata = ['comment_count'=>$comment_count,'author'=>$USER,'views' => $post->n_views,
                     'likes' => $likes, 'dislikes' => $dislikes, 'tags' => $tags,'date'=>$date,'thumbnail' => $thumbnail,'comments'=>$comments, 'liked' => $liked,"isSaved"=>$isSaved];


        return view('pages.post', ['isOwner' => $isOwner, 'needsFilter' => 0,'post' => $post,"metadata"=> $metadata,"user_id" => $user_id]);

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Post  $post
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //Get currnt route
        $route = \Route::current();

        //If route {id} isnt int or post doesnt exist, redirect to notfound.
        if(!is_numeric($route->parameter('id')))
            return view('pages.pagenotfound',['needsFilter' => 0]);
        $post = Post::find($id);
        if(!$post )
            return view('pages.pagenotfound',['needsFilter' => 0]);

        //Verify if user is authenticated and if user is owner of post
        if(Auth::check())
            $user = Auth::user()->id == $post->user_id? 'authenticated_owner' : 'authenticated_user';
        else
            $user = 'visitor';

        //Set timestamps to false(updated_at column doesnt exist) and increment views
        $post->timestamps = false;
        //$post->increment('n_views');

        //Get owner TODO:: Get owner only if user!=authenticated_owner' , otherwise the owner is Auth::user()
        $USER = AuthenticatedUser::find($post->user_id);

        //Get tags associated with current post TODO:: Use Tag Model
        $tags = DB::select(DB::raw("select t.name
        FROM post_tag,tag as t
        WHERE post_tag.post_id=$id AND t.id = post_tag.tag_id;"));

        //Get date and thumbnail path
        $thumbnail = "/images/".$post->thumbnail;

        /*
        //Generate metadata to send to view
        $metadata = ['comments'=>$comments,'author'=>$USER['name'],'views' => $post->n_views,
            'likes' => $likes,'tags' => $tags,'date'=>$date,'thumbnail' => $thumbnail];
        //checkar se está autenticado e se é o dono
        */


        //$post = Post::find($id);
        //chamar a view do edit post com esta informaçao
        return view('pages.editpost', ['needsFilter' => 0, 'post'=>$post] ); //['post'=> $post]
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
        Validator::extend('minTags', function($attribute, $value, $parameters) {
            $min = (int) $parameters[0];
            $tagList = explode(",", $value);
            return count($tagList) >= $min;
        });

        Validator::extend('maxTags', function($attribute, $value, $parameters) {
            $max = (int) $parameters[0];
            $tagList = explode(",", $value);
            return count($tagList) <= $max;
        });

        Validator::extend('noDups', function($attribute, $value, $parameters) {
            $tagList = explode(",", $value);
            return count($tagList) === count(array_flip($tagList));
        });

        //dd($request->input());
        //checkar se tem autorizaçao
        $validator = Validator::make($request->all(),
            [
                'title' => ['required', 'string', 'max:120'],
                'thumbnail' => ['required', 'image', 'mimes:jpeg,jpg,png,gif'],
                'content' => ['required', 'string', 'max:5000'],
                'is_spoiler' => ['boolean'],
                'type' => ['required', 'string'],
                'category' => ['required', 'string'],
                'user_id' => ['required', 'int'],
                'photos' => ['array'],
                'tag-input' => ['string', "minTags:2", "maxTags:10", "noDups"],
            ],
            [
                'title.required' => 'Title can not be empty',
                'title.string' => 'Title must be a string',
                'title.max' => 'Title is too big, max of 120 characters',
                'thumbnail.required' => 'A thumbnail must be uploaded',
                'thumbnail.image' => 'A thumbnail must be a jpeg,jpg,png,gif image',
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
                'tag-input.min' => 'Must add at least 2 tags',
                'tag-input.max' => 'Must add at maximum 10 tags',
            ]);
        if ($validator->fails()) {
            return redirect(url()->previous())->withErrors($validator)->withInput();
        }

        $post = Post::find($post_id);
        if($post != null){
            $post->title = $request->input('title');

            $date = date('Y-m-d H:i:s');
            $imageSalt = random_bytes(5);
            $imageName = hash("sha256", $request->file('thumbnail')->getFilename() . $date . $imageSalt) . "." . $request->file('thumbnail')->getClientOriginalExtension();
            $request->thumbnail->move(public_path('images'), $imageName);
            $post->thumbnail = $imageName;

            $post->content = $request->input('content');
            $post->is_spoiler = $request->input('is_spoiler');
            $post->type = $request->input('type');
            $post->category = $request->input('category');
            $post->user_id = Auth::user()->id;
            $post->save();
        }

        $tagArray = explode(',', $request->input('tag-input'));

        info($tagArray);

        foreach($tagArray as $tag){
            if(DB::table('tag')->select('id')->where('name', '=', $tag)->exists()){
                $t =  DB::table('tag')->where('name', '=', $tag)->first();
                DB::table('post_tag')->insert(['post_id' => $post->id, 'tag_id' => $t->id]);
            }
            else{
                $new_tag = new Tag();
                $new_tag->name = $tag;
                $new_tag->save();
                DB::table('post_tag')->insert(['post_id' => $post->id, 'tag_id' => $new_tag->id]);
                //$post->tags()->create(['post_id'=> $post->id, 'tag_id' => $new_tag->id]); TODO WHY NOT WORKING??
            }
        }

        $user = 'authenticated_user';

        //Get comment count,likes and dislikes
        $comments = Comment::where('post_id',$id)->get()->count();
        $votes = DB::table("vote_post")->where("post_id",$id); //Couldn't figure ut how to do it with pivot table
        $temp = $votes->get()->count();
        $likes = $votes->where("like",true)->get()->count();
        $dislikes = $temp - $likes;

        //Get tags associated with current post TODO:: Use Tag Model
        $tags = DB::select(DB::raw("select t.name
        FROM post_tag,tag as t
        WHERE post_tag.post_id=$post->id AND t.id = post_tag.tag_id;"));
        //Get date and thumbnail path
        $date = date("F j, Y", strtotime($post['created_at']));
        $thumbnail = "/images/".$post->thumbnail;;

        //Generate metadata to send to view
        $metadata = ['comments'=>$comments,'author'=>$USER['name'],'views' => $post->n_views,
            'likes' => $likes,'tags' => $tags,'date'=>$date,'thumbnail' => $thumbnail];
        //checkar se está autenticado e se é o dono

        return redirect()->action([PostController::class, 'show'],['id'=>$post_id]);
        //return \redirect()->route('post/'.$post_id, ['user' => $user, 'needsFilter'=>0, 'post'=>$post, 'metadata'=>$metadata]);
           // view('pages.post', ['user' => $user, 'needsFilter'=>0, 'post'=>$post, 'metadata'=>$metadata]); //TODO, WRONG ROUTE

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
        if(Auth::check()){
            $post = Post::find($post_id);
            //if(Auth::user()->id == $post->user_id){
                if($post != null){
                    $this->authorize("delete",$post);
                    if ($post->delete()) {
                        return ''; //dar return da view da homepage
                    } else {
                        return 'post/' + $post_id; // dar return da view do post
                    }
                }
            //}
        }
        return 'post/' + $post_id;
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
        if(($post != null) && Auth::check() && (Auth::user()->id != $post->user_id)){
            $report = new Report();
            $report->timestamps = false;
            $report->motive = $request->input('motive');
            $report->user_reporting = Auth::user()->id;
            $report->post_reported = $post->id;
            $report->save();

            return response()->json(['status' => "Post reported!"])->setStatusCode(200);
        }
        else return response()->json(['status' => "Error encountered when trying to report post!"])->setStatusCode(404);


    }

    public function addSave($id){

        $route = \Route::current();
        if(!is_numeric($route->parameter('id')))
            return '';
        if(Auth::check()){
            $post = Post::find($id);
            if(Auth::user()->id != $post->user_id){
                if($post != null){
                    DB::table("saves")->insert([
                        'user_id' => Auth::user()->id,
                        'post_id' => $id
                    ]);
                    return 'SUCCESS';
                }
            }
        }
        return '';
    }

    public function deleteSave($id){
        $route = \Route::current();
        //If route {id} isnt int or post doesnt exist, redirect to notfound.
        if(!is_numeric($route->parameter('id')))
            return 'F';
        if(Auth::check()){
            $post = Post::find($id);
            $save = DB::table("saves")->where("post_id",$id)->where("user_id",Auth::user()->id);
            if($post != null && $save != null){
                if($save->delete())
                    return 'SUCCESS';
            }
        }
        return 'A';
    }

    public function popularComments(Request $request, $post_id){
        $route = \Route::current();
        if(!is_numeric($route->parameter('post_id')))
            return "";
        $post = Post::find($post_id);
        if(!$post )
            return "";
        $user_id = 0;
        if(Auth::check())
            $user_id = Auth::user()->id;
        $comments = Comment::getPostPopularComments($post_id);
        return Comment::commentsAsHtml($comments,$user_id);


    }

    public function newerComments(Request $request, $post_id){
        $route = \Route::current();
        if(!is_numeric($route->parameter('post_id')))
            return "";
        $post = Post::find($post_id);
        if(!$post )
            return "";
        $user_id = 0;
        if(Auth::check())
            $user_id = Auth::user()->id;
        $comments = Comment::getPostComments($post_id,"desc",1);
        return Comment::commentsAsHtml($comments,$user_id);
    }

    public function olderComments(Request $request, $post_id){
        $route = \Route::current();
        if(!is_numeric($route->parameter('post_id')))
            return "";
        $post = Post::find($post_id);
        if(!$post )
            return "";
        $user_id = 0;
        if(Auth::check())
            $user_id = Auth::user()->id;
        $comments = Comment::getPostComments($post_id,"asc",1);
        return Comment::commentsAsHtml($comments,$user_id);
    }

    public function loadMore(Request $request, $post_id,$page){
        $route = \Route::current();
        if(!is_numeric($route->parameter('post_id')) || !is_numeric($route->parameter('page')))
            return "";
        $post = Post::find($post_id);
        if(!$post )
            return "";
        $user_id = 0;
        if(Auth::check())
            $user_id = Auth::user()->id;
        $comments = Comment::getPostComments($post_id,"desc",$page);
        return Comment::commentsAsHtml($comments,$user_id);
    }


    public function addVote(Request $request, $id){
        $vote = $request["vote"] === "true";
        if(!is_bool($vote))
            return 'error';
        if(Auth::check()){
            $post = Post::find($id);
            if(Auth::user()->id != $post->user_id){
                if($post != null){
                    DB::table("vote_post")->insert([
                        'user_id' => Auth::user()->id,
                        'post_id' => $id,
                        'like' => $vote
                    ]);
                    return 'SUCCESS';
                }
            }
        }
        return 'error';
    }

    public function editVote(Request $request, $id){
        $vote = $request["vote"] === "true";
        if(!is_bool($vote))
            return 'error';
        if(Auth::check()){
            $post = Post::find($id);
            if(Auth::user()->id != $post->user_id){
                if($post != null){
                    DB::table("vote_post")
                        ->where('user_id', Auth::user()->id)
                        ->where('post_id', $id)
                        ->update(['like' => $vote]);
                    return 'SUCCESS';
                }
            }
        }
        return 'error';

    }
    public function deleteVote($id){
        if(Auth::check()){
            $post = Post::find($id);
            if(Auth::user()->id != $post->user_id){
                if($post != null){
                    $vote = DB::table("vote_post")
                        ->where('user_id', Auth::user()->id)
                        ->where('post_id', $id);
                    if($vote != null){
                        if($vote->delete()) return 'SUCCESS';
                    }
                }
            }
        }
        return 'error';
    }
}
