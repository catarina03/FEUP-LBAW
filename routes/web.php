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



// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');


//Authenticated User
Route::get('user/{id}', 'UserController@show');
Route::delete('user/{id}', 'UserController@destroy');
Route::get('user/{id}/edit_bio', 'UserController@show_edit_bio');
Route::get('user/{id}/edit_bio', 'UserController@edit_bio');


Route::get('user/{id}/settings', 'UserController@edit');
Route::put('user/{id}/settings/edit_account', 'UserController@edit_account');
Route::put('user/{id}/settings/edit_social_networks', 'UserController@edit_social_networks');
Route::put('user/{id}/settings/edit_preferences', 'UserController@edit_preferences');
Route::put('user/{id}/settings/change_password', 'UserController@change_password');

Route::post('/api/user/{id}/follow', 'UserController@follow');
Route::delete('/api/user/{id}/follow', 'UserController@unfollow');
Route::post('/api/user/{id}/block', 'UserController@block');
Route::delete('/api/user/{id}/block', 'UserController@unblock');
Route::put('/api/user/{id}/edit_photo', 'UserController@update_photo');

//Post
Route::get('addpost', 'PostController@create')->name('addPost');
Route::post('addoist', 'PostController@store');
Route::get('post/{id}', 'PostController@show');
Route::delete('post/{id}', 'PostController@destroy');
Route::get('editpost', 'PostController@edit')->name('editPost');
Route::put('editpost', 'PostController@update');
Route::post('post/{id}/report', 'PostControllert@report');

Route::get('api/home/{homepageFilters}', 'PostController@filerHomePage');
Route::post('api/post/{id}/save', 'PostController@addSave');
Route::delete('api/post/{id}/save', 'PostController@deleteSave');
Route::post('api/post/{id}/vote', 'PostController@addVote');
Route::put('api/post/{id}/vote', 'PostController@editVote');
Route::delete('api/post/{id}/vote', 'PostController@deleteVote');



