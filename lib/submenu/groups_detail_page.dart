import 'package:flutter/material.dart';
import 'models.dart';

class GroupsDetailPage extends StatelessWidget {
  final SportsGroup group;

  const GroupsDetailPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Group Detail",
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
                  image: NetworkImage(group.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              group.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.people, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${group.members} Members'),
                const SizedBox(width: 16),
                Icon(Icons.sports, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(group.sport),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Upcoming Events",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(group.events),
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
              child: const Center(child: Text('Join Group')),
            ),
          ],
        ),
      ),
    );
  }
}
