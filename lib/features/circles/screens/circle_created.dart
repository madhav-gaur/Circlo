import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/router/routes.dart';
import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/core/themes/paddings.dart';
import 'package:circlo/core/widgets/member_tile.dart';
import 'package:circlo/features/circles/providers/circle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class CircleCreated extends ConsumerWidget {
  final String circleId;
  const CircleCreated({super.key, required this.circleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final circleAsync = ref.watch(circleProvider(circleId));
    return Scaffold(
      body: circleAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (data) {
          final circle = data!;
          return ListView(
            padding: AppPadding.pagePadding,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 42),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.secondary.withAlpha(40),
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.secondary,
                          size: 70,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(
                        "Circle Created ",
                        style: AppFonts.screenTitle,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Create private space for your people",
                        style: AppFonts.body,
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppBorders.small,
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Invite your friends using this code",
                            style: AppFonts.caption,
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              borderRadius: AppBorders.medium,
                              color: AppColors.background,
                            ),
                            child: Center(
                              child: Text(
                                circle.inviteCode,
                                style: AppFonts.screenTitle.copyWith(
                                  letterSpacing: 8,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  label: "Copy Code",
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: circle.inviteCode),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  label: "Share Invite",
                                  onPressed: () async {
                                    await SharePlus.instance.share(
                                      ShareParams(
                                        text:
                                            "Hey!! Join my circle using my invite Code: ${circle.inviteCode}",
                                        title: "Share Invite Code",
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Members (${circle.members.length})",
                      style: AppFonts.cardTitle,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppBorders.small,
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        children: List.generate(circle.members.length, (index) {
                          final uid = circle.members[index];
                          return MemberTile(memberId: uid);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: "Go to Circle",
          onPressed: () {
            context.go(AppRoutes.dashboard);
          },
        ),
      ),
    );
  }
}
