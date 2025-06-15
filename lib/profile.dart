import 'package:flutter/material.dart';
import 'api_service.dart';
import 'auth_service.dart';

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

      // Get token from AuthService
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Fetch user profile
      final profileData = await _apiService.getProfile(token);
      setState(() {
        _userData = profileData;
      });

      // For now, we'll use empty lists for activities and achievements
      // since these endpoints might not be implemented yet
      setState(() {
        _activities = [];
        _achievements = [];
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
              height: MediaQuery.of(context).size.height - kToolbarHeight - 48,
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
                backgroundColor: Colors.grey[200],
                child: _userData['photo'] != null
                    ? ClipOval(
                        child: Image.network(
                          _userData['photo'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
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
            _userData['name'] ?? _userData['username'] ?? 'User',
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
                _userData['kota'] ?? 'Location not set',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // User Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'Tanggal Lahir: ${_userData['tanggal_lahir'] ?? 'Not set'}',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'Gender: ${_userData['gender'] ?? 'Not set'}',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
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
    if (_activities.isEmpty) {
      return const Center(
        child: Text('Belum ada aktivitas'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final activity = _activities[index];
        return _buildActivityCard(activity);
      },
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getActivityIcon(activity['type']),
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  activity['title'] ?? 'Activity',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              activity['description'] ?? 'No description available',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${activity['date'] ?? 'Not specified'}',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getActivityIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'event':
        return Icons.event;
      case 'post':
        return Icons.post_add;
      case 'achievement':
        return Icons.emoji_events;
      default:
        return Icons.star;
    }
  }

  Widget _buildAchievementsTab() {
    if (_achievements.isEmpty) {
      return const Center(
        child: Text('Belum ada prestasi'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        return _buildAchievementCard(achievement);
      },
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement['title'] ?? 'Achievement',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    achievement['description'] ?? 'No description available',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Earned on ${achievement['date'] ?? 'Unknown date'}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                  return ListTile(
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
              onTap: () async {
                Navigator.pop(context);
                final token = await AuthService.getToken();
                if (token != null) {
                  try {
                    await _apiService.logout(token);
                    await AuthService.removeToken();
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to logout: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
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
