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
      userId: json['user_id'] as int,
      username: json['username'] as String,
      photo: json['photo'] as String,
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
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : User(
              userId: json['user_id'] ?? 0,
              username: 'Unknown',
              photo: '',
            ),
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
  final int id_kmnts;
  final String nama;
  final String jns_olahraga;
  final int max_members;
  final String provinsi;
  final String kota;
  final String deskripsi;
  final String foto;
  final String sampul;
  final int user_id;
  final int status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final User user;

  Community({
    required this.id_kmnts,
    required this.nama,
    required this.jns_olahraga,
    required this.max_members,
    required this.provinsi,
    required this.kota,
    required this.deskripsi,
    required this.foto,
    required this.sampul,
    required this.user_id,
    required this.status,
    this.created_at,
    this.updated_at,
    required this.user,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        id_kmnts: json['id_kmnts'] as int,
        nama: json['nama'] as String,
        jns_olahraga: json['jns_olahraga'] as String,
        max_members: json['max_members'] as int,
        provinsi: json['provinsi'] as String,
        kota: json['kota'] as String,
        deskripsi: json['deskripsi'] as String,
        foto: json['foto'] as String? ?? '',
        sampul: json['sampul'] as String? ?? '',
        user_id: json['user_id'] as int,
        status: json['status'] as int,
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        updated_at: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
        user: User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id_kmnts': id_kmnts,
        'nama': nama,
        'jns_olahraga': jns_olahraga,
        'max_members': max_members,
        'provinsi': provinsi,
        'kota': kota,
        'deskripsi': deskripsi,
        'foto': foto,
        'sampul': sampul,
        'user_id': user_id,
        'status': status,
        'created_at': created_at?.toIso8601String(),
        'updated_at': updated_at?.toIso8601String(),
        'user': user.toJson(),
      };
}

class Field {
  final int id_field;
  final String nama_lapangan;
  final String type;
  final String categori;
  final String foto;
  final String opening_hours;
  final String closing_hours;
  final String fasility;
  final int price;
  final String description;
  final String address;
  final DateTime? created_at;
  final DateTime? updated_at;

  Field({
    required this.id_field,
    required this.nama_lapangan,
    required this.type,
    required this.categori,
    required this.foto,
    required this.opening_hours,
    required this.closing_hours,
    required this.fasility,
    required this.price,
    required this.description,
    required this.address,
    this.created_at,
    this.updated_at,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id_field: json['id_field'],
        nama_lapangan: json['nama_lapangan'],
        type: json['type'],
        categori: json['categori'],
        foto: json['foto'] ?? '',
        opening_hours: json['opening_hours'],
        closing_hours: json['closing_hours'],
        fasility: json['fasility'],
        price: json['price'],
        description: json['description'],
        address: json['address'],
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updated_at: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id_field': id_field,
        'nama_lapangan': nama_lapangan,
        'type': type,
        'categori': categori,
        'foto': foto,
        'opening_hours': opening_hours,
        'closing_hours': closing_hours,
        'fasility': fasility,
        'price': price,
        'description': description,
        'address': address,
        'created_at': created_at?.toIso8601String(),
        'updated_at': updated_at?.toIso8601String(),
      };
}

class SportsGroup {
  final int id;
  final int user_id;
  final String title;
  final String event_date;
  final String start_time;
  final String end_time;
  final String city;
  final String address;
  final int kapasitas_maksimal;
  final int current_members;
  final String jenis_olahraga;
  final String payment_method;
  final int payment_amount;
  final DateTime? created_at;
  final DateTime? updated_at;

  SportsGroup({
    required this.id,
    required this.user_id,
    required this.title,
    required this.event_date,
    required this.start_time,
    required this.end_time,
    required this.city,
    required this.address,
    required this.kapasitas_maksimal,
    required this.current_members,
    required this.jenis_olahraga,
    required this.payment_method,
    required this.payment_amount,
    this.created_at,
    this.updated_at,
  });

  factory SportsGroup.fromJson(Map<String, dynamic> json) {
    return SportsGroup(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      event_date: json['event_date'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      city: json['city'],
      address: json['address'],
      kapasitas_maksimal: json['kapasitas_maksimal'],
      current_members: json['current_members'],
      jenis_olahraga: json['jenis_olahraga'],
      payment_method: json['payment_method'],
      payment_amount: json['payment_amount'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updated_at: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'title': title,
      'event_date': event_date,
      'start_time': start_time,
      'end_time': end_time,
      'city': city,
      'address': address,
      'kapasitas_maksimal': kapasitas_maksimal,
      'current_members': current_members,
      'jenis_olahraga': jenis_olahraga,
      'payment_method': payment_method,
      'payment_amount': payment_amount,
      'created_at': created_at?.toIso8601String(),
      'updated_at': updated_at?.toIso8601String(),
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
