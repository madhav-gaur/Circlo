import 'package:circlo/features/circles/models/circle_model.dart';
import 'package:circlo/features/circles/repository/circle_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final circleRepoProvider = Provider((ref) => CircleRepo());

final circleProvider = FutureProvider.family<CircleModel?, String>((
  ref,
  circleId,
) {
  final repo = ref.watch(circleRepoProvider);
  return repo.getCircleById(circleId: circleId);
});
