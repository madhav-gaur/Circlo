import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/text_field.dart';
import 'package:circlo/core/router/routes.dart';
import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/core/themes/paddings.dart';
import 'package:circlo/features/circles/services/circle_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateCircle extends StatefulWidget {
  const new({super.key,});

  @override
  State<CreateCircle> createState() => _CreateCircleState();
}

class _CreateCircleState extends State<CreateCircle> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (!mounted) return;
      return;
    }

    setState(() => isLoading = true);
    try {
      final circleId = await CircleService().createCircle(
        creatorUid: currentUser.uid,
        name: _nameController.text.trim(),
      );

      if (context.mounted && circleId != null) {
        context.go(AppRoutes.circleCreated.replaceFirst(':circleId', circleId));
      }
    } catch (e) {
      if (!mounted) return;
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

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
          Form(
            key: _formKey,
            child: Container(
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
                    controller: _nameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Provide Name";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          PrimaryButton(
            isLoading: isLoading,
            label: "Create Circle",
            onPressed: () => _handleSubmit(),
          ),
        ],
      ),
    );
  }
}
