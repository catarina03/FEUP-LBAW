<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// Home

Route::get('/', 'Auth\LoginController@home');


// API
Route::get('api/home/{homepageFilters}', 'PostController@filerHomePage');
Route::post('api/post/{id}/save', 'PostController@addSave');
Route::delete('api/post/{id}/save', 'PostController@deleteSave');
Route::post('api/post/{id}/vote', 'PostController@addVote');
Route::put('api/post/{id}/vote', 'PostController@editVote');
Route::delete('api/post/{id}/vote', 'PostController@deleteVote');


// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');


//Post
Route::get('addpost', 'PostController@create')->name('addPost');
Route::post('addoist', 'PostController@store');
Route::get('post/{id}', 'PostController@show');
Route::delete('post/{id}', 'PostController@destroy');
Route::get('editpost', 'PostController@edit')->name('editPost');
Route::put('editpost', 'PostController@update');
Route::post('post/{id}/report', 'PostControllert@report');

Route::get('/', function() {
    return view('pages.myprofile', ['user' => 'system_manager', 'needsFilter' => 0]);
});


