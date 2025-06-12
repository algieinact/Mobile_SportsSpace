<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Lapangan;
use Illuminate\Support\Facades\Validator;

class LapanganController extends Controller
{
    public function index()
    {
        $lapangans = Lapangan::all();
        return response()->json($lapangans);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_lapangan' => 'required|string',
            'type' => 'required|in:Football,futsal,badminton,basket,jogging,volly',
            'categori' => 'required|in:paid,free',
            'opening_hours' => 'required',
            'closing_hours' => 'required',
            'fasility' => 'required|string',
            'price' => 'required|numeric',
            'description' => 'required|string',
            'address' => 'required|string',
            'foto' => 'nullable|image|max:2048'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = $request->except('foto');

        if ($request->hasFile('foto')) {
            $path = $request->file('foto')->store('lapangans', 'public');
            $data['foto'] = $path;
        }

        $lapangan = Lapangan::create($data);

        return response()->json([
            'message' => 'Lapangan berhasil dibuat',
            'data' => $lapangan
        ], 201);
    }

    public function show($id)
    {
        $lapangan = Lapangan::find($id);

        if (!$lapangan) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        return response()->json($lapangan);
    }

    public function update(Request $request, $id)
    {
        $lapangan = Lapangan::find($id);

        if (!$lapangan) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        $validator = Validator::make($request->all(), [
            'nama_lapangan' => 'sometimes|string',
            'type' => 'sometimes|in:Football,futsal,badminton,basket,jogging,volly',
            'categori' => 'sometimes|in:paid,free',
            'opening_hours' => 'sometimes',
            'closing_hours' => 'sometimes',
            'fasility' => 'sometimes|string',
            'price' => 'sometimes|numeric',
            'description' => 'sometimes|string',
            'address' => 'sometimes|string',
            'foto' => 'nullable|image|max:2048'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = $request->except('foto');

        if ($request->hasFile('foto')) {
            $path = $request->file('foto')->store('lapangans', 'public');
            $data['foto'] = $path;
        }

        $lapangan->update($data);
        $lapangan->refresh();
        

        return response()->json([
            'message' => 'Lapangan berhasil diperbarui',
            'data' => $lapangan
        ]);
    }


    public function destroy($id)
    {
        $lapangan = Lapangan::find($id);

        if (!$lapangan) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        $lapangan->delete();

        return response()->json(['message' => 'Lapangan berhasil dihapus']);
    }
}
