import 'package:flutter/material.dart';
import 'submenu/feeds_tab.dart';
import 'submenu/communities_tab.dart';
import 'submenu/fields_tab.dart';
import 'submenu/groups_tab.dart';
import 'api_service.dart';
import 'auth_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // State variable for selected index
  final ApiService _apiService = ApiService();
  Map<String, dynamic> _userData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final profileData = await _apiService.getProfile(token);
      setState(() {
        _userData = profileData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sports_basketball,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SportsSpace',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!_isLoading && _userData.isNotEmpty)
                  Text(
                    'Hi, ${_userData['name'] ?? _userData['username'] ?? 'User'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Implement notifications
            },
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: PopupMenuButton<String>(
              icon: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[200],
                child: _isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      )
                    : _userData['photo'] != null
                        ? ClipOval(
                            child: Image.network(
                              _userData['photo'],
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.grey,
                          ),
              ),
              onSelected: (value) async {
                if (value == 'logout') {
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
                } else if (value == 'profile') {
                  Navigator.pushNamed(context, '/profile');
                } else if (value == 'faq') {
                  Navigator.pushNamed(context, '/faq');
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 18),
                      const SizedBox(width: 8),
                      Text(_userData['name'] ??
                          _userData['username'] ??
                          'Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'faq',
                  child: Row(
                    children: [
                      Icon(Icons.help_outline, size: 18),
                      SizedBox(width: 8),
                      Text('FAQ'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Feed Tab
          PostsPage(),

          // Komunitas Tab
          const CommunitiesTab(),

          // Fields Tab
          const FieldsTab(),

          // Groups Tab
          const GroupsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Komunitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer_outlined),
            activeIcon: Icon(Icons.sports_soccer),
            label: 'Fields',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            label: 'Groups',
          ),
        ],
      ),
    );
  }
}
