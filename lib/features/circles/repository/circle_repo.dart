import 'package:circlo/features/circles/models/circle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CircleRepo {
  Future<CircleModel?> getCircleById({required String circleId}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('circle')
        .doc(circleId)
        .get();
    if (!snapshot.exists) {
      return null;
    }
    return CircleModel.fromMap(snapshot.data()!);
  }
}
