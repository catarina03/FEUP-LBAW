<?php

namespace App\Http\Controllers;

use App\Http\Controllers\HelperController;
use App\Models\Post;
use App\Models\Photo;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\CommentPolicy;
use App\Policies\PostPolicy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;
use \Response;

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
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, $post_id)
    {
        $validator = Validator::make($request->all(),
            [
                'content' => ['required', 'string', 'max:1000', 'min:1'],
                'user_id' => ['required', 'numeric'],
                'post_id' => ['required', 'numeric'],
            ],
            [
                'content.required' => 'Content cannot be empty',
                'user_id.numeric' => 'UserID must be a number',
                'user_id.required' => 'UserID must be a number',
                'post_id.numeric' => 'PostID must be a number',
                'post_id.required' => 'PostID must be a number',
                'content.max' => 'Content is too big, max of 1000 characters',
                'content.min' => 'Content is too short, max of 1000 characters'
            ]);
        if ($validator->fails())
            return response()->setStatusCode(400);
        if (Auth::check()) {
            $post = Post::find($request->input('post_id'));
            if ($post != null && Auth::user()->id != $post->user_id) {
                $cid = DB::table('comment')->insertGetId([
                    'content' => $request->input('content'),
                    'user_id' => $request->input('user_id'),
                    'post_id' => $request->input('post_id')
                ]);
                return HelperController::single_commentAsHtml($cid, Auth::user()->id);
            }
            else{
                return response()->setStatusCode(403);
            }
        }
        return response()->json(['status' => "Error encountered when adding commment!"])->setStatusCode(401);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\Comment $comment
     * @return \Illuminate\Http\Response
     */
    public function destroy(Comment $comment)
    {
        return $comment->delete();
    }

    public function editForm(Request $request, $comment_id)
    {

        //Checagem de erros
        if (Auth::check()) {
            $comment = Comment::find($comment_id);
            if ($comment != null && Auth::user()->id == $comment->user_id) {
                return json_encode($comment);
            }
        }
        return "";
    }

    public function editAction(Request $request, $comment_id)
    {
        $validator = Validator::make($request->all(),
            [
                'content' => ['required', 'string', 'max:1000', 'min:1']
            ]);

        if ($validator->fails())
            return response()->setStatusCode(400);

        if (Auth::check()) {
            $comment = Comment::find($comment_id);
            $comment->timestamps = false;
            if ($comment != null && Auth::user()->id == $comment->user_id) {
                $comment->content = $request['content'];
                if ($comment->save())
                    return response()->json(["comment_view" => HelperController::single_commentAsHtml($comment_id, Auth::user()->id)->render()])->setStatusCode(200);
                return response()->setStatusCode(400);
            }
            else
                return response()->setStatusCode(403);
        }
        return response()->setStatusCode(401);
    }


    public function destroyComment(Request $request, $comment_id)
    {
        $comment = Comment::find($comment_id);
        if (Auth::check()) {
            if ($comment != null) {
                if (Auth::user()->id == $comment->user_id) {
                    return $this->destroy($comment) ? "SUCCESS" : "FAIL";
                }
            }
        }
        return "FAIL";
    }

    public function addThread(Request $request, $comment_id)
    {
        $validator = Validator::make($request->all(),
            [
                'content' => ['required', 'string', 'max:1000', 'min:1'],
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
        if ($validator->fails())
            return response()->setStatusCode(400);
        if (Auth::check()) {
            $comment = Comment::find($request->input('comment_id'));
            if ($comment != null && Auth::user()->id == $request->input('user_id')) {
                $cid = DB::table('comment')->insertGetId([
                    'content' => $request->input('content'),
                    'user_id' => $request->input('user_id'),
                    'comment_id' => $request->input('comment_id')
                ]);
                return HelperController::single_commentAsHtml($cid, Auth::user()->id);
            }
            else
                return response()->setStatusCode(403);
        }
        return response()->setStatusCode(401);

    }

    public function reportComment(Request $request, $comment_id)
    {
        $validatedData = $request->validate([
            'motive' => 'required'
        ]);

        $comment = Comment::find($comment_id);
        if(Auth::check()){
            if ($comment != null && Auth::user()->id != $comment->user_id) {
                DB::table('report')->insert([
                    'motive' => $validatedData['motive'],
                    'user_reporting' => Auth::user()->id,
                    'comment_reported' => $comment_id
                ]);
                return response()->json(['status' => "Comment reported!"])->setStatusCode(200);
            }
            else
                return response()->setStatusCode(403);
        }
        return response()->setStatusCode(401);
    }

    public function addVote(Request $request, $id)
    {
        $comment = Comment::find($id);
        if (!CommentPolicy::vote($comment)) return response()->json('Error', 400);

        $vote = $request["vote"] === "true";
        if (!is_bool($vote)) return response()->json('Error', 400);

        if ($comment != null) {
            DB::table("vote_comment")->insert([
                'user_id' => Auth::user()->id,
                'comment_id' => $id,
                'like' => $vote
            ]);
            return response()->json('Success');
        }

        return response()->json('Error', 400);
    }

    public function editVote(Request $request, $id)
    {
        $comment = Comment::find($id);
        if (!CommentPolicy::vote($comment)) return response()->json('No permissions', 400);

        $vote_entry = DB::table("vote_comment")
            ->where('user_id', Auth::user()->id)
            ->where('comment_id', $id)->get();

        $vote = $request["vote"] == "true";

        if($vote == null && $vote_entry == null && !is_bool($vote)) return response()->json('Error in vote', 400);

        DB::table("vote_comment")->where('user_id', Auth::user()->id)
            ->where('comment_id', $id)->update(['like' => $vote]);

        return response()->json($request["vote"]);
    }


    public function deleteVote($id)
    {
        $comment = Comment::find($id);
        if (!CommentPolicy::vote($comment)) return response()->json('Error', 400);

        if ($comment != null) {
            $vote = DB::table("vote_comment")
                ->where('user_id', Auth::user()->id)
                ->where('comment_id', $id);
            if ($vote != null) {
                if ($vote->delete()) return response()->json('Success');
            }
        }

        return response()->json('Error', 400);
    }

}
