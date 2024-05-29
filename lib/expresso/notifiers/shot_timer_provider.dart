import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shot_timer_provider.freezed.dart';

part "shot_timer_provider.freezed.dart";
part 'shot_timer_provider.g.dart';

@freezed
class ShotTimerState with _$ShotTimerState {
  const factory ShotTimerState.idle() = _Idle;
  const factory ShotTimerState.inProgress(double startTime) = _InProgress;
  const factory ShotTimerState.completed(double duration) = _Completed;
}

@riverpod
class ShotTimerProvider extends _$ShotTimerProvider {
  ShotTimerState build() {
    return const ShotTimerState.idle();
  }
}
