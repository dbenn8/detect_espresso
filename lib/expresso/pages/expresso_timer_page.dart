part of 'pages.dart';

class ExpressoTimerPage extends ConsumerWidget {
  const ExpressoTimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shotTimerState = ref.watch(shotTimerProvider);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () {
            // Handle back button
          },
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: 16.allPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ShotPlanCard(),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Text("Shot Timer", style: theme.textTheme.headlineMedium),
                  16.verticalSpacing,
                  Text("0.0s", style: theme.textTheme.headlineMedium),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "I Measure My Own Time",
                  style: TextStyle(
                    color: AppColors.lightBlueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            16.verticalSpacing,
            CustomButton(
              title: 'Start Timer',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
