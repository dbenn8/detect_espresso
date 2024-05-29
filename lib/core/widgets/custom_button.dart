import 'package:detect_espresso/core/extensions/sizer_extension.dart';
import 'package:detect_espresso/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.icon,
    this.radius,
  });

  final String title;
  final VoidCallback onPressed;
  final bool loading;
  final bool disabled;
  final Widget? icon;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      icon: loading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
              ),
            )
          : icon,
      onPressed: (disabled || loading) ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        padding: WidgetStateProperty.all(16.verticalPadding),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 24.0),
          ),
        ),
      ),
      label: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
