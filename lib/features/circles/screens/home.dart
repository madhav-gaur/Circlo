import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/circle_card.dart';
import 'package:circlo/core/router/routes.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: 80),
          children: [
            SizedBox(height: 12),
            ElevatedButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              context.go(AppRoutes.signin);
            }, child: Text("Sign Out")),
            Text(
              "Good afternoon, Madhav",
              style: AppFonts.sectionTitle.copyWith(fontSize: 28),
            ),
            Text(
              "Here's whats happening in your Circles today.",
              style: AppFonts.body,
            ),
            SizedBox(height: 24),
            Text("Your Circles", style: AppFonts.sectionTitle),
            SizedBox(height: 12),
            CircleCard(),
            CircleCard(),
            CircleCard(),
            CircleCard(),
            CircleCard(),
            CircleCard(),
            SizedBox(height: 100),
          ],
        ),
        Positioned(
          bottom: 85,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PrimaryButton(
                  label: "+ Create Circle",
                  onPressed: () => context.push(AppRoutes.createCircle),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SecondaryButton(
                  label: "Join a Circle",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
