import 'package:circlo/core/router/routes.dart';
import 'package:circlo/features/auth/screens/signup.dart';
import 'package:circlo/features/circles/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;

    final isLoggedIn = user != null;
    final isOnSignup = state.matchedLocation == AppRoutes.signup;

    if (!isLoggedIn && !isOnSignup) {
      return AppRoutes.signup;
    }
    if (isLoggedIn && isOnSignup) {
      return AppRoutes.dashboard;
    }

    return null;
  },
  routes: [
    GoRoute(path: AppRoutes.signup, builder: (context, state) => Signup()),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => Dashboard(),
    ),
  ],
);
