<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PostController extends Controller
{
    // Semua postingan bisa dilihat siapa saja yang login
    public function index()
    {
        // Mengambil post beserta relasi user-nya dan memastikan photo user dimasukkan
        $posts = Post::with(['user' => function($query) {
            $query->select('user_id', 'username', 'photo');
        }])->orderBy('created_at', 'desc')->get();
        
        // Generate full URL for user photos
        $posts->transform(function ($post) {
            if ($post->user && $post->user->photo) {
                if (!str_starts_with($post->user->photo, 'http')) {
                    $post->user->photo = asset($post->user->photo);
                }
            }
            return $post;
        });
        
        return response()->json($posts);
    }

    // Buat postingan baru terkait user yang login
    public function store(Request $request)
    {
        $validated = $request->validate([
            'post_title'   => 'required|string|max:255',
            'post_content' => 'required|string',
            'post_image'   => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        if ($request->hasFile('post_image')) {
            // Simpan file gambar di folder 'images/posts' di storage/app/public
            $validated['post_image'] = $request->file('post_image')->store('images/posts', 'public');
        }

        $validated['created_at'] = now();
        $validated['user_id'] = $request->user()->user_id;

        $post = Post::create($validated);

        return response()->json($post, 201);
    }

    public function update(Request $request, Post $post)
    {
        $user = $request->user();

        if ($user->user_id !== $post->user_id && $user->role !== 'admin') {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'post_title'   => 'required|string|max:255',
            'post_content' => 'required|string',
            'post_image'   => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        if ($request->hasFile('post_image')) {
            // Hapus gambar lama jika ada
            if ($post->post_image) {
                Storage::disk('public')->delete($post->post_image);
            }
            // Simpan gambar baru
            $validated['post_image'] = $request->file('post_image')->store('images/posts', 'public');
        }

        $post->update($validated);

        return response()->json($post);
    }


    // Delete post hanya jika user pemilik atau admin
    public function destroy(Request $request, Post $post)
    {
        $user = $request->user();

        if ($user->user_id !== $post->user_id && $user->role !== 'admin') {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        if ($post->post_image) {
            Storage::disk('public')->delete($post->post_image);
        }

        $post->delete();

        return response()->json(['message' => 'Post deleted']);
    }
}
