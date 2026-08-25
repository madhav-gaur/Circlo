import 'package:circlo/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrUser(String uid) async {
    final user = await firestore.collection('users').doc(uid).get();
    if (user.exists) return null;
    return UserModel.fromJSON(user.data()!);
  }
}
