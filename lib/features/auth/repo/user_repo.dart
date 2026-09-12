import 'package:circlo/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  final firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return null;

    final userSnapshot = await firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!userSnapshot.exists) return null;

    final data = userSnapshot.data();
    if (data == null) return null;

    return UserModel.fromJSON({...data, 'uid': firebaseUser.uid});
  }

  Future<UserModel?> getUserById({required String uid}) async {
    final userSnapshot = await firestore.collection('users').doc(uid).get();

    if (!userSnapshot.exists) return null;

    final data = userSnapshot.data();
    if (data == null) return null;

    return UserModel.fromJSON(data);
  }
}
