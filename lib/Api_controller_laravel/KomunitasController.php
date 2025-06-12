<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Komunitas;


class KomunitasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Komunitas::with('user')->latest()->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
        'nama' => 'required',
        'jns_olahraga' => 'required',
        'max_members' => 'required',
        'provinsi' => 'required',
        'kota' => 'required',
        'deskripsi' => 'required',
        'foto' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        'sampul' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        'status' => 'required',
        ]);

        $validated['foto'] = $request->file('foto')->store('komunitas/foto', 'public');
        $validated['sampul'] = $request->file('sampul')->store('komunitas/sampul', 'public');   
        $komunitas = $request->user()->komunitas()->create($validated);

        return response()->json($komunitas, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Komunitas $komunitas)
    {
        return $komunitas;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Komunitas $komunitas)
    {
        // $komunitas = Komunitas::findOrFail($id);
        $user = $request->user();

        if ($user->id !== $komunitas->user_id && $user->role !== 'admin') {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $komunitas->update($request->only([
            'nama', 'jns_olahraga', 'max_members', 'provinsi', 'kota', 'deskripsi', 'foto', 'sampul', 'status'
        ]));

        return response()->json($komunitas);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, Komunitas $komunitas)
    {
        // $komunitas = Komunitas::findOrFail($id);
        $user = $request->user();

        if ($user->id !== $komunitas->user_id && $user->role !== 'admin') {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $komunitas->delete();
        return response()->json(['message' => 'Deleted']);
    }

}
