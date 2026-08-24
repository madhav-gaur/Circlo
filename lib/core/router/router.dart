import 'package:circlo/features/auth/screens/signup.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => Signup())],
);
