import 'package:circlo/features/auth/models/public_profile_model.dart';
import 'package:circlo/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  final firestore = FirebaseFirestore.instance;

  Stream<UserModel?> streamCurrUser() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return Stream.value(null);

    return firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return UserModel.fromJSON({...snapshot.data()!, 'uid': firebaseUser.uid});
    });
  }

  Stream<PublicProfileModel?> streamPublicProfileById({required String uid}) {
    return firestore
        .collection('publicProfiles')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return PublicProfileModel.fromJSON({...snapshot.data()!, 'uid': uid});
    });
  }

  Stream<UserModel?> streamUserById({required String uid}) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return UserModel.fromJSON({...snapshot.data()!, 'uid': uid});
    });
  }


  Future<void> addCircleToUser({
    required String uid,
    required String circleId,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'circles': FieldValue.arrayUnion([circleId]),
    }, SetOptions(merge: true));
  }

  Future<void> removeCircleFromUser({
    required String uid,
    required String circleId,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'circles': FieldValue.arrayRemove([circleId]),
    }, SetOptions(merge: true));
  }
}

