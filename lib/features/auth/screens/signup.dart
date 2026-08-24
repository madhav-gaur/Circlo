import 'dart:developer';

import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/text_field.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _cPasswordController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _cPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0F0F172A),
                    blurRadius: 16.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create Account",
                    style: AppFonts.screenTitle.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),

                  Text(
                    "Sign up to start sharing your live location securely.",
                    style: AppFonts.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          controller: _nameController,
                          label: "Name",
                          prefixIcon: Icons.person,
                          validator: (val) {
                            if (val == null) return "Provide Name";
                            if (val.length < 2) {
                              return "Name should be at Least 3 Charcter Long";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        AppTextField(
                          controller: _emailController,
                          label: "Email",
                          prefixIcon: Icons.email,
                          validator: (val) {
                            if (val!.isEmpty) return "Provide Email";
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        AppTextField(
                          controller: _passwordController,
                          isPassword: true,
                          prefixIcon: Icons.password,
                          label: "Password",
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be 6 character long";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        AppTextField(
                          controller: _cPasswordController,
                          isPassword: true,
                          prefixIcon: Icons.password,
                          label: "Confirm Password",
                          validator: (val) {
                            if (val != _passwordController.text) {
                              return "Confirm Password doesn't match";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  PrimaryButton(
                    label: "Sign Up",
                    onPressed: () async {
                      final user = await AuthService().signup(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ); 
                      log(user.toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
