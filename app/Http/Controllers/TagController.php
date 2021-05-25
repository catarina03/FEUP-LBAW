<?php

namespace App\Http\Controllers;

use App\Models\Tag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;

class TagController extends Controller
{
     /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Ta  $notification
     * @return \Illuminate\Http\Response
     */
    public function followTag(Request $request,$tag_id)
    {
        $tag = Tag::find($tag_id);
        if(Auth::check() && $tag != null){
            DB::table("follow_tag")->insert(["user_id"=>Auth::user()->id,"tag_id"=>$tag_id]);
            return "SUCCESS";
        }
        return "";
    }

    public function unfollowTag(Request $request,$tag_id)
    {
        
        if(Auth::check()){
            $tag = DB::table("follow_tag")->where("tag_id",$tag_id)->where("user_id",Auth::user()->id);
            if($tag!=null){
                if($tag->delete())
                    return "SUCCESS";
            }
        }
        return "";
    }
}
