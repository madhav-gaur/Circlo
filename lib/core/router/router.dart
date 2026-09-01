import 'package:circlo/core/router/routes.dart';
import 'package:circlo/features/auth/screens/signin.dart';
import 'package:circlo/features/auth/screens/signup.dart';
import 'package:circlo/features/circles/create_circle.dart';
import 'package:circlo/features/circles/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;

    final isLoggedIn = user != null;

    final isAuthPage =
        state.matchedLocation == AppRoutes.signup ||
        state.matchedLocation == AppRoutes.signin;

    if (!isLoggedIn && !isAuthPage) {
      return AppRoutes.signup;
    }

    if (isLoggedIn && isAuthPage) {
      return AppRoutes.dashboard;
    }

    return null;
  },
  routes: [
    GoRoute(path: AppRoutes.signup, builder: (context, state) => Signup()),
    GoRoute(path: AppRoutes.signin, builder: (context, state) => SignIn()),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => Dashboard(),
    ),
    GoRoute(
      path: AppRoutes.createCircle,
      builder: (context, state) => CreateCircle(),
    ),
  ],
);
