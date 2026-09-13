import 'package:cloud_firestore/cloud_firestore.dart';

class CircleModel {
  final String circleId;
  final String name;

  final String creatorUid;

  final String inviteCode;

  final List<String> members;
  final Timestamp createdAt;

  CircleModel({
    required this.circleId,
    required this.name,
    required this.creatorUid,
    required this.inviteCode,
    required this.members,
    required this.createdAt,
  });
  factory CircleModel.fromMap(Map<String, dynamic> map) {
    Timestamp parseCreatedAt(dynamic value) {
      if (value is Timestamp) return value;
      if (value is DateTime) return Timestamp.fromDate(value);
      return Timestamp.now();
    }

    return CircleModel(
      circleId: map['circleId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      creatorUid: map['creatorUid'] as String? ?? '',
      inviteCode: map['inviteCode'] as String? ?? '',
      members: List<String>.from(map['members'] ?? []),
      createdAt: parseCreatedAt(map['createdAt']),
    );
  }
}

