<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;
use Carbon\Carbon;

class ReportController extends Controller
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
        
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Report  $report
     * @return \Illuminate\Http\Response
     */
    public function show(Report $report)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Report  $report
     * @return \Illuminate\Http\Response
     */
    public function edit(Report $report)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Report  $report
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Report $report)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Report  $report
     * @return \Illuminate\Http\Response
     */
    public function destroy(Report $report)
    {
        $report->delete();
    }


    public function close(Request $request,$report_id){
        $validatedData = $request->validate([
            'moderator_id' => 'required|numeric'
        ]);
        $date = Carbon::now();
        $closed_date = $date->toDateString();
        DB::table('report')->where('id',$report_id)->where('user_assigned',$validatedData->moderator_id)->update(["closed_date" => $closed_date]);

    }

    public function assign(Request $request,$report_id){
        $validatedData = $request->validate([
            'moderator_id' => 'required|numeric'
        ]);
        DB::table('report')->where('id',$report_id)->update('user_assigned',$validatedData->moderator_id);

    }

    public function process(Request $request,$report_id){//update?
        $validatedData = $request->validate([
            'moderator_id' => 'required|numeric',
            'action' => 'required'
        ]);
        $action = $validatedData->action=="DELETE"? true : false;
        DB::table('report')->where('id',$report_id)->where('user_assigned',$validatedData->moderator_id)->update(["accepted" => $action]);
        $date = Carbon::now();
        $closed_date = $date->toDateString();
        DB::table('report')->where('id',$report_id)->where('user_assigned',$validatedData->moderator_id)->update(["closed_date" => $closed_date]);
    }
}
