import 'package:circlo/utils/circle_invite_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      "members": [creatorUid],
      "createdAt": Timestamp.now(),
    };
    await doc.set(data);

    // Update user's circles list
    await _firestore.collection('users').doc(creatorUid).set({
      'circles': FieldValue.arrayUnion([doc.id]),
    }, SetOptions(merge: true));

    return doc.id;
  }

  Future<String?> joinCircleByInviteCode({required String inviteCode}) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final uid = user.uid;

    final query = await _firestore
        .collection('circle')
        .where('inviteCode', isEqualTo: inviteCode.trim().toUpperCase())
        .limit(1)
        .get();
    if (query.docs.isEmpty) {
      throw Exception("INVALID_INVITE");
    }

    final doc = query.docs.first;
    final circleId = doc.id;

    final members = List<String>.from(doc.data()['members'] ?? []);

    if (members.contains(uid)) {
      throw Exception("ALREADY_MEMBER");
    }
    await doc.reference.update({
      'members': FieldValue.arrayUnion([uid]),
    });

    await _firestore.collection('users').doc(uid).set({
      'circles': FieldValue.arrayUnion([circleId]),
    }, SetOptions(merge: true));

    return circleId;
  }
}
