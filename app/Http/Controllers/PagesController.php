<?php

namespace App\Http\Controllers;
use App\Models\Post;
use App\Models\AuthenticatedUser;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Auth;

class PagesController extends Controller
{
    public function home()
    {
        $p = Post::getTopPosts(1);
        $posts = $this->getPostsInfo($p);
        $slideshow = $this->slideshow();

        return view('pages.homepage', ['user' => 'system_manager', 'needsFilter' => 0, 'posts'=>$posts,'slideshow'=>$slideshow]);
    }

    public function slideshow(){
        $posts = Post::getSlideShowPosts();
        return $this->getPostsInfo($posts);
    }

    public function about(){
        return view('pages.about', ['user' => 'visitor', 'needsFilter' => 0] );
    }

    public function faq(){
        return view('pages.faq', ['user' => 'visitor', 'needsFilter' => 0] );
    }

    public function support(){
        return view('pages.support', ['user' => 'visitor', 'needsFilter' => 0] );
    }

    public function supportRequest(){
        //TODO
    }

    public function category(Request $request){
        $category = $request->input('category');
        if($category == "Music") $posts = Post::where('category', 'music')->forPage(1,15)->get();
        else if($category == "TVShow") $posts = Post::where('category', 'tv show')->forPage(1,15)->get();
        else if($category == "Cinema") $posts = Post::where('category', 'cinema')->forPage(1,15)->get();
        else if($category == "Theatre") $posts = Post::where('category', 'theatre')->forPage(1,15)->get();
        else if($category == "Literature") $posts = Post::where('category', 'literature')->forPage(1,15)->get();

        $posts = $this->getPostsInfo($posts);
        if($category == "TVShow") return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'TV Show', 'posts' =>$posts]);

        return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => $category, 'posts' =>$posts]);

    }

    public function list($homepageFilters){
        if($homepageFilters == "new") $p = Post::getNewPosts(1);
        else if($homepageFilters == "hot") $p = Post::getHotPosts(1);
        else $p = Post::getTopPosts(1);

        $posts = $this->getPostsInfo($p);

        return view('partials.allcards', ['posts' => $posts]);

    }

    public function loadMoreHomepage($filters, $page){
        if($filters == "new") $p = Post::getNewPosts($page);
        else if($filters == "hot") $p = Post::getHotPosts($page);
        else $p = Post::getTopPosts($page);

        $posts = $this->getPostsInfo($p);

        return view('partials.allcards', ['posts' => $posts]);
    }

    public function loadMoreCategoryPage($category, $page){
        if($category == "Music") $posts = Post::where('category', 'music')->forPage($page,15)->get();
        else if($category == "TVShow") $posts = Post::where('category', 'tv show')->forPage($page,15)->get();
        else if($category == "Cinema") $posts = Post::where('category', 'cinema')->forPage($page,15)->get();
        else if($category == "Theatre") $posts = Post::where('category', 'theatre')->forPage($page,15)->get();
        else if($category == "Literature") $posts = Post::where('category', 'literature')->forPage($page,15)->get();

        $posts = $this->getPostsInfo($posts);
        return view('partials.allcards', ['posts' => $posts]);
    }


    public function advancedSearch(Request $request){
        //thinking about calling this function everytime a advanced search is made
       /* $filters = json_decode($f);

        if(isset($filters['search'])) $final_filters['search'] = $filters['search'];
        else $final_filters['search']  = "";
        if(isset($filters['type'])) $final_filters['type'] = $filters['type'];
        else $final_filters['type']  = "";
        if(isset($filters['startDate'])) $final_filters['startDate'] = $filters['startDate'];
        else $final_filters['startDate']  = "";
        if(isset($filters['endDate'])) $final_filters['endDate'] = $filters['endDate'];
        else $final_filters['endDate']  = "";
        if(isset($filters['peopleFollow'])) $final_filters['peopleFollow'] = $filters['endDate'];
        else $final_filters['peopleFollow']  = "";
        if(isset($filters['tagFollow'])) $final_filters['$tagFollow'] = $filters['tagFollow'];
        else $final_filters['tagFollow']  = "";
        if(isset($filters['category'])) $final_filters['category'] = $filters['category'];
        else $final_filters['category']  = "";


        return json_encode($final_filters);*/

        $posts = Post::where('category', 'music')->forPage(0,15)->get();
        $posts = $this->getPostsInfo($posts);

        return  json_encode(array('posts'=> view('partials.allcards', ['posts' => $posts]), 'number_res'=>count($posts)));
    }

    public function showAdvancedSearch(Request $request){
        $posts = [];
        $type = $request->input('type');
        $search = $request->input('search');
        if(!empty($search)){
           // $posts
        }
       /* if(!empty($type)){
            $posts = DB::table('post')->where('type', $type)->get();
        }

        if(!empty($search)){
            //query to search
        }*/

        //query para filtrar
        //contar o n de resultados
        //coloacar nos filtros os filtros recebidos
        //fazer cena do load
        $posts = Post::orderBy('n_views', 'desc')->get();
        $posts = $this->getPostsInfo($posts);
        return view('pages.advanced_search', ['user' => 'visitor', 'needsFilter' => 0, 'posts' => $posts]);
    }

    public function getPostsInfo($posts){
        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
        }
        return $posts;
    }

}
