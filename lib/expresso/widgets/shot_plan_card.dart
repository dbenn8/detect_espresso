part of '../pages/pages.dart';

class ShotPlanCard extends StatelessWidget {
  const ShotPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: 16.allPadding,
      decoration: BoxDecoration(
        color: AppColors.iceBlueColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shot\nPlan", style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Column(
                children: [
                  Text("41g", style: theme.textTheme.displayLarge),
                  Text("Yield", style: theme.textTheme.bodyLarge),
                ],
              ),
              Column(
                children: [
                  Text("23s", style: theme.textTheme.displayLarge),
                  Text("Seconds", style: theme.textTheme.bodyLarge),
                ],
              ),
            ],
          ),
          16.verticalSpacing,
          Row(
            children: [
              CustomPaint(
                size: const Size(50, 20),
                painter: HalfArchPainter(),
              ),
              16.horizontalSpacing,
              Column(
                children: [
                  Text(
                    "Pre-infusish Max 9",
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "(was 10sec@2-4 bar)",
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
