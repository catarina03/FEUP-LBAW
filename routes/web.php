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
// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');


// Pages
Route::get('/', 'Auth\LoginController@home');
Route::get('/', 'PagesController@home')->name("homepage");
Route::get('/about', 'PagesController@about');
Route::get('/faq', 'PagesController@faq');
Route::get('/support', 'PagesController@support');
Route::post('/support', 'PagesController@supportRequest');
Route::get('/category/{category}', 'PagesController@category');
Route::get('search/{filters}', 'PagesController@advancedSearch');
Route::get('api/home/{homepageFilters}', 'PagesController@list');
Route::get('api/search', 'PagesController@loadMoreAdvancedSearch');
Route::get('api/loadMore/{filters}/{page}', 'PagesController@loadMoreHomepage');
Route::get('api/category/loadMore/{category}/{page}', 'PagesController@loadMoreCategoryPage');

// Admin
Route::get('administration/roles', 'UserController@roles');
Route::get('api/administration/roles', 'UserController@searchRoles');
Route::put('api/administration/roles/{user_id}/edit_role', 'UserController@editRole');


Route::prefix('api/comment/')->group(function () { //comment api
    Route::get('{comment_id}/edit', 'CommentController@editForm');
    Route::put('{comment_id}/edit', 'CommentController@editAction');
    Route::delete('{comment_id}', 'CommentController@destroyComment');
    Route::get('{comment_id}/thread', 'CommentController@threads');
    Route::post('{comment_id}/add_comment', 'CommentController@addThread');
    Route::post('{comment_id}/vote', 'CommentController@addVote');
    Route::put('{comment_id}/vote', 'CommentController@editVote');
    Route::delete('{comment_id}/vote', 'CommentController@deleteVote');
});


Route::prefix('user/')->group(function () { //user
    Route::get('{id}', 'UserController@show')->name('profile');
    Route::delete('{id}', 'UserController@destroy');
    Route::get('{id}/settings', 'UserController@edit');
    Route::put('{id}/settings/edit_account', 'UserController@edit_account')->name('edit_account');
    Route::put('{id}/settings/edit_social_networks', 'UserController@edit_social_networks')->name('edit_social_networks');
    Route::put('{id}/settings/change_password', 'UserController@change_password')->name('change_password');
    Route::put('{id}/settings/edit_preferences', 'UserController@edit_preferences')->name('edit_preferences');
});

Route::prefix('/api/user/')->group(function () { //user api
    Route::post('{id}/follow', 'UserController@follow');
    Route::delete('{id}/follow', 'UserController@unfollow');
    Route::post('{id}/block', 'UserController@block');
    Route::delete('{id}/block', 'UserController@unblock');
    Route::put('{id}/edit_photo', 'UserController@update_photo');
    Route::get('{id}/edit_bio', 'UserController@show_edit_bio');
    Route::put('{id}/edit_bio', 'UserController@edit_bio');
});


// Post
Route::get('addpost', 'PostController@create');
Route::post('addpost', 'PostController@store');
Route::get('post/{id}', 'PostController@show');
Route::delete('post/{id}', 'PostController@destroy');
Route::get('editpost/{id}', 'PostController@edit');
Route::put('editpost/{id}', 'PostController@update');
Route::post('post/{id}/report', 'PostController@report');

Route::prefix('api/post/')->group(function () { //post api
    Route::post('{id}/save', 'PostController@addSave');
    Route::delete('{id}/save', 'PostController@deleteSave');
    Route::post('{id}/vote', 'PostController@addVote');
    Route::put('{id}/vote', 'PostController@editVote');
    Route::delete('{id}/vote', 'PostController@deleteVote');
    Route::get('{post_id}/popular_comments', 'PostController@popularComments');
    Route::get('{post_id}/newer_comments', 'PostController@newerComments');
    Route::get('{post_id}/older_comments', 'PostController@olderComments');
    Route::get('{post_id}/load_more/{page}', 'PostController@loadMore');
    Route::post('{post_id}/add_comment', 'CommentController@store');
});

// Report
Route::get('moderator/reports', 'ReportController@show');
Route::get('moderator/reports/{filters}', 'ReportController@filter');
Route::put('reports/{reported_content}/close', 'ReportController@close');
Route::put('api/reports/{reported_content}/assign_report', 'ReportController@assign');
Route::post('api/reports/{reported_content}/motives', 'ReportController@reportMotives');
Route::put('reports/{reported_content}/process', 'ReportController@process');
Route::get('api/report_filter', 'ReportController@reportFilter');
Route::post('comment/{comment_id}/report', 'CommentController@reportComment');

Route::prefix('api/tag/')->group(function () { //tag api
    Route::post('{tag_id}/follow', 'TagController@followTag');
    Route::delete('{tag_id}/follow', 'TagController@unfollowTag');
});
