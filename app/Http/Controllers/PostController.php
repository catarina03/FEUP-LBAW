<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\PostPolicy;
use App\Models\Report;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;


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
        if (!Auth::check()) {
            return redirect('login');
        }

        return view('pages.createpost', ['needsFilter' => 0, 'tags'=>[]]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!Auth::check()) {
            return redirect('login');
        }

        Validator::extend('minTags', function($attribute, $value, $parameters) {
            $min = (int) $parameters[0];
            return count($value) >= $min;
        });

        Validator::extend('maxTags', function($attribute, $value, $parameters) {
            $max = (int) $parameters[0];
            return count($value) <= $max;
        });

        Validator::extend('noDups', function($attribute, $value, $parameters) {
            return count($value) === count(array_flip($value));
        });

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
            'tags' => ['array', "minTags:2", "maxTags:10", "noDups"],
        ]);
         if ($validator->fails()) {
             return redirect(url()->previous())->withErrors($validator)->withInput();
        }

        DB::beginTransaction();
        try{
            $post = new Post();
            $post->title = $request->input('title');

            $imageName = $request->file('thumbnail')->store('public/images/posts');
            $imageName = basename($imageName, "");

            $post->thumbnail = $imageName;
            $post->content = $request->input('content');
            $post->is_spoiler = $request->input('is_spoiler');
            $post->type = $request->input('type');
            $post->category = $request->input('category');
            $post->user_id =  $request->input('user_id');
            $post->save();

            $tagArray = $request->input('tags');

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
                }
            }

            DB::commit();

            return redirect()->action([PostController::class, 'show'],['id'=>$post->id]);

        } catch(QueryException $err){
            DB::rollBack();
            return abort(404, "Failed to commit transaction");
        }

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
        $comments = HelperController::getPostComments($id,"desc",0);

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
        $thumbnail = "/storage/images/posts/".$post->thumbnail;
        //$thumbnail = Storage::get('images/posts/'.$post->thumbnail);
        $report = Report::where("user_reporting",$user_id)->where("post_reported",$post->id)->get()->count();
        $post->reported = false;
        if($report>0)
            $post->reported = true;

        //Generate metadata to send to view
        $metadata = ['comment_count'=>$comment_count,'author'=>$USER,'views' => $post->n_views,
                     'likes' => $likes, 'dislikes' => $dislikes, 'tags' => $tags,'date'=>$date,'thumbnail' => $thumbnail,'comments'=>$comments, 'liked' => $liked,"isSaved"=>$isSaved];

        $post->content = HelperController::remove_onclick_from_text($post->content);
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
        $route = \Route::current();

        if(!is_numeric($route->parameter('id')))
            return view('pages.pagenotfound',['needsFilter' => 0]);
        $post = Post::find($id);
        if(!$post)
            return view('pages.pagenotfound',['needsFilter' => 0]);

        $isAuthor = false;
        if(Auth::check())
            $isAuthor = Auth::user()->id == $post->user_id;
        else
            return redirect('login');

        if(!$isAuthor) return \redirect('/');

        //Set timestamps to false(updated_at column doesnt exist) and increment views
        $post->timestamps = false;

        //Get tags associated with current post TODO:: Use Tag Model
        $tags = DB::select(DB::raw("select *
        FROM post_tag,tag as t
        WHERE post_tag.post_id=$id AND t.id = post_tag.tag_id;"));

        //Get date and thumbnail path
        $thumbnail = "/storage/images/posts/".$post->thumbnail;
       // $thumbnail = Storage::get('images/posts/'.$post->thumbnail);

        return view('pages.editpost', ['needsFilter' => 0, 'post'=>$post, 'tags'=>$tags, 'thumbnail'=>$thumbnail] ); //['post'=> $post]
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
        if (!Auth::check()) {
            return redirect('login');
        }
        //TODO: IF NOT AUTHOR

        Validator::extend('minTags', function($attribute, $value, $parameters) {
            $min = (int) $parameters[0];
            return count($value) >= $min;
        });

        Validator::extend('maxTags', function($attribute, $value, $parameters) {
            $max = (int) $parameters[0];
            return count($value) <= $max;
        });

        Validator::extend('noDups', function($attribute, $value, $parameters) {
            return count($value) === count(array_flip($value));
        });

        //checkar se tem autorizaçao
        $validator = Validator::make($request->all(),
            [
                'title' => ['required', 'string', 'max:120'],
                'thumbnail' => ['image', 'mimes:jpeg,jpg,png,gif'],
                'content' => ['required', 'string', 'max:5000'],
                'is_spoiler' => ['boolean'],
                'type' => ['required', 'string'],
                'category' => ['required', 'string'],
                'user_id' => ['required', 'int'],
                'photos' => ['array'],
                'tags' => ['array', "minTags:2", "maxTags:10", "noDups"],
            ]);
        if ($validator->fails()) {
            return redirect(url()->previous())->withErrors($validator)->withInput();
        }

        DB::beginTransaction();
        try{

            $post = Post::find($post_id);
            if($post != null){
                $post->title = $request->input('title');

                if($request->file('thumbnail') != null){
                    Storage::delete('public/images/posts/'. $post->thumbnail);
                    $imageName = $request->file('thumbnail')->store('public/images/posts');
                    $imageName = basename($imageName, "");
                    if(Post::where('id', $post->id)->update(['thumbnail' => $imageName]) != 1){
                        return response('Photo update error', 500);
                    }
                }

                $post->content = $request->input('content');
                $post->is_spoiler = $request->input('is_spoiler');
                $post->type = $request->input('type');
                $post->category = $request->input('category');
                $post->user_id = Auth::user()->id;
                $post->save();
            }
            else{
                return redirect('addpost');
            }

            $oldTags = DB::table('tag')->join('post_tag', 'tag.id', '=', 'post_tag.tag_id')->where('post_tag.post_id', '=', $post->id)->get();
            foreach($oldTags as $oldTag){
                $t =  DB::table('tag')->where('name', '=', $oldTag->name)->first();
                DB::table('post_tag')->where('post_id', '=', $post->id)->where('tag_id', '=', $t->id)->delete();
            }

            foreach($request->input('tags') as $tag){
                if(DB::table('tag')->select('id')->where('name', '=', $tag)->exists()){
                    $t =  DB::table('tag')->where('name', '=', $tag)->first();
                    DB::table('post_tag')->insert(['post_id' => $post->id, 'tag_id' => $t->id]);
                }
                else{
                    $new_tag = new Tag();
                    $new_tag->name = $tag;
                    $new_tag->save();
                    DB::table('post_tag')->insert(['post_id' => $post->id, 'tag_id' => $new_tag->id]);
                }
            }

            DB::commit();

           // return redirect()->action([PostController::class, 'show'],['id'=>$post_id]);
            return redirect('post/'.$post->id);

        } catch(QueryException $err){
            DB::rollBack();
            return abort(404, "Failed to commit transaction");
        }

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
                    if(!PostPolicy::delete_post_policy(Auth::user(),$post))
                        return 'post/' + $post_id;
                    if ($post->delete()) {
                        session()->push('toaster', 'Post deleted successfully!');
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
            return response()->json($validator->errors())->setStatusCode(400);;
        }
        $post = Post::find($post_id);
        if(Auth::check()){
            if(($post != null) && (Auth::user()->id != $post->user_id)){
                $report = new Report();
                $report->timestamps = false;
                $report->motive = $request->input('motive');
                $report->user_reporting = Auth::user()->id;
                $report->post_reported = $post->id;
                $report->save();

                return response()->json(['status' => "Post reported!"])->setStatusCode(200);
            }
            else
                return response()-setStatusCode(403);
        }
        else return response()->setStatusCode(401);


    }

    public function addSave($id){

        $route = \Route::current();
        if(!is_numeric($route->parameter('id')))
            return response()->setStatusCode(404);;
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
            else
                return response()->setStatusCode(403);
        }
        return response()->setStatusCode(401);
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
        return response()->setStatusCode(401);
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
        $comments = HelperController::getPostComments($post_id,"desc",$page);
        return HelperController::commentsAsHtml($comments,$user_id);
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
