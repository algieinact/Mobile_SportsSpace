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
          "Detail Grup",
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
            Text(
              group.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),
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
                group.jenis_olahraga,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Informasi Acara",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.calendar_today, 'Tanggal', group.event_date),
            _buildInfoRow(Icons.access_time, 'Waktu',
                '${group.start_time} - ${group.end_time}'),
            _buildInfoRow(
                Icons.location_on, 'Lokasi', '${group.city}, ${group.address}'),
            _buildInfoRow(Icons.people, 'Kapasitas',
                '${group.current_members}/${group.kapasitas_maksimal} Anggota'),
            _buildInfoRow(Icons.payment, 'Biaya', 'Rp ${group.payment_amount}'),
            _buildInfoRow(
                Icons.payment, 'Metode Pembayaran', group.payment_method),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement join group functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Fitur bergabung akan segera hadir!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(child: Text('Bergabung')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
