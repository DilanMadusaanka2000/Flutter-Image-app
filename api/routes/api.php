<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ImagePostController;

Route::get('/test', function () {
    return response()->json(['message' => 'API Route Working']);
});


//api route
Route::post('/upload', [ImagePostController::class, 'store']);
Route::get('/images', [ImagePostController::class, 'index']);
