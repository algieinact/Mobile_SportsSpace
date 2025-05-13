import 'package:flutter/material.dart';
import 'models.dart';

class FieldsDetailPage extends StatelessWidget {
  final Field field;

  const FieldsDetailPage({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Venue Detail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(field.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              field.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${field.rating} (${field.reviews} reviews)'),
                const SizedBox(width: 16),
                Icon(Icons.location_on, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(field.distance),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(field.location),
            const SizedBox(height: 16),

            const Text(
              "Available Sports",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children:
                  field.sports
                      .map(
                        (sport) => Chip(
                          label: Text(sport),
                          backgroundColor: Colors.red.withOpacity(0.1),
                          labelStyle: const TextStyle(color: Colors.red),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(child: Text('Book Now - ${field.price}')),
            ),
          ],
        ),
      ),
    );
  }
}
