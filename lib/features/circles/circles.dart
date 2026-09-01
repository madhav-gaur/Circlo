import 'package:flutter/material.dart';

class Circles extends StatefulWidget {
  const new({super.key});

  @override
  State<Circles> createState() => _CirclesState();
}

class _CirclesState extends State<Circles> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Circle"),
      ],
    );
  }
}