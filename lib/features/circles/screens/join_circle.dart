import 'dart:developer';

import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/text_field.dart';
import 'package:circlo/core/router/routes.dart';
import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/core/themes/paddings.dart';
import 'package:circlo/core/widgets/member_tile.dart';
import 'package:circlo/features/circles/providers/circle_provider.dart';
import 'package:circlo/features/circles/services/circle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JoinCircle extends ConsumerStatefulWidget {
  const JoinCircle({super.key});

  @override
  ConsumerState<JoinCircle> createState() => _JoinCircleState();
}

class _JoinCircleState extends ConsumerState<JoinCircle> {
  late TextEditingController _inviteController;

  final _formKey = GlobalKey<FormState>();
  String? joinError;
  bool isJoining = false;

  @override
  void initState() {
    super.initState();
    _inviteController = TextEditingController();
  }

  @override
  void dispose() {
    _inviteController.dispose();
    super.dispose();
  }

  Future<void> _showJoined(String circleId) async {
    if (!mounted) return;
    try {
      showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        context: context,
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: AppBorders.largeBottom),
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Consumer(
              builder: (context, ref, child) {
                final circleAsync = ref.watch(circleProvider(circleId));
                return circleAsync.when(
                  error: (e, s) => Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text('Error: $e'),
                  ),
                  loading: () => Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  data: (circle) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.secondary.withAlpha(
                                40,
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: AppColors.secondary,
                                size: 50,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              "Sucessfully Joined ${circle?.name ?? ''}",
                              style: AppFonts.screenTitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Members (${circle?.members.length ?? 0})",
                            style: AppFonts.cardTitle,
                          ),
                          if (circle != null)
                            Column(
                              children: List.generate(
                                circle.members.length > 5
                                    ? 5
                                    : circle.members.length,
                                (index) {
                                  final uid = circle.members[index];
                                  return MemberTile(memberId: uid);
                                },
                              ),
                            ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            label: "Back Home",
                            onPressed: () => context.go(AppRoutes.dashboard),
                          ),
                          const SizedBox(height: 12),
                          PrimaryButton(
                            label: "View Circle",
                            onPressed: () {
                              if (circle != null) {
                                context.go(
                                  AppRoutes.circleCreated.replaceFirst(
                                    ':circleId',
                                    circle.circleId,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> handleJoinCircle() async {
    if (!_formKey.currentState!.validate() || isJoining) {
      return;
    }

    setState(() {
      isJoining = true;
    });

    try {
      log("Joining circle...");

      final circleId = await CircleService().joinCircleByInviteCode(
        inviteCode: _inviteController.text.trim(),
      );
      if (circleId == null) {
        setState(() {
          joinError = "Invalid invite code.";
        });
        return;
      }

      log("Joined circle: $circleId");
      await _showJoined(circleId);
    } catch (e, stackTrace) {
      log("Failed to join circle", error: e, stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        if (e.toString().contains("INVALID_INVITE")) {
          joinError = "Invalid invite code.";
        } else if (e.toString().contains("ALREADY_MEMBER")) {
          joinError = "You're already a member of this circle.";
        } else {
          joinError = "Something went wrong. Please try again.";
        }
      });
    } finally {
      if (mounted) {
        setState(() {
          isJoining = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Circlo")),
      body: ListView(
        padding: AppPadding.pagePadding,
        children: [
          const SizedBox(height: 64),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppBorders.medium,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Join a Circle", style: AppFonts.screenTitle),

                  const SizedBox(height: 12),

                  Text(
                    "Enter invite code shared by your friend to connect",
                    style: AppFonts.body,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

                  AppTextField(
                    controller: _inviteController,
                    label: "Invite Code",
                    prefixIcon: Icons.insert_invitation_outlined,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Provide Invite Code";
                      }

                      return null;
                    },
                  ),
                  if (joinError != null) ...[
                    const SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        joinError!,
                        style: AppFonts.body.copyWith(color: AppColors.danger),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  PrimaryButton(
                    label: "Join Circle",
                    onPressed: handleJoinCircle,
                    isLoading: isJoining,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
