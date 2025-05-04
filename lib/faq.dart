import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  // List of FAQ items
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'Apa itu SportsSpace?',
      answer: 'SportsSpace adalah platform untuk mencari teman olahraga, komunitas, dan venue olahraga di sekitar Anda. Aplikasi ini memungkinkan Anda untuk bergabung dengan komunitas olahraga, mencari venue, dan berinteraksi dengan sesama penggemar olahraga.',
    ),
    FAQItem(
      question: 'Bagaimana cara bergabung dengan komunitas?',
      answer: 'Untuk bergabung dengan komunitas, Anda dapat mengunjungi tab "Komunitas", pilih komunitas yang ingin Anda ikuti, dan klik tombol "Gabung". Anda akan langsung menjadi anggota dan dapat berpartisipasi dalam diskusi dan kegiatan komunitas tersebut.',
    ),
    FAQItem(
      question: 'Bagaimana cara booking venue olahraga?',
      answer: 'Untuk memesan venue olahraga, buka tab "Fields", pilih venue yang ingin Anda pesan, lalu klik tombol "Book Now". Anda akan diarahkan ke halaman pemesanan di mana Anda dapat memilih tanggal, waktu, dan melakukan pembayaran.',
    ),
    FAQItem(
      question: 'Bagaimana cara membuat post di feed?',
      answer: 'Untuk membuat post, kunjungi tab "Feed" dan tulis di kotak teks yang tersedia di bagian atas. Anda dapat menambahkan foto, lokasi, dan jenis olahraga ke postingan Anda sebelum menekan tombol "Post".',
    ),
    FAQItem(
      question: 'Apakah saya bisa membuat grup olahraga sendiri?',
      answer: 'Ya, Anda dapat membuat grup olahraga sendiri. Kunjungi tab "Groups", lalu klik tombol "+" di pojok kanan bawah. Isi informasi grup seperti nama, deskripsi, jenis olahraga, dan foto grup, lalu klik "Buat Grup".',
    ),
    FAQItem(
      question: 'Bagaimana cara mencari teman olahraga?',
      answer: 'Anda dapat mencari teman olahraga dengan bergabung dengan komunitas yang sesuai dengan minat Anda, atau dengan membuat postingan di feed yang mencari teman untuk berolahraga bersama. Anda juga dapat menggunakan fitur "Pencarian" untuk menemukan pengguna lain berdasarkan lokasi atau jenis olahraga.',
    ),
    FAQItem(
      question: 'Apakah aplikasi ini gratis?',
      answer: 'Ya, aplikasi SportsSpace gratis untuk diunduh dan digunakan. Namun, untuk beberapa fitur premium seperti pemesanan venue atau pembuatan grup tanpa batas mungkin memerlukan biaya tambahan.',
    ),
    FAQItem(
      question: 'Bagaimana jika ada masalah dengan aplikasi?',
      answer: 'Jika Anda mengalami masalah dengan aplikasi, silakan hubungi tim dukungan kami melalui menu "Pengaturan" > "Bantuan & Dukungan" atau kirim email ke support@sportsspace.com.',
    ),
    FAQItem(
      question: 'Apakah saya bisa mengubah profil saya?',
      answer: 'Ya, Anda dapat mengubah profil Anda kapan saja. Klik pada foto profil Anda di pojok kanan atas, lalu pilih "Edit Profil". Di sana Anda dapat mengubah foto, nama pengguna, bio, dan informasi lainnya.',
    ),
    FAQItem(
      question: 'Bagaimana cara menemukan venue terdekat?',
      answer: 'Untuk menemukan venue terdekat, buka tab "Fields" dan aplikasi akan secara otomatis menampilkan venue berdasarkan lokasi Anda saat ini. Anda juga dapat menggunakan filter untuk mencari venue berdasarkan jenis olahraga tertentu.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.question_answer,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pertanyaan yang Sering Diajukan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Temukan jawaban untuk pertanyaan umum tentang SportsSpace',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari pertanyaan',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                // Implement search functionality
              },
            ),
            
            const SizedBox(height: 24),
            
            // FAQ List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqItems.length,
              itemBuilder: (context, index) {
                return _buildFAQItem(_faqItems[index]);
              },
            ),
            
            const SizedBox(height: 24),
            
            // Contact Support
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.support_agent,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Masih memiliki pertanyaan?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Jika Anda tidak menemukan jawaban yang Anda cari, jangan ragu untuk menghubungi tim dukungan kami.',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Implement contact support
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 44),
                      ),
                      child: const Text('Hubungi Dukungan'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFAQItem(FAQItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          item.question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        childrenPadding: const EdgeInsets.all(16).copyWith(top: 0),
        children: [
          Text(
            item.answer,
            style: const TextStyle(
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// FAQ Item Model
class FAQItem {
  final String question;
  final String answer;
  
  FAQItem({
    required this.question,
    required this.answer,
  });
}