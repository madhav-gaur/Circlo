import 'package:circlo/features/auth/providers/user_provider.dart';
import 'package:circlo/features/circles/models/circle_model.dart';
import 'package:circlo/features/circles/repository/circle_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final circleRepoProvider = Provider((ref) => CircleRepo());

final circleProvider = StreamProvider.family<CircleModel?, String>((
  ref,
  circleId,
) {
  final repo = ref.watch(circleRepoProvider);
  return repo.streamCircleById(circleId: circleId);
});

final userCirclesProvider = StreamProvider<List<CircleModel>>((ref) {
  final authUser = ref.watch(authStateProvider).value;
  if (authUser == null) {
    return Stream.value([]);
  }
  final repo = ref.watch(circleRepoProvider);
  return repo.streamCirclesForUser(authUser.uid);
});


