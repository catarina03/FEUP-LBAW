<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Contracts\View\View;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Http\Response;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ReportController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {

    }

    /**
     * Display the specified resource.
     *
     * @param Report $report
     * @return Application|Factory|View|Response
     */
    public function show()
    {
        if (!Auth::check() || (Auth::check() && !Auth::user()->isAdmin())) {
            return view('pages.nopermission', ['needsFilter' => 0]);
        }

        $user_id = Auth::user()->id;
        //" . $user_id . "
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

        //print_r($reports);
        return view('pages.moderator_dashboard', ['needsFilter' => 0, 'reports' => $reports]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param Report $report
     * @return Response
     */
    public function edit(Report $report)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param Report $report
     * @return Response
     */
    public function update(Request $request, Report $report)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Report $report
     * @return Response
     */
    public function destroy(Report $report)
    {
        $report->delete();
    }


    public function close(Request $request, $report_id)
    {
        $validatedData = $request->validate([
            'moderator_id' => 'required|numeric'
        ]);
        $date = Carbon::now();
        $closed_date = $date->toDateString();
        DB::table('report')->where('id', $report_id)->where('user_assigned', $validatedData->moderator_id)->update(["closed_date" => $closed_date]);

    }

    public function assign(Request $request, $reported_content)
    {

        $validatedData = Validator::make($request->all(), [
            'content_type' => 'required'
        ]);


        if (!$validatedData->fails()) {
            $type = $request['content_type'];

            if($type == "Post")
                DB::table('report')->where('post_reported', $reported_content)->update(array('user_assigned' => Auth::user()->id));
            else
                DB::table('report')->where('comment_reported', $reported_content)->update(array('user_assigned' => Auth::user()->id));


            $view = view('partials.moderator_card_actions', ['assigned' => true])->render();
            return response()->json(array('view' => $view, 'id' => $reported_content, 'type' => $type));
        }
        return response()->json(404);
    }

    public function process(Request $request, $report_id)
    {//update?
        $validatedData = $request->validate([
            'moderator_id' => 'required|numeric',
            'action' => 'required'
        ]);
        $action = $validatedData->action == "DELETE" ? true : false;
        DB::table('report')->where('id', $report_id)->where('user_assigned', $validatedData->moderator_id)->update(["accepted" => $action]);
        $date = Carbon::now();
        $closed_date = $date->toDateString();
        DB::table('report')->where('id', $report_id)->where('user_assigned', $validatedData->moderator_id)->update(["closed_date" => $closed_date]);
    }
}
