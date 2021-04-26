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




//Post
Route::get('addpost', 'PostController@create')->name('addPost');
Route::post('addoist', 'PostController@store');
Route::get('post/{id}', 'PostController@show');
Route::delete('post/{id}', 'PostController@destroy');
Route::get('editpost', 'PostController@edit')->name('editPost');
Route::put('editpost', 'PostController@update');
Route::post('post/{id}/report', 'PostControllert@report');




//Report
Route::put('reports/{report_id}/close','ReportController@close'); //Done
Route::put('reports/{report_id}/assign_report','ReportController@assign');//Done
Route::put('reports/{report_id}/process','ReportController@process'); //Done
//Administration
Route::get('administration/roles','UserController@roles');//DONE

//Comment
Route::put('comment/{comment_id}/report','CommentController@reportComment'); //DONE




