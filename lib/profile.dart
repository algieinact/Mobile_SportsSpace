import 'package:flutter/material.dart';
import 'api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiService _apiService = ApiService();

  Map<String, dynamic> _userData = {};
  List<Map<String, dynamic>> _activities = [];
  List<Map<String, dynamic>> _achievements = [];
  bool _isLoading = true;
  String _error = '';

  // Dummy settings sections
  final List<Map<String, dynamic>> _settingsSections = [
    {
      'title': 'Akun',
      'items': [
        {'icon': Icons.person, 'title': 'Edit Profil'},
        {'icon': Icons.sports, 'title': 'Pengaturan Olahraga'},
        {'icon': Icons.notifications, 'title': 'Notifikasi'},
      ],
    },
    {
      'title': 'Privasi & Keamanan',
      'items': [
        {'icon': Icons.privacy_tip, 'title': 'Privasi Akun'},
        {'icon': Icons.lock, 'title': 'Keamanan'},
        {'icon': Icons.block, 'title': 'Blokir & Laporan'},
      ],
    },
    {
      'title': 'Bantuan & Info',
      'items': [
        {'icon': Icons.help, 'title': 'Bantuan'},
        {'icon': Icons.info, 'title': 'Tentang SportsSpace'},
        {'icon': Icons.question_answer, 'title': 'FAQ'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      // Fetch user profile
      final profileData = await _apiService
          .getProfile('YOUR_TOKEN'); // Replace with actual token
      setState(() {
        _userData = profileData;
      });

      // Fetch user activities
      final activitiesData = await _apiService
          .fetchUserActivities('YOUR_TOKEN'); // Replace with actual token
      setState(() {
        _activities = List<Map<String, dynamic>>.from(activitiesData);
      });

      // Fetch user achievements
      final achievementsData = await _apiService
          .fetchUserAchievements('YOUR_TOKEN'); // Replace with actual token
      setState(() {
        _achievements = List<Map<String, dynamic>>.from(achievementsData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load profile data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              _showSettingsBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Tambahkan SingleChildScrollView
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(),

            // Tab Bar
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.red,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Aktivitas"),
                  Tab(text: "Prestasi"),
                  Tab(text: "Pengaturan"),
                ],
              ),
            ),

            // Tab Content
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  48, // Sesuaikan tinggi
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Activities Tab
                  _buildActivitiesTab(),

                  // Achievements Tab
                  _buildAchievementsTab(),

                  // Settings Tab
                  _buildSettingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          children: [
            Text(_error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchUserData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Avatar and Edit Button
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    _userData['avatar'] ?? 'https://via.placeholder.com/150'),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                  onPressed: () {
                    // Implement change avatar
                  },
                  constraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Name and Username
          Text(
            _userData['name'] ?? 'User',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '@${_userData['username'] ?? 'username'}',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),

          const SizedBox(height: 8),

          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                _userData['location'] ?? 'Location not set',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bio
          Text(
            _userData['bio'] ?? 'No bio available',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 16),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn(
                (_userData['followers'] ?? 0).toString(),
                'Pengikut',
              ),
              Container(height: 24, width: 1, color: Colors.grey[300]),
              _buildStatColumn(
                (_userData['following'] ?? 0).toString(),
                'Mengikuti',
              ),
              Container(height: 24, width: 1, color: Colors.grey[300]),
              _buildStatColumn(
                (_userData['sports']?.length ?? 0).toString(),
                'Olahraga',
              ),
            ],
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildActivitiesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final activity = _activities[index];

        if (activity['type'] == 'event') {
          return _buildEventCard(activity);
        } else {
          return _buildPostCard(activity);
        }
      },
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(event['image']),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    event['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event['date'],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      event['time'],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      event['location'],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Participants
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${event['participants']} Peserta',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // View Event Details
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Lihat Detail'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Share Event
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Bagikan'),
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

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(_userData['avatar']),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userData['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      post['date'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Post Content
            Text(post['content']),

            const SizedBox(height: 16),

            // Post Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post['likes'].toString(),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post['comments'].toString(),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                Icon(Icons.share, color: Colors.grey[700], size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: achievement['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    achievement['icon'],
                    color: achievement['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        achievement['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        achievement['description'],
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Diperoleh pada ${achievement['date']}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.emoji_events, color: Colors.amber[700]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _settingsSections.length,
      itemBuilder: (context, sectionIndex) {
        final section = _settingsSections[sectionIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sectionIndex > 0) const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                section['title'],
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: section['items'].length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final item = section['items'][index];
                  bool isLastItemInSection =
                      index == section['items'].length - 1;

                  Widget listTile = ListTile(
                    leading: Icon(item['icon'], color: Colors.red),
                    title: Text(item['title']),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Handle settings item tap
                      if (item['title'] == 'FAQ') {
                        Navigator.pushNamed(context, '/faq');
                      }
                    },
                  );

                  // Add rounded corners to the first and last items
                  if (index == 0 && isLastItemInSection) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: listTile,
                    );
                  } else if (index == 0) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: listTile,
                    );
                  } else if (isLastItemInSection) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: listTile,
                    );
                  } else {
                    return listTile;
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profil'),
              onTap: () {
                Navigator.pop(context);
                // Implement edit profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () {
                Navigator.pop(context);
                // Implement logout
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Bantuan'),
              onTap: () {
                Navigator.pop(context);
                // Implement help
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

// Model class for analytics purposes
class UserAnalytics {
  final int totalGames;
  final int totalHours;
  final Map<String, int> sportBreakdown;
  final List<Map<String, dynamic>> activityHistory;

  UserAnalytics({
    required this.totalGames,
    required this.totalHours,
    required this.sportBreakdown,
    required this.activityHistory,
  });
}
