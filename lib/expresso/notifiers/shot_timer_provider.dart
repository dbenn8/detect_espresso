import 'package:detect_espresso/core/constants/logger_constant.dart';
import 'package:detect_espresso/core/services/auto_timer_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "shot_timer_provider.freezed.dart";
part 'shot_timer_provider.g.dart';

@freezed
class ShotTimerState with _$ShotTimerState {
  const factory ShotTimerState.idle() = _Idle;
  const factory ShotTimerState.inProgress(double startTime) = _InProgress;
  const factory ShotTimerState.completed(double duration) = _Completed;
}

@Riverpod(keepAlive: true)
class ShotTimerProvider extends _$ShotTimerProvider {
  late final AutoTimerService _autoTimerService;

  Logger get _logger => ref.read(loggerProvider);

  @override
  ShotTimerState build() {
    _autoTimerService = AutoTimerService(ref: ref);
    return const ShotTimerState.idle();
  }

  void startListening() {
    _autoTimerService.beginLiveShotTimer(
      onEndShotDetected: (duration) {
        state = ShotTimerState.completed(duration);
        stopListening();
      },
      onFirstShotDetected: () {
        state = ShotTimerState.inProgress(
          DateTime.now().millisecondsSinceEpoch.toDouble(),
        );
      },
    );
    _logger.i('state is $state');
  }

  void stopListening() {
    _autoTimerService.stopListening();
  }
}
