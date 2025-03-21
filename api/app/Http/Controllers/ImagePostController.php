<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\ImagePost;
use Illuminate\Support\Facades\Storage;


class ImagePostController extends Controller
{
    public function store(Request $request)
    {
        // Validate request
        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'comment' => 'required|string|max:255',
        ]);

        // Upload image to the public/images directory
        $image = $request->file('image');
        $imageName = time() . '.' . $image->getClientOriginalExtension();
        $imagePath = $image->move(public_path('images'), $imageName);  // Move to public/images folder

        // Store image URL and comment in the database
        $upload = new ImagePost();
        $upload->image_url = 'images/' . $imageName;  // Save relative path
        $upload->comment = $request->comment;
        $upload->save();

        return response()->json([
            'message' => 'Image uploaded successfully!',
            'data' => $upload
        ], 200);
    }

    public function index()
    {
        $uploads = ImagePost::all();
        return response()->json($uploads);
    }
}
