import 'package:flutter/material.dart';
import 'models.dart';

class CommunitiesTab extends StatefulWidget {
  const CommunitiesTab({Key? key}) : super(key: key);

  @override
  State<CommunitiesTab> createState() => _CommunitiesTabState();
}

class _CommunitiesTabState extends State<CommunitiesTab> {
  // Dummy data for communities
  final List<Community> _communities = [
    Community(
      id: '1',
      name: 'Basket Senayan',
      image: 'https://images.unsplash.com/photo-1546519638-68e109498ffc',
      members: 18,
      sport: 'Basket',
      nextEvent: 'Besok, 16:00',
    ),
    Community(
      id: '2',
      name: 'Futsal Kemang',
      image: 'https://images.unsplash.com/photo-1552667466-07770ae110d0',
      members: 14,
      sport: 'Futsal',
      nextEvent: 'Sabtu, 19:00',
    ),
    Community(
      id: '3',
      name: 'Badminton Weekenders',
      image: 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea',
      members: 12,
      sport: 'Badminton',
      nextEvent: 'Minggu, 08:00',
    ),
    Community(
      id: '4',
      name: 'Morning Run Club',
      image: 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5',
      members: 26,
      sport: 'Lari',
      nextEvent: 'Setiap Sabtu, 06:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari komunitas',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Active Communities
          const Text(
            'Komunitas Aktif',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),

          // Communities List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _communities.length,
            itemBuilder: (context, index) {
              final community = _communities[index];
              return _buildCommunityCard(community);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(Community community) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Community Image
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(community.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Community Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      community.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        community.sport,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.people, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${community.members} Anggota',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Event: ${community.nextEvent}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // View Community
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Lihat'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Join Community
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Gabung'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}