import 'package:circlo/features/auth/models/user_model.dart';
import 'package:circlo/features/auth/repo/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepoProvider = Provider((ref) => UserRepo());

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final firebaseUser = await ref.watch(authStateProvider.future);

  if (firebaseUser == null) return null;

  final repo = ref.read(userRepoProvider);
  return repo.getCurrUser();
});
final userByIdProvider = FutureProvider.family<UserModel?, String>((
  ref,
  uid,
) async {
  final repo = ref.read(userRepoProvider);
  return repo.getUserById(uid: uid);
});
