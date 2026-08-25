import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.0, // Optimized minimum touch target size
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.textDisabled,
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.small),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppColors.surface,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                label,
                style: AppFonts.button.copyWith(color: AppColors.surface),
              ),
      ),
    );
  }
}
