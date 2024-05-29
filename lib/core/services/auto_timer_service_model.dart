part of 'auto_timer_service.dart';

enum AutoTimerStatus {
  idle,
  listening,
  shotStarted,
  shotCompleted,
  error,
}

class AutoTimerState {
  final bool isListening;
  final double? shotDuration;
  final AutoTimerStatus status;
  final String? errorMessage;

  AutoTimerState({
    required this.isListening,
    this.shotDuration,
    this.status = AutoTimerStatus.idle,
    this.errorMessage,
  });

  AutoTimerState copyWith({
    bool? isListening,
    double? shotDuration,
    AutoTimerStatus? status,
    String? errorMessage,
  }) {
    return AutoTimerState(
      isListening: isListening ?? this.isListening,
      shotDuration: shotDuration ?? this.shotDuration,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
