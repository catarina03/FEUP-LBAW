<?php

namespace App\Http\Controllers;
use App\Models\Post;
use Illuminate\Support\Facades\Auth;
use App\Models\AuthenticatedUser;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;


class PagesController extends Controller
{
    public function home(){
        $p = Post::getPostsOrdered("top", 1);
        $posts = $this->getPostsInfo($p);
        $slideshow = $this->slideshow();
        $n_posts = Post::count();
        return view('pages.homepage', ['needsFilter' => 1, 'posts'=>$posts, 'slideshow'=>$slideshow, 'n_posts' => $n_posts]);
    }

    public function slideshow(){
        return $posts = $this->getPostsInfo(Post::getSlideShowPosts());
    }

    public function about(){
        return view('pages.about', ['needsFilter' => 0] );
    }

    public function faq(){
        return view('pages.faq', ['needsFilter' => 0] );
    }

    public function support(){
        return view('pages.support', ['needsFilter' => 0] );
    }

    public function supportRequest(){
        //TODO
    }

    public function category(Request $request){
        $category = $request->input('category');
        if($category == "Music") $posts = Post::where('category', 'music')->paginate(15,'*', 'page', 1);
        else if($category == "TVShow") $posts = Post::where('category', 'tv show')->paginate(15,'*', 'page', 1);
        else if($category == "Cinema") $posts = Post::where('category', 'cinema')->paginate(15,'*', 'page', 1);
        else if($category == "Theatre") $posts = Post::where('category', 'theatre')->paginate(15,'*', 'page', 1);
        else if($category == "Literature") $posts = Post::where('category', 'literature')->paginate(15,'*', 'page', 1);

        $n_posts = $posts->total();
        $posts = $this->getPostsInfo($posts);
        if($category == "TVShow") return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'TV Show', 'posts' =>$posts, 'n_posts' => $n_posts]);

        return view('pages.categorypage', ['needsFilter' => 1, 'category' => $category, 'posts' =>$posts, 'n_posts' => $n_posts]);

    }

    public function list($homepageFilters){
        $p = Post::getPostsOrdered($homepageFilters, 1);
        $posts = $this->getPostsInfo($p);
        $n_posts = Post::count();
        return response()->json(array('posts'=>view('partials.allcards', ['posts' => $posts, 'n_posts' => $n_posts])->render(),'n_posts' => $n_posts));
    }

    public function loadMoreHomepage($filters, $page){
        $p = Post::getPostsOrdered($filters, $page);
        $posts = $this->getPostsInfo($p);
        $n_posts = Post::count();
        return response()->json(array('posts'=>view('partials.allcards', ['posts' => $posts])->render(), 'n_posts'=> $n_posts));
    }

    public function loadMoreCategoryPage($category, $page){
        if($category == "Music") $p = Post::where('category', 'music')->paginate(15,'*', 'page', $page);
        else if($category == "TVShow") $p = Post::where('category', 'tv show')->paginate(15,'*', 'page', $page);
        else if($category == "Cinema") $p = Post::where('category', 'cinema')->paginate(15,'*', 'page', $page);
        else if($category == "Theatre") $p = Post::where('category', 'theatre')->paginate(15,'*', 'page', $page);
        else if($category == "Literature") $p = Post::where('category', 'literature')->paginate(15,'*', 'page', $page);

        $posts = $this->getPostsInfo($p);
        return response()->json(array('posts'=> view('partials.allcards', ['posts' => $posts])->render(), 'number_res'=> $p->total()));
    }


    public function advancedSearch(Request $request){
        $p = $this->filter($request,1);
        $posts = $this->getPostsInfo($p);

        return view('pages.advanced_search', ['needsFilter'=> 1,'posts' => $posts, 'number_res'=> $p->total()])->render();
    }

    public function loadMoreAdvancedSearch(Request $request){
        $p = $this->filter($request);
        $posts = $this->getPostsInfo($p);

        return response()->json(array('posts'=> view('partials.allcards', ['posts' => $posts])->render(), 'number_res'=> $p->total()));
    }

    public function filter(Request $request){
        $date = date("m/d/Y", time());
        $query = Post::where('created_at', '<=', $date);

        if($request->has('search')){
            $s = trim($request->input('search'));
            $query->when(!empty($s), function($q) use ($s){
                return $q->whereRaw('search @@ plainto_tsquery(\'english\', ?)', [$s])
                    ->orderByRaw('ts_rank(search, plainto_tsquery(\'english\', ?)) DESC', [$s]);
            });
        }
        if($request->has('type')){
            $query->where('type', strtolower($request->input('type')));
        }
        if($request->has('category')){
            $query->where('category', strtolower($request->input('category')));
        }
        if($request->has('startDate')){
            $query->where('created_at', '>=',date("m/d/Y", strtotime($request->input('startDate'))));
        }
        if($request->has('endDate')){
            $query->where('created_at', '<=',date("m-d-Y", strtotime($request->input('endDate'))));
        }
        if($request->has('peopleFollow')){
            if($request->input('peopleFollow') == "true"){
                $ids = DB::table("follow_user")->where("following_user",Auth::user()->id)->value('followed_user');
                $query->whereIn('user_id', $ids);
            }
        }
        if($request->has('tagFollow')){
            if($request->input('tagFollow') == "true") {
                $tags = DB::table("follow_tag")->where("authenticatedUser_id", Auth::user()->id)->value('tag_id');
                $posts = DB::table('post_tag')->whereIn('tag_id', $tags)->value('post_id');
                $query->whereIn('id', $posts);
            }
        }
        if($request->has('myPosts')){
            if($request->input('tagFollow') == "true") {
                $query->where('user_id', Auth::user()->id);
            }
        }
        return $query->paginate(15,'*', 'page', $request->input('page'));
    }

    public function getPostsInfo($posts){
        foreach($posts as $post){
            $post->thumbnail = "/images/".$post->thumbnail;
            $post->author = AuthenticatedUser::find($post->user_id)->name;
            $post->likes = DB::table("vote_post")->where("post_id",$post->id)->where("like",true)->get()->count();
            if(Auth::check()){
                //$save = DB::table("saved_by")->where("post_id",$post->id)->where("authenticatedUser_id", Auth::user()->id)->get();
                //if($save != null) $post->saved = true;
                //else
                $post->saved = false;
            }
            else $post->saved = false;
        }
        return $posts;
    }

}
