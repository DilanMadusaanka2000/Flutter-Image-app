<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ImagePost extends Model
{
    use HasFactory;

    protected $table = 'image_posts'; // Ensure it matches your migration table name

    protected $fillable = ['image_url', 'comment']; // Specify which fields are mass assignable

    public $timestamps = true; // Ensures timestamps are managed properly
}
