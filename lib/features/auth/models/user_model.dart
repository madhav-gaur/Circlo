class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? avatar;
  final List<String> circles;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    this.avatar,
    this.circles = const [],
  });

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      uid: json['uid'] ?? '',
      avatar: json['avatar'],
      circles: json['circles'] != null
          ? List<String>.from(json['circles'])
          : const [],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'avatar': avatar,
      'circles': circles,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? avatar,
    List<String>? circles,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      circles: circles ?? this.circles,
    );
  }
}

