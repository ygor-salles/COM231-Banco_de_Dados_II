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

Route::get('/', function () {
    return view('auth.login');
});

Auth::routes(['verify' => true]);

Route::get('/home', 'HomeController@index');
Route::get('/relatorio-1', 'HomeController@relatorio1');
Route::get('/relatorio-2', 'HomeController@relatorio2');
Route::get('/relatorio-3', 'HomeController@relatorio3')->middleware('regular');
Route::get('/relatorio-4', 'HomeController@relatorio4')->middleware('regular');
Route::get('/relatorio-5', 'HomeController@relatorio5')->middleware('regular');
