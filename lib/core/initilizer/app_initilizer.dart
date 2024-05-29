import 'dart:async';
import 'package:detect_espresso/core/constants/logger_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/// A function that initializes the app by setting up error handling and running the app within a guarded zone.
/// [builder] is a function that returns a Future of a Widget which will be the root of the widget tree.
Future<void> initilizer(FutureOr<Widget> Function() builder) async {
  final container = ProviderContainer();
  container.read(loggerProvider).d('App initilizer started');
  FlutterError.onError = (details) {
    container.read(loggerProvider).e(
          details.exceptionAsString(),
          stackTrace: details.stack,
          error: details.exception,
        );
  };
  runZonedGuarded<Future<void>>(
    () async {
      runApp(
        ProviderScope(
          child: await builder(),
        ),
      );
    },
    (error, stackTrace) {
      container.read(loggerProvider).e(
            error.toString(),
            stackTrace: stackTrace,
            error: error,
          );
    },
  );
}
