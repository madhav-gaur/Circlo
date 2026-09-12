import 'package:circlo/utils/circle_invite_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CircleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createCircle({
    required String creatorUid,
    required String name,
  }) async {
    final inviteCode = generateCircleInvite();
    final doc = _firestore.collection('circle').doc();
    final data = {
      "circleId": doc.id,
      "name": name,
      "creatorUid": creatorUid,
      "inviteCode": inviteCode,
      "members": {creatorUid},
      "createdAt": DateTime.now(),
    };
    await doc.set(data);
    return doc.id;
  }
}
