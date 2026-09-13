import 'package:circlo/features/circles/models/circle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CircleRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<CircleModel?> getCircleById({required String circleId}) async {
    final snapshot = await _firestore
        .collection('circle')
        .doc(circleId)
        .get();
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    return CircleModel.fromMap(snapshot.data()!);
  }

  Future<List<CircleModel>> getCirclesByIds(List<String> circleIds) async {
    if (circleIds.isEmpty) return [];
    final List<CircleModel> circles = [];
    for (final circleId in circleIds) {
      final circle = await getCircleById(circleId: circleId);
      if (circle != null) {
        circles.add(circle);
      }
    }
    return circles;
  }

  Stream<CircleModel?> streamCircleById({required String circleId}) {
    return _firestore
        .collection('circle')
        .doc(circleId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return CircleModel.fromMap(snapshot.data()!);
    });
  }

  Stream<List<CircleModel>> streamCirclesForUser(String uid) {
    return _firestore
        .collection('circle')
        .where('members', arrayContains: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CircleModel.fromMap(doc.data()))
            .toList());
  }

  Future<List<CircleModel>> getAllCircles() async {
    final currUser = FirebaseAuth.instance.currentUser;
    if (currUser == null) return [];

    final snapshot = await _firestore
        .collection('circle')
        .where('members', arrayContains: currUser.uid)
        .get();

    return snapshot.docs
        .map((doc) => CircleModel.fromMap(doc.data()))
        .toList();
  }
}


