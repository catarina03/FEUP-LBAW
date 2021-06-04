<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Carbon\Carbon;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Contracts\View\View;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Policies\ReportPolicy;

class ReportController extends Controller
{
    /**
     * Display the specified resource.
     *
     * @param
     * @return
     */
    public function show()
    {
        if(!ReportPolicy::show()){
            return view('pages.nopermission', ['needsFilter' => 0]);
        }

        $user_id = Auth::user()->id;
        $reports = DB::select(DB::raw("(SELECT post.id AS post_id, title, post.user_id, name AS content_author, post.id AS content_id, 'Post' AS type, count(user_reporting) AS n_reports, most_frequent_motive.motive, user_assigned
                FROM report, post, authenticated_user, (SELECT post_reported, motive, count(motive) AS motive_freq FROM report WHERE comment_reported is null AND closed_date is null GROUP BY post_reported, motive) AS most_frequent_motive
                WHERE authenticated_user.id = post.user_id AND closed_date is null AND most_frequent_motive.post_reported = post.id AND most_frequent_motive.motive in (SELECT motive FROM report WHERE post_reported = post.id AND closed_date is null GROUP BY motive, post_reported ORDER BY COUNT(motive) DESC LIMIT 1) AND report.post_reported = post.id AND user_reporting <> " . $user_id . " AND (user_assigned = " . $user_id . " OR user_assigned is null)
                GROUP BY post.id, title, name, most_frequent_motive.motive, user_assigned, content_id)
                union
                (SELECT post.id AS post_id, title, post.user_id, name AS content_author, comment.id AS content_id, 'Comment' AS type, count(user_reporting) AS n_reports, most_frequent_motive.motive, user_assigned
                FROM report, post, comment, authenticated_user, (SELECT post_reported, motive, count(motive) AS motive_freq FROM report WHERE comment_reported is null AND closed_date is null GROUP BY post_reported, motive) AS most_frequent_motive
                WHERE authenticated_user.id = comment.user_id AND closed_date is null AND most_frequent_motive.post_reported = post.id AND most_frequent_motive.motive in (SELECT motive FROM report WHERE post_reported = post.id AND closed_date is null GROUP BY motive, post_reported ORDER BY COUNT(motive) DESC LIMIT 1) AND report.comment_reported = comment.id AND post.id = comment.post_id AND user_reporting <> " . $user_id . " AND (user_assigned = " . $user_id . " OR user_assigned is null)
                GROUP BY post.id, title, name, most_frequent_motive.motive, user_assigned, content_id)
                ORDER BY n_reports DESC"));

        return view('pages.moderator_dashboard', ['needsFilter' => 0, 'reports' => $reports]);
    }


    public function close(Request $request, $reported_content)
    {
        if(!ReportPolicy::show()){
            return view('pages.nopermission', ['needsFilter' => 0])->render();
        }

        $validatedData = Validator::make($request->all(), [
            'content_type' => 'required',
            'accepted' => 'required'
        ]);

        if (!$validatedData->fails()) {
            $type = $request['content_type'];
            $accepted = $request['accepted'];

            $date = Carbon::now();
            $closed_date = $date->toDateString();

            if ($type == "Post") {
                DB::table('report')->where('post_reported', $reported_content)->update(['closed_date' => $closed_date, 'accepted' => $accepted]);
                if($accepted){
                    $post = DB::table('post')->where('id', $reported_content);
                    if($post != null) $post->delete();
                }
            }
            else {
                DB::table('report')->where('comment_reported', $reported_content)->update(['closed_date' => $closed_date, 'accepted' => $accepted]);
                if($accepted){
                    $comment = DB::table('comment')->where('id', $reported_content);
                    if($comment != null) $comment->delete();
                }
            }
            return response()->json(array('id' => $reported_content, 'type' => $type));
        }

        $view = view('partials.moderator_card_actions', ['assigned' => true])->render();
        return response()->json(array('view' => $view, 'id' => $reported_content, 'type' => $request['content_type']), 400);
    }

    public function assign(Request $request, $reported_content)
    {
        if(!ReportPolicy::show()){
            return view('pages.nopermission', ['needsFilter' => 0])->render();
        }

        $validatedData = Validator::make($request->all(), [
            'content_type' => 'required'
        ]);

        if (!$validatedData->fails()) {
            $type = $request['content_type'];

            if ($type == "Post")
                DB::table('report')->where('post_reported', $reported_content)->update(array('user_assigned' => Auth::user()->id));
            else
                DB::table('report')->where('comment_reported', $reported_content)->update(array('user_assigned' => Auth::user()->id));

            $view = view('partials.moderator_card_actions', ['assigned' => true])->render();
            return response()->json(array('view' => $view, 'id' => $reported_content, 'type' => $type));
        }
        return response()->json()->setStatusCode(400);
    }

    public function reportMotives(Request $request, $reported_content)
    {
        if(!ReportPolicy::show()){
            return view('pages.nopermission', ['needsFilter' => 0])->render();
        }
        //select distinct motive from report where post_reported = 188 and closed_date is null
        $validatedData = Validator::make($request->all(), [
            'content_type' => 'required'
        ]);

        if (!$validatedData->fails()) {
            $type = $request['content_type'];

            if ($type == "Post")
                $motives = DB::table('report')->select('motive')->where('post_reported', $reported_content)->whereNull('closed_date')->distinct()->get();
            else
                $motives = DB::table('report')->select('motive')->where('comment_reported', $reported_content)->whereNull('closed_date')->distinct()->get();

            $view = view('partials.report_motives', ['motives' => $motives])->render();
            return response()->json(array('view' => $view, 'id' => $reported_content, 'type' => $type));
        }
        return response()->json()->setStatusCode(400);
    }

    public function filter(Request $request) {

        if(!ReportPolicy::show()){
            return view('pages.nopermission', ['needsFilter' => 0])->render();
        }

        $user_id = Auth::user()->id;

        $posts = "SELECT post.id AS post_id, title, type as post_type, category, post.user_id, name AS content_author, post.id AS content_id, 'Post' AS type, count(user_reporting) AS n_reports, most_frequent_motive.motive, user_assigned";
        $posts .= " FROM report, post, authenticated_user, (SELECT post_reported, motive, count(motive) AS motive_freq FROM report WHERE comment_reported is null AND closed_date is null GROUP BY post_reported, motive) AS most_frequent_motive";
        $posts .= " WHERE authenticated_user.id = post.user_id AND closed_date is null AND most_frequent_motive.post_reported = post.id AND most_frequent_motive.motive in (SELECT motive FROM report WHERE post_reported = post.id AND closed_date is null GROUP BY motive, post_reported ORDER BY COUNT(motive) DESC LIMIT 1) AND report.post_reported = post.id AND user_reporting ".htmlspecialchars_decode('<>').$user_id." AND (user_assigned = ".$user_id." OR user_assigned is null)";

        $comments = "SELECT post.id AS post_id, title, type as post_type, category, post.user_id, name AS content_author, comment.id AS content_id, 'Comment' AS type, count(user_reporting) AS n_reports, most_frequent_motive.motive, user_assigned";
        $comments .= " FROM report, post, comment, authenticated_user, (SELECT post_reported, motive, count(motive) AS motive_freq FROM report WHERE comment_reported is null AND closed_date is null GROUP BY post_reported, motive) AS most_frequent_motive";
        $comments .= " WHERE authenticated_user.id = comment.user_id AND closed_date is null AND most_frequent_motive.post_reported = post.id AND most_frequent_motive.motive in (SELECT motive FROM report WHERE post_reported = post.id AND closed_date is null GROUP BY motive, post_reported ORDER BY COUNT(motive) DESC LIMIT 1) AND report.comment_reported = comment.id AND post.id = comment.post_id AND user_reporting ".htmlspecialchars_decode('<>').$user_id." AND (user_assigned = ".$user_id." OR user_assigned is null)";

        if($request->has('category')) {
            if($request->input('category') == "TvShow") $category = "tv show";
            else $category = strtolower($request->input('category'));
            $posts .= " AND category = '".$category."'";
            $comments .= " AND category = '".$category."'";
        }

        if($request->has('type')) {
            $posts .= " AND type = '".strtolower($request->input('type'))."'";
            $comments .= " AND type = '".strtolower($request->input('type'))."'";
        }

        if($request->has('assign')) {
            if($request->input('assign') == "assign") $id = " = ".$user_id;
            else $id = " is null";
            $posts .= " AND user_assigned".$id;
            $comments .= " AND user_assigned".$id;
        }

        $posts .= " GROUP BY post.id, title, name, post_type, category, most_frequent_motive.motive, user_assigned, content_id";
        $comments .= " GROUP BY post.id, title, name, post_type, category, most_frequent_motive.motive, user_assigned, content_id";

        $posts = "(".$posts.")";
        $comments = "(".$comments.")";
        $total = $posts ." union ".$comments;

        if($request->has('content_type')) {
            if($request->input('content_type') == "Post") $total = $posts;
            else $total = $comments;
        }

        $reports =  DB::select(DB::raw($total." ORDER BY n_reports DESC"));
        $view = view('partials.moderator_card', ['reports' => $reports])->render();
        return response()->json($view);
    }


}
