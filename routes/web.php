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

//Route::get('/', 'Auth\LoginController@home');

//Pages
Route::get('/', 'PagesController@home');
Route::get('/about', 'PagesController@about');
Route::get('/faq', 'PagesController@faq');
Route::get('/support', 'PagesController@support');
Route::post('/support', 'PagesController@supportRequest');
Route::get('/category/{category}', 'PagesController@category');
Route::get('api/home/{homepageFilters}', 'PagesController@filterHomePage');


//Admin 
Route::put('api/administration/roles/{user_id}/edit_role','UserController@editRole');//DONE
Route::get('api/post_filter','PostController@postFilter');  //queries
Route::get('api/report_filter','ReportController@reportFilter'); //?
Route::post('api/post/{post_id}/add_comment','CommentController@create'); //DONE
Route::get('api/comment/{comment_id}/edit','CommentController@editForm'); //??Informações para preencher o formulario?
Route::put('api/comment/{comment_id}/edit','CommentController@editAction'); //put ou patch? //DONE
Route::delete('api/comment/{comment_id}','CommentController@destroyComment');  //DONE
Route::get('api/comment/{comment_id}/thread','CommentController@threads'); //DONE
Route::post('api/comment/{comment_id}/add_comment','CommentController@addThread');//DONE
Route::post('api/comment/{comment_id}/vote','CommentController@vote');//DONE
//Route::delete('api/comment/{comment_id}/vote','CommentController@deleteVote');Apagar todos? a spec nao tem nenhum parametro alem de comment_id
Route::put('api/comment/{comment_id}/vote','CommentController@editVote');//DONE
//paginas estaticas????




// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');


//Authenticated User
Route::get('user/{id}', 'UserController@show');
Route::delete('user/{id}', 'UserController@destroy');
Route::get('api/user/{id}/edit_bio', 'UserController@show_edit_bio');
Route::put('api/user/{id}/edit_bio', 'UserController@edit_bio');


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
Route::get('addpost', 'PostController@create');
Route::post('addpost', 'PostController@store');
Route::get('post/{id}', 'PostController@show');
Route::delete('post/{id}', 'PostController@destroy');
Route::get('editpost/{id}', 'PostController@edit');
Route::put('editpost/{id}', 'PostController@update');
Route::post('post/{id}/report', 'PostControllert@report');

Route::post('api/post/{id}/save', 'PostController@addSave');
Route::delete('api/post/{id}/save', 'PostController@deleteSave');
Route::post('api/post/{id}/vote', 'PostController@addVote');
Route::put('api/post/{id}/vote', 'PostController@editVote');
Route::delete('api/post/{id}/vote', 'PostController@deleteVote');



//Report
Route::put('reports/{report_id}/close','ReportController@close'); //Done
Route::put('reports/{report_id}/assign_report','ReportController@assign');//Done
Route::put('reports/{report_id}/process','ReportController@process'); //Done

//Administration
Route::get('administration/roles','UserController@roles');//DONE

//Comment
Route::put('comment/{comment_id}/report','CommentController@reportComment'); //DONE

