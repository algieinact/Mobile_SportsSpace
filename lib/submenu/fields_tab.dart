import 'package:flutter/material.dart';
import 'models.dart';
import 'fields_detail_page.dart';
import '../api_service.dart';

class FieldsTab extends StatefulWidget {
  const FieldsTab({super.key});

  @override
  State<FieldsTab> createState() => _FieldsTabState();
}

class _FieldsTabState extends State<FieldsTab> {
  final ApiService _apiService = ApiService();
  List<Field> _fields = [];
  bool _isLoading = true;
  String _error = '';

  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  // Add filters list
  final List<String> _filters = [
    'Semua',
    'Futsal',
    'Basket',
    'Badminton',
    'Sepak Bola',
    'Voli',
  ];

  @override
  void initState() {
    super.initState();
    _fetchFields();
  }

  Future<void> _fetchFields() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final fieldsData = await _apiService.fetchFields();
      setState(() {
        _fields = fieldsData.map((data) => Field.fromJson(data)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load fields: $e';
        _isLoading = false;
      });
    }
  }

  List<Field> get _filteredFields {
    return _fields.where((field) {
      final matchesSearch = field.nama_lapangan.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesCategory = _selectedCategory == 'Semua' ||
          field.type == _selectedCategory.toLowerCase();
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
              children: _filters.map((filter) {
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
                      color: isSelected ? Colors.red.shade700 : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isSelected
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

          // Loading and Error States
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_error.isNotEmpty)
            Center(
              child: Column(
                children: [
                  Text(_error, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchFields,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          else if (_filteredFields.isEmpty)
            const Center(
              child: Text('No fields found'),
            )
          else ...[
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
                image: NetworkImage(field.foto.isNotEmpty
                    ? field.foto
                    : 'https://via.placeholder.com/400x200'),
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
                        field.nama_lapangan,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                        field.type.toUpperCase(),
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
                    Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        field.address,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${field.opening_hours} - ${field.closing_hours}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.payments, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Rp ${field.price.toString()}',
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
                              builder: (context) =>
                                  FieldsDetailPage(field: field),
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
