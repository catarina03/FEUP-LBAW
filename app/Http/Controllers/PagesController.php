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
        $posts = Post::getTopPosts(0);
        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();

        }
        $slideshow = $this->slideshow();
        return view('pages.homepage', ['needsFilter' => 1, 'posts'=>$posts, 'slideshow'=>$slideshow]);
    }

    public function slideshow(){
        $posts = Post::getSlideShowPosts();

        forEach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
        }
        return $posts;
    }

    public function about()
    {
        return view('pages.about', ['needsFilter' => 0] );
    }

    public function faq()
    {
        return view('pages.faq', ['needsFilter' => 0] );
    }

    public function support()
    {
        return view('pages.support', ['needsFilter' => 0] );
    }

    public function supportRequest(){
        //TODO
    }

    public function category($category){
        if($category == "Music") $posts = Post::where('category', 'music')->get();
        else if($category == "TVShow") $posts = Post::where('category', 'tv show')->get();
        else if($category == "Cinema") $posts = Post::where('category', 'cinema')->get();
        else if($category == "Theatre") $posts = Post::where('category', 'theatre')->get();
        else if($category == "Literature") $posts = Post::where('category', 'literature')->get();


        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
        }
        if($category == "TVShow") return view('pages.categorypage', ['needsFilter' => 1, 'category' => 'TV Show', 'posts' =>$posts]);

        return view('pages.categorypage', ['needsFilter' => 1, 'category' => $category, 'posts' =>$posts]);

    }

    public function advanced_search(){
        //TO DO
        $posts = Post::orderBy('n_views', 'desc')->get();
        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
        }
        return view('pages.advanced_search', ['needsFilter' => 0, 'posts'=>$posts]);
    }

    public function list($homepageFilters){
        if($homepageFilters == "new") $posts = Post::getNewPosts(0);
        else if($homepageFilters == "hot") $posts = Post::getHotPosts(0);
        else $posts = Post::getTopPosts(0);

        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
        }

        return view('partials.allcards', ['posts' => $posts]);

    }

    public function loadMoreHomepage($filters, $page){

        if($filters == "new") $posts = Post::getNewPosts($page);
        else if($filters == "hot") $posts = Post::getHotPosts($page);
        else $posts = Post::getTopPosts($page);

        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
        }

        return view('partials.allcards', ['posts' => $posts]);
    }

    public function postFilter($filters){
        return  redirect('/advanced_search');
    }

}
