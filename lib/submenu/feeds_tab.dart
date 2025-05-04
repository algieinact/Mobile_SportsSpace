import 'package:flutter/material.dart';
import 'models.dart';

class FeedsTab extends StatefulWidget {
  const FeedsTab({Key? key}) : super(key: key);

  @override
  State<FeedsTab> createState() => _FeedsTabState();
}

class _FeedsTabState extends State<FeedsTab> {
  final TextEditingController _postController = TextEditingController();
  bool _isPostButtonEnabled = false;

  // Dummy data for posts
  final List<Post> _posts = [
    Post(
      id: '1',
      username: 'akbar_hidayat',
      userAvatar:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      content:
          'Mencari teman untuk bermain basket di GOR Senayan besok sore jam 4. Siapa yang mau join?',
      sport: 'Basket',
      location: 'GOR Senayan',
      time: 'Besok, 16:00',
      likes: 15,
      comments: 7,
      timeAgo: '2 jam yang lalu',
    ),
    Post(
      id: '2',
      username: 'amandaputri',
      userAvatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      content:
          'Baru saja selesai latihan voli di Velodrome. Tempat ini sangat nyaman dan bersih!',
      sport: 'Voli',
      location: 'Velodrome',
      time: '',
      likes: 24,
      comments: 3,
      timeAgo: '5 jam yang lalu',
      images: ['https://images.unsplash.com/photo-1592656094267-764a45160876'],
    ),
    Post(
      id: '3',
      username: 'hilman_rahman',
      userAvatar:
          'https://images.unsplash.com/photo-1485206412256-701ccc5b93ca?q=80&w=2094&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      content:
          'Grup futsal kami membutuhkan 2 pemain lagi untuk game hari Sabtu ini. Field sudah dibooking di Futsal Zone Kemang. DM jika berminat!',
      sport: 'Futsal',
      location: 'Futsal Zone Kemang',
      time: 'Sabtu, 19:00',
      likes: 8,
      comments: 12,
      timeAgo: '1 hari yang lalu',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _postController.addListener(_updatePostButtonState);
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _updatePostButtonState() {
    setState(() {
      _isPostButtonEnabled = _postController.text.trim().isNotEmpty;
    });
  }

  void _createPost() {
    if (_postController.text.trim().isEmpty) return;

    setState(() {
      _posts.insert(
        0,
        Post(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          username: 'currentuser',
          userAvatar: 'https://randomuser.me/api/portraits/men/10.jpg',
          content: _postController.text.trim(),
          sport: '',
          location: '',
          time: '',
          likes: 0,
          comments: 0,
          timeAgo: 'Baru saja',
        ),
      );
      _postController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Postingan berhasil dibuat!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deletePost(String postId) {
    setState(() {
      _posts.removeWhere((post) => post.id == postId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Postingan berhasil dihapus'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Create Post Card
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          'lib/assets/image/profile.jpeg',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _postController,
                          maxLines: 3,
                          minLines: 1,
                          decoration: const InputDecoration(
                            hintText: 'Apa yang sedang kamu pikirkan?',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildPostActionButton(
                              icon: Icons.photo_library,
                              label: 'Foto',
                              color: Colors.green,
                              onTap: () {
                                // Implement add photo
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildPostActionButton(
                              icon: Icons.location_on,
                              label: 'Lokasi',
                              color: Colors.red,
                              onTap: () {
                                // Implement add location
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildPostActionButton(
                              icon: Icons.sports_basketball,
                              label: 'Olahraga',
                              color: Colors.orange,
                              onTap: () {
                                // Implement add sport
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _isPostButtonEnabled ? _createPost : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Post'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Posts List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              final post = _posts[index];
              return _buildPostCard(post);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(post.userAvatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '@${post.username}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            post.timeAgo,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      if (post.sport.isNotEmpty || post.location.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              if (post.sport.isNotEmpty) ...[
                                Icon(
                                  Icons.sports,
                                  color: Colors.grey[600],
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  post.sport,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                              if (post.sport.isNotEmpty &&
                                  post.location.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Text(
                                    '•',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              if (post.location.isNotEmpty) ...[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey[600],
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  post.location,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      if (post.time.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.grey[600],
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                post.time,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (post.username == 'currentuser')
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                    onSelected: (value) {
                      if (value == 'delete') {
                        _deletePost(post.id);
                      } else if (value == 'edit') {
                        // Implement edit post
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18),
                                SizedBox(width: 8),
                                Text('Hapus'),
                              ],
                            ),
                          ),
                        ],
                  ),
              ],
            ),
          ),

          // Post Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(post.content),
          ),

          // Post Images
          if (post.images != null && post.images!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(post.images![0], fit: BoxFit.cover),
              ),
            ),

          // Post Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildPostActionIconButton(
                      icon: Icons.favorite_border,
                      label: post.likes.toString(),
                      onTap: () {
                        // Implement like
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildPostActionIconButton(
                      icon: Icons.chat_bubble_outline,
                      label: post.comments.toString(),
                      onTap: () {
                        // Implement comment
                      },
                    ),
                  ],
                ),
                _buildPostActionIconButton(
                  icon: Icons.share,
                  label: 'Bagikan',
                  onTap: () {
                    // Implement share
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActionIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 20),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}