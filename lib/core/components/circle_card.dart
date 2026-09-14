import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/features/circles/models/circle_model.dart';
import 'package:flutter/material.dart';

class CircleCard extends StatelessWidget {
  final CircleModel? circle;
  final VoidCallback? onTap;

  const CircleCard({super.key, this.circle, this.onTap});

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return "C";
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return trimmed.substring(0, trimmed.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final title = circle?.name ?? "College Friends";
    final membersCount = circle?.members.length ?? 4;
    final initials = _getInitials(title);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      child: Text(initials),
                    ),
                    SizedBox(height: 12),
                    Text(title, style: AppFonts.cardTitle),
                    Text("$membersCount members", style: AppFonts.body),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: AppBorders.pill,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.group_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "$membersCount",
                        style: AppFonts.button.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

