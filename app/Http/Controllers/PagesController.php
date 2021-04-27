<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PagesController extends Controller
{
    public function home()
    {
        return view('pages.homepage', ['user' => 'system_manager', 'needsFilter' => 0] );
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

    public function filterHomePage($homepageFilters){
        //TODO
    }

    public function category($category){
        
        if($category == "Music"){
            //$post = Post::find .... where category == music
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Music']);
        }
        else if($category == "TVShow"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'TV Show']);
        }
        else if($category == "Cinema"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Cinema']);
        }
        else if($category == "Theatre"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Theatre']);
        }
        else if($category == "Literature"){
            return view('pages.categorypage', ['user' => 'visitor', 'needsFilter' => 0, 'category' => 'Literature']);
        }   
        
    }

}
