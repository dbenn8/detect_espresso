import 'package:detect_espresso/core/extensions/sizer_extension.dart';
import 'package:detect_espresso/core/services/permission_service.dart';
import 'package:detect_espresso/core/theme/app_colors.dart';
import 'package:detect_espresso/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestPermissionSheet extends ConsumerWidget {
  const RequestPermissionSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const RequestPermissionSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: 20.allPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.verticalSpacing,
          const Icon(Icons.warning, color: AppColors.primaryColor, size: 48),
          16.verticalSpacing,
          Text(
            "Permission Required",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          16.verticalSpacing,
          Text(
            "To use the shot timer, we need access to your microphone.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          16.verticalSpacing,
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              title: 'Request Permission',
              onPressed: () async {
                final granted = await ref
                    .read(permissionServiceProvider)
                    .requestMicrophonePermission();
                if (granted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          20.verticalSpacing,
        ],
      ),
    );
  }
}
