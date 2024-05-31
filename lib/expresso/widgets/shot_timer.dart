part of '../pages/pages.dart';

class ShotTimer extends ConsumerWidget {
  const ShotTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final shotTimerState = ref.watch(shotTimerProviderProvider);
    return Center(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "Shot Timer",
              style: theme.textTheme.headlineMedium,
              children: [
                WidgetSpan(child: 10.horizontalSpacing),
                shotTimerState.when(
                  idle: () => TextSpan(),
                  inProgress: (startTime) => WidgetSpan(
                    child: AvatarGlow(
                      animate: true,
                      glowColor: AppColors.greenColor,
                      child: Icon(
                        Icons.coffee,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ),
                  completed: (duration) => WidgetSpan(
                    child: Icon(
                      Icons.check,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpacing,
          Text(
            shotTimerState.maybeWhen(
              orElse: () => "0.0s",
              completed: (duration) {
                return "${duration.toStringAsFixed(2)}s";
              },
              idle: () => "0.0s",
            ),
            style: theme.textTheme.headlineLarge?.copyWith(
              fontSize: 60,
            ),
          ),
        ],
      ),
    );
  }
}
