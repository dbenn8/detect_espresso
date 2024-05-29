import 'package:detect_espresso/core/theme/app_colors.dart';
import 'package:detect_espresso/expresso/pages/pages.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expresso',
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
      ),
      home: const ExpressoTimerPage(),
    );
  }
}
