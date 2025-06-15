import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'submenu/models.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  // ------------------ AUTH ------------------
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'token': data['token'],
        'user': data['user'],
        'message': data['message'],
      };
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to login');
    }
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String tanggalLahir,
    required String gender,
    required String kota,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'tanggal_lahir': tanggalLahir,
        'gender': gender,
        'kota': kota,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return {
        'token': data['token'],
        'user': data['user'],
        'message': data['message'],
      };
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to register');
    }
  }

  Future<void> logout(String token) async {
    final url = Uri.parse('$baseUrl/logout');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to logout');
    }
  }

  // ------------------ USER PROFILE ------------------
  Future<Map<String, dynamic>> getProfile(String token) async {
    final url = Uri.parse('$baseUrl/profile');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get profile: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateProfile(
    String token,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl/profile');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  // ------------------ COMMUNITIES ------------------
  Future<List<dynamic>> fetchCommunities() async {
    try {
      final url = Uri.parse('$baseUrl/komunitas');
      print('Fetching communities from: $url');

      final headers = await getHeaders();
      print('Using headers: $headers');

      final response = await http.get(url, headers: headers);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          return data['data'];
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch communities');
        }
      } else {
        throw Exception('Failed to fetch communities: ${response.body}');
      }
    } catch (e) {
      print('Error fetching communities: $e');
      throw Exception('Failed to fetch communities: $e');
    }
  }

  // Fungsi untuk mendapatkan detail komunitas tertentu
  Future<Map<String, dynamic>> fetchCommunityDetails(String communityId) async {
    final url = Uri.parse('$baseUrl/komunitas/$communityId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch community details: ${response.body}');
    }
  }

  // Fungsi untuk membuat komunitas baru
  Future<Map<String, dynamic>> createCommunity(
    Map<String, dynamic> communityData,
  ) async {
    final url = Uri.parse('$baseUrl/komunitas');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(communityData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create community: ${response.body}');
    }
  }

  // Fungsi untuk memperbarui data komunitas
  Future<Map<String, dynamic>> updateCommunity(
    String communityId,
    Map<String, dynamic> communityData,
  ) async {
    final url = Uri.parse('$baseUrl/komunitas/$communityId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(communityData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update community: ${response.body}');
    }
  }

  // Fungsi untuk menghapus komunitas
  Future<void> deleteCommunity(String communityId) async {
    final url = Uri.parse('$baseUrl/komunitas/$communityId');
    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Failed to delete community: ${response.body}');
    }
  }

  // ------------------ GROUPS ------------------
  Future<List<dynamic>> fetchGroups() async {
    final url = Uri.parse('$baseUrl/groups');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch groups');
    }
  }

  Future<Map<String, dynamic>> fetchGroupDetails(String groupId) async {
    final url = Uri.parse('$baseUrl/groups/$groupId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch group details: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createGroup(
    Map<String, dynamic> groupData,
  ) async {
    final url = Uri.parse('$baseUrl/groups');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(groupData),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create group: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateGroup(
    String groupId,
    Map<String, dynamic> groupData,
  ) async {
    final url = Uri.parse('$baseUrl/groups/$groupId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(groupData),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update group: ${response.body}');
    }
  }

  Future<void> deleteGroup(String groupId) async {
    final url = Uri.parse('$baseUrl/groups/$groupId');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception('Failed to delete group: ${response.body}');
    }
  }

  Future<void> joinGroup(String groupId) async {
    final url = Uri.parse('$baseUrl/groups/$groupId/join');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to join group: ${response.body}');
    }
  }

  // ------------------ VENUES ------------------
  Future<List<dynamic>> fetchVenues() async {
    final url = Uri.parse('$baseUrl/venues');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch venues');
    }
  }

  Future<Map<String, dynamic>> fetchVenueDetails(String venueId) async {
    final url = Uri.parse('$baseUrl/venues/$venueId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch venue details: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createVenue(
    Map<String, dynamic> venueData,
  ) async {
    final url = Uri.parse('$baseUrl/venues');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(venueData),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create venue: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateVenue(
    String venueId,
    Map<String, dynamic> venueData,
  ) async {
    final url = Uri.parse('$baseUrl/venues/$venueId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(venueData),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update venue: ${response.body}');
    }
  }

  Future<void> deleteVenue(String venueId) async {
    final url = Uri.parse('$baseUrl/venues/$venueId');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception('Failed to delete venue: ${response.body}');
    }
  }

  // ------------------ POSTS ------------------
  static Future<List<Post>> getPosts() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Authentication required. Please login.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Session expired. Please login again.');
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  static Future<Post> createPost({
    required String title,
    required String content,
    File? image,
  }) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('No auth token found');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/posts'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['post_title'] = title;
      request.fields['post_content'] = content;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('post_image', image.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          return Post.fromJson(json.decode(response.body));
        } else {
          throw Exception('Post created but no data returned');
        }
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  static Future<Post> updatePost({
    required int postId,
    required String title,
    required String content,
    File? image,
  }) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('No auth token found');

      var request = http.MultipartRequest(
        'POST', // Laravel uses POST with _method=PUT for file uploads
        Uri.parse('$baseUrl/posts/$postId'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['_method'] = 'PUT';
      request.fields['post_title'] = title;
      request.fields['post_content'] = content;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('post_image', image.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return Post.fromJson(json.decode(response.body));
        } else {
          throw Exception('Post updated but no data returned');
        }
      } else {
        throw Exception('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating post: $e');
    }
  }

  static Future<void> deletePost(int postId) async {
    try {
      final headers = await getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/$postId'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }

  Future<List<dynamic>> fetchUserActivities(String token) async {
    final url = Uri.parse('$baseUrl/user/activities');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user activities: ${response.body}');
    }
  }

  Future<List<dynamic>> fetchUserAchievements(String token) async {
    final url = Uri.parse('$baseUrl/user/achievements');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user achievements: ${response.body}');
    }
  }

  Future<void> joinCommunity(String communityId) async {
    final url = Uri.parse('$baseUrl/communities/$communityId/join');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to join community: ${response.body}');
    }
  }

  // ------------------ FIELDS ------------------
  Future<List<dynamic>> fetchFields() async {
    try {
      final url = Uri.parse('$baseUrl/lapangans');
      print('Fetching fields from: $url');

      final headers = await getHeaders();
      print('Using headers: $headers');

      final response = await http.get(url, headers: headers);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch fields: ${response.body}');
      }
    } catch (e) {
      print('Error fetching fields: $e');
      throw Exception('Failed to fetch fields: $e');
    }
  }

  // ------------------ SPORTS GROUPS ------------------
  Future<List<dynamic>> fetchSportsGroups() async {
    try {
      final url = Uri.parse('$baseUrl/sports-groups');
      print('Fetching sports groups from: $url');

      final headers = await getHeaders();
      print('Using headers: $headers');

      final response = await http.get(url, headers: headers);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch sports groups: ${response.body}');
      }
    } catch (e) {
      print('Error fetching sports groups: $e');
      throw Exception('Failed to fetch sports groups: $e');
    }
  }
}
