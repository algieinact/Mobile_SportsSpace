import 'package:flutter/material.dart';
import 'models.dart';

class CommunityDetailPage extends StatelessWidget {
  final Community community;

  const CommunityDetailPage({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Community Detail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Community Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(community.foto.isNotEmpty
                      ? community.foto
                      : 'https://via.placeholder.com/400x200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Community Name
            Text(
              community.nama,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),

            // Community Details
            Row(
              children: [
                Icon(Icons.people, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${community.max_members} Anggota'),
                const SizedBox(width: 16),
                Icon(Icons.location_on, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${community.kota}, ${community.provinsi}'),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              "Deskripsi",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(community.deskripsi, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            // Join Button
            ElevatedButton(
              onPressed: () {
                // Join Community Action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(child: Text('Gabung Komunitas')),
            ),
          ],
        ),
      ),
    );
  }
}
