class PublicProfileModel {
  final String uid;
  final String name;
  final String? avatar;

  PublicProfileModel({
    required this.uid,
    required this.name,
    this.avatar,
  });

  factory PublicProfileModel.fromJSON(Map<String, dynamic> json) {
    return PublicProfileModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
    };
  }

  PublicProfileModel copyWith({
    String? uid,
    String? name,
    String? avatar,
  }) {
    return PublicProfileModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
