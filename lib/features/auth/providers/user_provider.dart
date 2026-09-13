import 'package:circlo/features/auth/models/public_profile_model.dart';
import 'package:circlo/features/auth/models/user_model.dart';
import 'package:circlo/features/auth/repo/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepoProvider = Provider((ref) => UserRepo());

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final authUser = ref.watch(authStateProvider).value;
  if (authUser == null) {
    return Stream.value(null);
  }
  final repo = ref.watch(userRepoProvider);
  return repo.streamCurrUser();
});

final publicProfileByIdProvider =
    StreamProvider.family<PublicProfileModel?, String>((ref,uid,) {
  final repo = ref.watch(userRepoProvider);
  return repo.streamPublicProfileById(uid: uid);
});

final userByIdProvider = StreamProvider.family<UserModel?, String>((
  ref,
  uid,
) {
  final repo = ref.watch(userRepoProvider);
  return repo.streamUserById(uid: uid);
});

