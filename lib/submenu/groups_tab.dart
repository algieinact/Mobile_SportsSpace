import 'package:flutter/material.dart';
import 'models.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({Key? key}) : super(key: key);
  
  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  // Dummy data for sports groups
  final List<SportsGroup> _sportsGroups = [
    SportsGroup(
      id: '1',
      name: 'Jakarta Basketball Community',
      image: 'https://images.unsplash.com/photo-1608245449230-4ac19066d2d0',
      members: 452,
      sport: 'Basket',
      events: 'Setiap Kamis & Sabtu',
    ),
    SportsGroup(
      id: '2',
      name: 'Futsal Mania Jakarta',
      image: 'https://images.unsplash.com/photo-1543351611-58f69d7c1781',
      members: 328,
      sport: 'Futsal',
      events: 'Setiap Jumat & Minggu',
    ),
    SportsGroup(
      id: '3',
      name: 'Badminton Enthusiasts',
      image:
          'https://images.unsplash.com/photo-1599391398131-cd12dfc6c24e?q=80&w=2022&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      members: 186,
      sport: 'Badminton',
      events: 'Setiap Selasa & Minggu',
    ),
    SportsGroup(
      id: '4',
      name: 'Jakarta Runners',
      image: 'https://images.unsplash.com/photo-1643116774075-acc00caa9a7b',
      members: 573,
      sport: 'Lari',
      events: 'Setiap Sabtu & Minggu',
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
              hintText: 'Cari grup olahraga',
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

          // Filter Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryPill(
                  label: 'Semua',
                  isSelected: true,
                  onTap: () {},
                ),
                _buildCategoryPill(
                  label: 'Basket',
                  isSelected: false,
                  onTap: () {},
                ),
                _buildCategoryPill(
                  label: 'Futsal',
                  isSelected: false,
                  onTap: () {},
                ),
                _buildCategoryPill(
                  label: 'Badminton',
                  isSelected: false,
                  onTap: () {},
                ),
                _buildCategoryPill(
                  label: 'Lari',
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Popular Groups
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grup Populer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextButton(
                onPressed: () {
                  // See all groups
                },
                child: const Text('Lihat Semua'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Groups List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sportsGroups.length,
            itemBuilder: (context, index) {
              final group = _sportsGroups[index];
              return _buildGroupCard(group);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard(SportsGroup group) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // Group Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Image.network(
              group.image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // Group Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          group.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                          group.sport,
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
                        '${group.members} Anggota',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.event, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          group.events,
                          style: TextStyle(color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Join group
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Gabung'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}