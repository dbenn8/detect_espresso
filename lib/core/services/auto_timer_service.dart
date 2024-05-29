import 'package:detect_espresso/core/constants/audio_contant.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';

class AutoTimerService {
  StreamSubscription<NoiseReading>? _noiseSubscription;
  bool _isListening = false;
  late NoiseMeter _noiseMeter;
  double _startTime = 0.0;
  double _endTime = 0.0;
  bool _shotInProgress = false;

  AutoTimerService() {
    _noiseMeter = NoiseMeter();
  }

  void onError(Object error) {
    _isListening = false;
  }

  void beginLiveShotTimer(Function(double) onShotCompleted) {
    if (_isListening) return;

    _isListening = true;
    _noiseSubscription = _noiseMeter.noise.listen((NoiseReading noiseReading) {
      double noiseLevel = noiseReading.meanDecibel;

      if (!_shotInProgress && noiseLevel > AudioContant.startThreshold) {
        _shotInProgress = true;
        _startTime = DateTime.now().millisecondsSinceEpoch / 1000.0;
      }

      if (_shotInProgress && noiseLevel < AudioContant.endThreshold) {
        _endTime = DateTime.now().millisecondsSinceEpoch / 1000.0;
        _shotInProgress = false;
        double duration = _endTime - _startTime;
        onShotCompleted(duration);
        stopListening();
      }
    });
  }

  void stopListening() {
    _isListening = false;
    _noiseSubscription?.cancel();
  }
}
