// Model Classes for SportsSpace app

class Post {
  final String id;
  final String username;
  final String userAvatar;
  final String content;
  final String sport;
  final String location;
  final String time;
  final int likes;
  final int comments;
  final String timeAgo;
  final List<String>? images;

  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.content,
    required this.sport,
    required this.location,
    required this.time,
    required this.likes,
    required this.comments,
    required this.timeAgo,
    this.images,
  });
}

class Community {
  final String id;
  final String name;
  final String image;
  final int members;
  final String sport;
  final String nextEvent;

  Community({
    required this.id,
    required this.name,
    required this.image,
    required this.members,
    required this.sport,
    required this.nextEvent,
  });
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
}