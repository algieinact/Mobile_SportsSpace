class Community {
  final String id;
  final String name;
  final String image;
  final int members;
  final String sport;
  final String nextEvent;
  final String description;

  Community({
    required this.id,
    required this.name,
    required this.image,
    required this.members,
    required this.sport,
    required this.nextEvent,
    required this.description,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        members: json['members'],
        sport: json['sport'],
        nextEvent: json['nextEvent'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'members': members,
        'sport': sport,
        'nextEvent': nextEvent,
        'description': description,
      };
}

// Tambahkan model Group
class SportsGroup {
  final String id;
  final String name;
  final String image;
  final int members;
  final String sport;
  final String events;

  SportsGroup({
    required this.id,
    required this.name,
    required this.image,
    required this.members,
    required this.sport,
    required this.events,
  });

  factory SportsGroup.fromJson(Map<String, dynamic> json) => SportsGroup(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        members: json['members'],
        sport: json['sport'],
        events: json['events'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'members': members,
        'sport': sport,
        'events': events,
      };
}

// Tambahkan model Venue
class Field {
  final String id;
  final String name;
  final String image;
  final double rating;
  final int reviews;
  final String location;
  final String distance;
  final List<String> sports;
  final String price;

  Field({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.distance,
    required this.sports,
    required this.price,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        rating: (json['rating'] as num).toDouble(),
        reviews: json['reviews'],
        location: json['location'],
        distance: json['distance'],
        sports: List<String>.from(json['sports']),
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'rating': rating,
        'reviews': reviews,
        'location': location,
        'distance': distance,
        'sports': sports,
        'price': price,
      };
}

// Tambahkan model Post
class Post {
  final int idPost;
  final int userId;
  final String postTitle;
  final String postContent;
  final String? postImage;
  final DateTime createdAt;

  Post({
    required this.idPost,
    required this.userId,
    required this.postTitle,
    required this.postContent,
    this.postImage,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      idPost: json['id_post'],
      userId: json['user_id'],
      postTitle: json['post_title'],
      postContent: json['post_content'],
      postImage: json['post_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id_post': idPost,
        'user_id': userId,
        'post_title': postTitle,
        'post_content': postContent,
        'post_image': postImage,
        'created_at': createdAt.toIso8601String(),
      };
}

// Tambahkan model User
class UserProfile {
  final String id;
  final String name;
  final String username;
  final String avatar;
  final String location;
  final String bio;
  final int followers;
  final int following;
  final List<String> sports;
  final String level;

  UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.location,
    required this.bio,
    required this.followers,
    required this.following,
    required this.sports,
    required this.level,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        avatar: json['avatar'],
        location: json['location'],
        bio: json['bio'],
        followers: json['followers'],
        following: json['following'],
        sports: List<String>.from(json['sports']),
        level: json['level'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'avatar': avatar,
        'location': location,
        'bio': bio,
        'followers': followers,
        'following': following,
        'sports': sports,
        'level': level,
      };
}
