// Model Classes for SportsSpace app

class User {
  final int userId;
  final String username;
  final String photo;

  User({
    required this.userId,
    required this.username,
    required this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'photo': photo,
    };
  }
}

class Post {
  final int idPost;
  final int userId;
  final String postTitle;
  final String postContent;
  final String? postImage;
  final DateTime createdAt;
  final User user;

  Post({
    required this.idPost,
    required this.userId,
    required this.postTitle,
    required this.postContent,
    this.postImage,
    required this.createdAt,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      idPost: json['id_post'],
      userId: json['user_id'],
      postTitle: json['post_title'],
      postContent: json['post_content'],
      postImage: json['post_image'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_post': idPost,
      'user_id': userId,
      'post_title': postTitle,
      'post_content': postContent,
      'post_image': postImage,
      'created_at': createdAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class Community {
  final String id;
  final String name;
  final String description;
  final String image;
  final int members;
  final String sport;
  final String location;
  final String nextEvent;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.members,
    required this.sport,
    required this.location,
    required this.nextEvent,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      members: json['members'] ?? 0,
      sport: json['sport'],
      location: json['location'] ?? '',
      nextEvent: json['next_event'] ?? 'No upcoming events',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'members': members,
      'sport': sport,
      'location': location,
      'next_event': nextEvent,
    };
  }
}

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
}

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

  factory SportsGroup.fromJson(Map<String, dynamic> json) {
    return SportsGroup(
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'] ?? 'https://via.placeholder.com/150',
      members: json['members'] ?? 0,
      sport: json['sport'],
      events: json['events'] ?? 'No events scheduled',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'members': members,
      'sport': sport,
      'events': events,
    };
  }
}

class Venue {
  final String id;
  final String name;
  final String description;
  final String image;
  final String address;
  final String sport;
  final double rating;
  final int price;

  Venue({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.address,
    required this.sport,
    required this.rating,
    required this.price,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      address: json['address'],
      sport: json['sport'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'address': address,
      'sport': sport,
      'rating': rating,
      'price': price,
    };
  }
}
