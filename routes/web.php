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

// Pages
Route::get('/', 'PagesController@home');
Route::get('/about', 'PagesController@about');
Route::get('/faq', 'PagesController@faq');
Route::get('/support', 'PagesController@support');
Route::post('/support', 'PagesController@supportRequest');
Route::get('/category/{category}', 'PagesController@category');
Route::get('api/home/{homepageFilters}', 'PagesController@list');
Route::get('search/{filters}', 'PagesController@advancedSearch');
Route::get('api/search', 'PagesController@loadMoreAdvancedSearch');
Route::get('api/loadMore/{filters}/{page}', 'PagesController@loadMoreHomepage');
Route::get('api/category/loadMore/{category}/{page}', 'PagesController@loadMoreCategoryPage');

// Admin
Route::get('administration/roles', 'UserController@roles');
Route::get('api/administration/roles', 'UserController@searchRoles');
Route::put('api/administration/roles/{user_id}/edit_role', 'UserController@editRole');


Route::get('api/report_filter','ReportController@reportFilter');
Route::post('api/post/{post_id}/add_comment','CommentController@store');
Route::get('api/comment/{comment_id}/edit','CommentController@editForm');
Route::put('api/comment/{comment_id}/edit','CommentController@editAction');
Route::delete('api/comment/{comment_id}','CommentController@destroyComment');
Route::get('api/comment/{comment_id}/thread','CommentController@threads');
Route::post('api/comment/{comment_id}/add_comment','CommentController@addThread');
Route::post('api/comment/{comment_id}/vote','CommentController@vote');
Route::put('api/comment/{comment_id}/vote', 'CommentController@editVote');

// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');

// Authenticated User
Route::get('user/{id}', 'UserController@show')->name('profile');
Route::delete('user/{id}', 'UserController@destroy');
Route::get('api/user/{id}/edit_bio', 'UserController@show_edit_bio');
Route::put('api/user/{id}/edit_bio', 'UserController@edit_bio');


Route::get('user/{id}/settings', 'UserController@edit');
Route::put('user/{id}/settings/edit_account', 'UserController@edit_account')->name('edit_account');
Route::put('user/{id}/settings/edit_social_networks', 'UserController@edit_social_networks')->name('edit_social_networks');
Route::put('user/{id}/settings/change_password', 'UserController@change_password')->name('change_password');
Route::put('user/{id}/settings/edit_preferences', 'UserController@edit_preferences')->name('edit_preferences');


Route::post('/api/user/{id}/follow', 'UserController@follow');
Route::delete('/api/user/{id}/follow', 'UserController@unfollow');
Route::post('/api/user/{id}/block', 'UserController@block');
Route::delete('/api/user/{id}/block', 'UserController@unblock');
Route::put('/api/user/{id}/edit_photo', 'UserController@update_photo');

// Post
Route::get('addpost', 'PostController@create');
Route::post('addpost', 'PostController@store');
Route::get('post/{id}', 'PostController@show');
Route::delete('post/{id}', 'PostController@destroy');
Route::get('editpost/{id}', 'PostController@edit');
Route::put('editpost/{id}', 'PostController@update');
Route::post('post/{id}/report', 'PostController@report');

Route::post('api/post/{id}/save', 'PostController@addSave');
Route::delete('api/post/{id}/save', 'PostController@deleteSave');
Route::post('api/post/{id}/vote', 'PostController@addVote');
Route::put('api/post/{id}/vote', 'PostController@editVote');
Route::delete('api/post/{id}/vote', 'PostController@deleteVote');

// Report
Route::get('moderator/reports', 'ReportController@show');
Route::put('reports/{report_id}/close', 'ReportController@close');
Route::put('reports/{report_id}/assign_report', 'ReportController@assign');
Route::put('reports/{report_id}/process', 'ReportController@process');

// Comment
Route::put('comment/{comment_id}/report', 'CommentController@reportComment');

// Sort comments
Route::get('api/post/{post_id}/popular_comments','PostController@popularComments');
Route::get('api/post/{post_id}/newer_comments','PostController@newerComments');
Route::get('api/post/{post_id}/older_comments','PostController@olderComments');
Route::get('api/post/{post_id}/load_more/{page}','PostController@loadMore');

