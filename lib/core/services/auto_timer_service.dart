import 'package:detect_espresso/core/constants/audio_contant.dart';
import 'package:detect_espresso/core/constants/logger_constant.dart';
import 'package:detect_espresso/core/services/permission_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_timer_service.g.dart';

@riverpod
AutoTimerService autoTimerService(AutoTimerServiceRef ref) {
  return AutoTimerService(ref: ref);
}

/// [AutoTimerService] is a service that listens to the noise levels in the environment
/// to detect the start and end of an espresso shot.
/// It uses the [NoiseMeter] package to listen to the noise levels.
/// It listens to the noise levels and detects the start and end of an espresso shot
/// based on the noise levels.
///
///
class AutoTimerService {
  /// The subscription to the noise meter readings.
  /// This is used to cancel the subscription when the timer is stopped.
  /// This is also used to listen to the noise meter readings.
  ///
  ///
  StreamSubscription<NoiseReading>? _noiseSubscription;

  /// The noise meter used to listen to the noise levels.
  NoiseMeter? _noiseMeter;

  /// The start time of the shot.
  DateTime? _startTime;

  /// The end time of the shot.
  DateTime? _endTime;

  /// List to store recent noise levels for detecting espresso shot start and end.
  ///
  final List<double> _noiseSequence = [];

  final Ref _ref;

  AutoTimerService({required Ref ref}) : _ref = ref;

  PermissionService get permissionService =>
      _ref.read(permissionServiceProvider);

  Logger get logger => _ref.read(loggerProvider);

  /// Starts the live shot timer by listening to noise meter readings.
  /// Calls [onFirstShotDetected] when the espresso shot is first detected.
  /// Calls [onEndShotDetected] with the duration of the shot when the shot ends.
  Future<void> beginLiveShotTimer({
    required VoidCallback onFirstShotDetected,
    required void Function(double duration) onEndShotDetected,
  }) async {
    _noiseMeter ??= NoiseMeter();
    _noiseSubscription = _noiseMeter?.noise.listen(
      (noiseReading) =>
          _onData(noiseReading, onFirstShotDetected, onEndShotDetected),
      onError: _onError,
    );
  }

  /// Stops listening to the noise meter readings and cancels any active subscriptions.
  Future<void> stopListening() async {
    await _noiseSubscription?.cancel();
  }

  void _onData(NoiseReading noiseReading, VoidCallback onFirstShotDetected,
      void Function(double duration) onEndShotDetected) {
    double noiseLevel = noiseReading.meanDecibel;
    logger.i("Noise level: $noiseLevel");

    // Add the current noise level to the sequence
    _noiseSequence.add(noiseLevel);
    if (_noiseSequence.length > AudioConstant.sequenceLength) {
      _noiseSequence.removeAt(0);
    }

    // Check if the sequence indicates the start of a shot
    if (_noiseSequence.length == AudioConstant.sequenceLength &&
        _noiseSequence.every((level) => level > AudioConstant.startThreshold) &&
        _startTime == null) {
      _startTime = DateTime.now();
      logger.i("First shot detected");
      onFirstShotDetected();
    }

    // Check if the sequence indicates the end of a shot
    if (_noiseSequence.length == AudioConstant.sequenceLength &&
        _noiseSequence.every((level) => level < AudioConstant.endThreshold) &&
        _startTime != null) {
      _endTime = DateTime.now();
      double duration = (_endTime!.millisecondsSinceEpoch.toDouble() -
              _startTime!.millisecondsSinceEpoch.toDouble()) /
          1000;
      _startTime = null;
      onEndShotDetected(duration);
      logger.i("End shot detected");
      _noiseSequence.clear();
    }
  }

  void _onError(Object error) {
    logger.e("Noise meter error: $error");
    stopListening();
  }
}
