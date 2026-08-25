import 'dart:developer';

import 'package:circlo/core/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatefulWidget {
  const new({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              log(FirebaseAuth.instance.currentUser.toString());
              context.go(AppRoutes.signup);
            },
            child: Text("Sign Out"),
          ),
        ),
      ),
    );
  }
}
