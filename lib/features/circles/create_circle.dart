import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/text_field.dart';
import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/core/themes/paddings.dart';
import 'package:flutter/material.dart';

class CreateCircle extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateCircle> createState() => _CreateCircleState();
}

class _CreateCircleState extends State<CreateCircle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Circlo")),
      body: ListView(
        padding: AppPadding.pagePadding,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 12),
                CircleAvatar(
                  radius: 42,
                  backgroundColor: AppColors.lightGrey,
                  child: Icon(
                    Icons.group_add_outlined,
                    color: AppColors.primary,
                    size: 40,
                  ),
                ),
                SizedBox(height: 12),
                Text("Create Circle", style: AppFonts.screenTitle),
                Text(
                  "Create private space for your people",
                  style: AppFonts.body,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppBorders.small,
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Circle Name", style: AppFonts.cardTitle),
                SizedBox(height: 12),
                AppTextField(
                  label: "Circle Name",
                  prefixIcon: Icons.add_circle_outline_outlined,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          PrimaryButton(label: "Create Circle", onPressed: () {}),
        ],
      ),
    );
  }
}
