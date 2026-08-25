import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.user?.uid)
        .set({"uid": user.user!.uid, "name": name, "email": email});
    return user;
  }

  Future<UserCredential?> signin({
    required String email,
    required String password,
  }) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }
}
