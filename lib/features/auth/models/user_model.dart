class UserModel {
  String uid;
  String email;
  String name;
  String? avatar;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    this.avatar,
  });
  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      uid: json['uid'],
      avatar: json['uid'] ?? "",
    );
  }
}
