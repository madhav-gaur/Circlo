import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const new({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Profile"),
      ],
    );
  }
}