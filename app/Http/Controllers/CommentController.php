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
        $validatedData = $request->validate([
            'content' => 'required|max:255',
            'user_id' => 'required|numeric',
            'post_id' => 'required|numeric'
        ]);
        if(Auth::check()){
            $post = Post::find($validatedData['post_id']);
            if($post != null && Auth::user()->id != $post->user_id){
                DB::table('comment')->insert([
                    'content' => $validatedData['content'],
                    'user_id' => $validatedData['user_id'],
                    'post_id' => $validatedData['post_id']
                ]);
                $comments = Comment::getPostComments($post_id);
                return Comment::commentsAsHtml($comments);
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
        $comment->delete();
    }

    public function addComment(Request $request,$post_id){//store?
        
    }

    public function editAction(Request $request,$comment_id){//update?
        $validatedData = $request->validate([
            'content' => 'required|max:255|min:1',
            'comment_id' => 'required|numeric'
        ]);
        DB::table('comment')->where('id',$comment_id)->update(['content' => $validatedData['content']]); 
    }


    public function destroyComment(Request $request,$comment_id){
        $comment = Comment::find($comment_id);
        destroy($comment);
    }

    public function threads(Request $request,$comment_id){
        $threads = DB::table('comment')->where('comment_id',$comment_id)->select('id','content','comment_date','user_id','post_id','comment_id')->get();
    }

    public function addThread(Request $request,$comment_id){
        $validatedData = $request->validate([
            'content' => 'required|max:255',
            'user_id' => 'required|numeric',
            'comment_id' => 'required|numeric'
        ]);
        if(Auth::check()){
            $comment = Comment::find($validatedData['comment_id']);
            if($comment != null && Auth::user()->id == $validatedData['user_id']){
                DB::table('comment')->insert([
                    'content' => $validatedData['content'],
                    'user_id' => $validatedData['user_id'],
                    'comment_id' => $validatedData['comment_id']
                ]);
                $comments = Comment::getPostComments($comment->post_id);
                return Comment::commentsAsHtml($comments);
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
