part of 'pages.dart';

class ExpressoTimerPage extends ConsumerStatefulWidget {
  const ExpressoTimerPage({super.key});

  @override
  ConsumerState<ExpressoTimerPage> createState() => _ExpressoTimerPageState();
}

class _ExpressoTimerPageState extends ConsumerState<ExpressoTimerPage> {
  @override
  void initState() {
    super.initState();
    setup();
  }

  Future<void> setup() async {
    final permissionStatus =
        await ref.read(permissionServiceProvider).microphonePermissionStatus;
    if (permissionStatus.isGranted) {
      ref.read(shotTimerProviderProvider.notifier).startListening();
    } else {
      RequestPermissionSheet.show(context);
    }
  }

  @override
  void deactivate() {
    ref.read(shotTimerProviderProvider.notifier).stopListening();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen(
      shotTimerProviderProvider,
      (previous, next) {
        next.when(
          idle: () => null,
          inProgress: (startTime) {
            CoffeeBrewingInProgressSheet.show(context);
          },
          completed: (duration) {
            context.showSnackBar(
              'Espresso shot completed in ${duration.toStringAsFixed(2)}s',
            );
            Future.delayed(
              const Duration(seconds: 10),
              () {
                ref.read(shotTimerProviderProvider.notifier).startListening();
              },
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
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
            ShotTimer(),
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
            ),
            SizedBox(height: MediaQuery.maybeOf(context)?.padding.bottom),
          ],
        ),
      ),
    );
  }
}
