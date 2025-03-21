<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ImagePost extends Model
{
    use HasFactory;

    protected $table = 'image_posts';

    protected $fillable = ['image_url', 'comment'];

    public $timestamps = true;
};
