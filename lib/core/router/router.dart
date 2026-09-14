import 'package:circlo/core/router/routes.dart';
import 'package:circlo/features/auth/screens/signin.dart';
import 'package:circlo/features/auth/screens/signup.dart';
import 'package:circlo/features/circles/screens/circle_created.dart';
import 'package:circlo/features/circles/screens/circle_dashboard.dart';
import 'package:circlo/features/circles/screens/create_circle.dart';
import 'package:circlo/features/circles/screens/dashboard.dart';
import 'package:circlo/features/circles/screens/join_circle.dart';
import 'package:circlo/features/circles/screens/live_map.dart';
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
    GoRoute(
      path: AppRoutes.circleCreated,
      builder: (context, state) {
        final circleId = state.pathParameters['circleId']!;

        return CircleCreated(circleId: circleId);
      },
    ),

    GoRoute(
      path: AppRoutes.joinCircle,
      builder: (context, state) => JoinCircle(),
    ),
    GoRoute(
      path: AppRoutes.circleDashboard,
      builder: (context, state) {
        final circleId = state.pathParameters['circleId']!;

        return CircleDashboard(circleId: circleId);
      },
    ),
    GoRoute(path: "/map-test", builder: (context, state) => LiveMap()),
  ],
);
