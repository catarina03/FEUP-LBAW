<?php

namespace App\Http\Controllers;
use App\Models\Post;
use App\Models\AuthenticatedUser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Auth;

class PagesController extends Controller
{
    public function home()
    {
        $posts = Post::getTopPosts(1);
        foreach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count(); 

        }
        $slideshow = $this->slideshow();
        return view('pages.homepage', ['user' => 'system_manager', 'needsFilter' => 0, 'posts'=>$posts,'slideshow'=>$slideshow]);
    }

    public function slideshow(){
        $posts = Post::getSlideShowPosts();
        //DB::table('post')->limit(3)->get(); //ir buscar os 3 mais recentes com mais gostos
        
        forEach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
        }
        return $posts;
    }

    public function about()
    {
        return view('pages.about', ['user' => 'visitor', 'needsFilter' => 0] );
    }

    public function faq()
    {
        return view('pages.faq', ['user' => 'visitor', 'needsFilter' => 0] );
    }

    public function support()
    {
        return view('pages.support', ['user' => 'visitor', 'needsFilter' => 0] );
    }

    public function supportRequest(){
        //TODO
    }

    public function category($category){
        $posts = Post::orderBy('n_views', 'desc')->get();
        foreach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count(); 
        }
        if($category == "Music"){
            //$post = Post::find .... where category == music
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Music', 'posts' =>$posts]);
        }
        else if($category == "TVShow"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'TV Show', 'posts' =>$posts]);
        }
        else if($category == "Cinema"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Cinema', 'posts' =>$posts]);
        }
        else if($category == "Theatre"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Theatre', 'posts' =>$posts]);
        }
        else if($category == "Literature"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Literature', 'posts' =>$posts]);
        }   
        
    }

    public function advanced_search(){
        $posts = Post::orderBy('n_views', 'desc')->get();
        foreach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count(); 
        }
        return view('pages.advanced_search', ['user' => 'visitor', 'needsFilter' => 0, 'posts'=>$posts]);
    }

    public function list($homepageFilters){
        if($homepageFilters == "new"){
            $posts = Post::getNewPosts(1);//orderBy('created_at', 'desc')->limit(15)->get();
        }
        else if($homepageFilters == "hot"){
            $posts = Post::getHotPosts(1);//orderBy('n_views', 'desc')->limit(15)->get();
            
        }
        else{
            $posts = Post::getTopPosts(1);//orderBy('n_views', 'desc')->limit(15)->get(); //mais likes
        } 

        foreach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count(); 
        }

        return view('partials.allcards', ['posts' => $posts]);

    }

    public function loadMoreHomePage($filters, $page){

        if($homepageFilters == "new"){
            $posts = Post::getNewPosts($page);//orderBy('created_at', 'desc')->forPage($page, 15)->get();
        }
        else if($homepageFilters == "hot"){
            $posts = Post::getTopPosts($page);
        }
        else $posts = Post::getTopPosts($page);//orderBy('n_views', 'desc')->forPage($page, 15)->get(); //mais likes

        foreach($posts as $post){
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count(); 
        }

        return view('partials.allcards', ['posts' => $posts]);
    }

    public function postFilter($filters){
        return  redirect('/advanced_search');
    }

}
