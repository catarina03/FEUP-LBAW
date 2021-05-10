<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Photo;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\PostPolicy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;

class CommentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        DB::table(report)->select()->get();
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
    public function store(Request $request,$post_id)
    {   
        $validator = Validator::make($request->all(),
            [
                'content' => ['required', 'string', 'max:1000','min:1'],
                'user_id' => ['required', 'numeric'],
                'post_id' => ['required', 'numeric'],
            ],
            [
                'content.required' => 'Content cannot be empty',
                'user_id.numeric' => 'UserID must be a number',
                'user_id.required' => 'UserID must be a number',
                'post_id.numeric' => 'PostID must be a number',
                'posst_id.required' => 'PostID must be a number',
                'content.max' => 'Content is too big, max of 1000 characters',
                'content.min' => 'Content is too short, max of 1000 characters'
            ]);
        if($validator->fails())
                return "";
        if(Auth::check()){
            $post = Post::find($request->input('post_id'));
            if($post != null && Auth::user()->id != $post->user_id){
                DB::table('comment')->insert([
                    'content' => $request->input('content'),
                    'user_id' => $request->input('user_id'),
                    'post_id' => $request->input('post_id')
                ]);
                $comments = Comment::getPostComments($post_id,"desc");
                return Comment::commentsAsHtml($comments,Auth::user()->id);
            }
        }
        return "";
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function show(Comment $comment)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function edit(Comment $comment)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Comment $comment)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function destroy(Comment $comment)
    {
        return $comment->delete();
    }

    public function editForm(Request $request,$comment_id){

        //Checagem de erros
        if(Auth::check()){
            $comment = Comment::find($comment_id);
            if($comment!=null && Auth::user()->id == $comment->user_id){
                return json_encode($comment);
            }
        }
        return ""; 
    }

    public function editAction(Request $request,$comment_id){//update?
        $validator = Validator::make($request->all(),
        [
            'content' => ['required', 'string', 'max:1000','min:1']
        ],
        [
            'content.required' => 'Content cannot be empty',
            'content.max' => 'Content is too big, max of 1000 characters',
            'content.min' => 'Content is too short, min of 1 characters'
        ]);
        
        if($validator->fails())
            return "";
        
        if(Auth::check()){
            $comment = Comment::find($comment_id);
            $comment->timestamps = false;
            if($comment!=null && Auth::user()->id == $comment->user_id){
                $comment->content = $request['content'];
                if($comment->save())
                    return json_encode(Comment::getCommentInfo($comment_id));
                return "";
            }
        }
        return ""; 
    }


    public function destroyComment(Request $request,$comment_id){
        $comment = Comment::find($comment_id);
        if(Auth::check()){
            if($comment!=null){
                if(Auth::user()->id == $comment->user_id){
                    return $this->destroy($comment)?"SUCCESS":"FAIL";
                }
            }
        }
        return "FAIL";
    }

    public function threads(Request $request,$comment_id){
        $threads = DB::table('comment')->where('comment_id',$comment_id)->select('id','content','comment_date','user_id','post_id','comment_id')->get();
    }

    public function addThread(Request $request,$comment_id){
        $validator = Validator::make($request->all(),
        [
            'content' => ['required', 'string', 'max:1000','min:1'],
            'user_id' => ['required', 'numeric'],
            'comment_id' => ['required', 'numeric'],
        ],
        [
            'content.required' => 'Content cannot be empty',
            'user_id.numeric' => 'UserID must be a number',
            'user_id.required' => 'UserID must be a number',
            'comment_id.numeric' => 'CommentID must be a number',
            'comment_id.required' => 'CommentID must be a number',
            'content.max' => 'Content is too big, max of 1000 characters',
            'content.min' => 'Content is too short, max of 1000 characters'
        ]);
        if($validator->fails())
            return "";
        if(Auth::check()){
            $comment = Comment::find($request->input('comment_id'));
            if($comment != null && Auth::user()->id == $request->input('user_id')){
                DB::table('comment')->insert([
                    'content' => $request->input('content'),
                    'user_id' => $request->input('user_id'),
                    'comment_id' => $request->input('comment_id')
                ]);
                $comments = Comment::getPostComments($comment->post_id,"desc");
                return Comment::commentsAsHtml($comments,Auth::user()->id);
            }
        }
        return "";

    }

    public function reportComment(Request $request,$comment_id){
        $validatedData = $request->validate([
            'motive' => 'required',
            'user_reporting' => 'required|numeric',
            'comment_reported' => 'required|numeric'
        ]);

        DB::table('report')->insert([
            'reported_date' => 'DEFAULT',
            'accepted' => 'NULL',
            'closed_date' => 'NULL',
            'motive' => $validatedData->motive,
            'user_reporting' => $validatedData->user_reporting,
            'user_assigned' => 'NULL',
            'comment_reported' => $validatedData->comment_reported,
            'post_reported' => 'NULL'
        ]);
    }

    public function vote(Request $request,$comment_id){
        $validatedData = $request->validate([
            'user_id' => 'required|numeric',
            'comment_id' => 'required|numeric',
            'like' => 'required|numeric'
        ]);

        DB::table('vote_comment')->insert([
            'user_id' => $validatedData['user_id'],
            'comment_id' => $validatedData['comment_id'],
            'like' => $validatedData['like']
        ]);
    }

    public function editVote(Request $request,$comment_id){
        $validatedData = $request->validate([
            'user_id' => 'required|numeric',
            'comment_id' => 'required|numeric',
            'like' => 'required|numeric'
        ]);

        DB::table('vote_comment')->where('user_id',$validatedData['user_id'])->
        where('comment_id',$validatedData['comment_id'])->update([
            'like' => $validatedData['like']
        ]);
    }

}
