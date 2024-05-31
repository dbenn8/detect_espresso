part of '../pages/pages.dart';

class CoffeeBrewingInProgressSheet extends ConsumerWidget {
  const CoffeeBrewingInProgressSheet({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) => const CoffeeBrewingInProgressSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      shotTimerProviderProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          completed: (_) {
            Navigator.of(context).pop();
          },
        );
      },
    );

    return Padding(
      padding: 12.allPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.brewCoffeeAnimation,
            repeat: true,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          16.verticalSpacing,
          Text(
            'Brewing Coffee',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          4.verticalSpacing,
          Text(
            'Please wait while we detect the espresso shot. This may take a few seconds.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          30.verticalSpacing,
        ],
      ),
    );
  }
}
