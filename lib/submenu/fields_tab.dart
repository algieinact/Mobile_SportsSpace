import 'package:flutter/material.dart';
import 'models.dart';
import 'fields_detail_page.dart';

class FieldsTab extends StatefulWidget {
  const FieldsTab({super.key});

  @override
  State<FieldsTab> createState() => _FieldsTabState();
}

class _FieldsTabState extends State<FieldsTab> {
  // Dummy data for fields
  final List<Field> _fields = [
    Field(
      id: '1',
      name: 'GOR Senayan',
      image: 'https://images.unsplash.com/photo-1504450758481-7338eba7524a',
      rating: 4.7,
      reviews: 128,
      location: 'Senayan, Jakarta Selatan',
      distance: '2.5 km',
      sports: ['Basket', 'Voli', 'Badminton'],
      price: 'Rp 150,000/jam',
    ),
    Field(
      id: '2',
      name: 'Futsal Zone Kemang',
      image:
          'https://images.unsplash.com/photo-1712325485668-6b6830ba814e?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      rating: 4.5,
      reviews: 89,
      location: 'Kemang, Jakarta Selatan',
      distance: '3.8 km',
      sports: ['Futsal'],
      price: 'Rp 200,000/jam',
    ),
    Field(
      id: '3',
      name: 'Velodrome',
      image: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f',
      rating: 4.8,
      reviews: 215,
      location: 'Rawamangun, Jakarta Timur',
      distance: '7.2 km',
      sports: ['Voli', 'Badminton', 'Basket'],
      price: 'Rp 120,000/jam',
    ),
    Field(
      id: '4',
      name: 'Soccer Field Kuningan',
      image: 'https://images.unsplash.com/photo-1489944440615-453fc2b6a9a9',
      rating: 4.4,
      reviews: 76,
      location: 'Kuningan, Jakarta Selatan',
      distance: '4.5 km',
      sports: ['Sepak Bola'],
      price: 'Rp 350,000/jam',
    ),
  ];

  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  // Add filters list
  final List<String> _filters = [
    'Semua',
    'Basket',
    'Futsal',
    'Badminton',
    'Sepak Bola',
    'Voli',
  ];

  List<Field> get _filteredFields {
    return _fields.where((field) {
      final matchesSearch = field.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == 'Semua' ||
          field.sports.contains(_selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Cari venue olahraga',
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
              children:
                  _filters.map((filter) {
                    final isSelected = _selectedCategory == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = filter;
                          });
                        },
                        backgroundColor: Colors.grey.shade200,
                        selectedColor: Colors.red.shade100,
                        checkmarkColor: Colors.red,
                        labelStyle: TextStyle(
                          color:
                              isSelected ? Colors.red.shade700 : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                isSelected
                                    ? Colors.red.shade300
                                    : Colors.transparent,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Fields Nearby
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Venue Terdekat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextButton(
                onPressed: () {
                  // See all venues
                },
                child: const Text('Lihat Semua'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Fields List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredFields.length,
            itemBuilder: (context, index) {
              final field = _filteredFields[index];
              return _buildFieldCard(field);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFieldCard(Field field) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Field Image
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(field.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Field Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        field.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          field.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' (${field.reviews})',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        field.location,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.directions, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      field.distance,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.sports, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        field.sports.join(', '),
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.payments, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      field.price,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => FieldsDetailPage(field: field),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Detail'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Book venue
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Booking'),
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
