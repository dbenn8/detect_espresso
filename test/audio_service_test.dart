import 'dart:async';
import 'package:detect_espresso/core/constants/logger_constant.dart';
import 'package:detect_espresso/core/services/auto_timer_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:detect_espresso/core/services/permission_service.dart';
import 'package:noise_meter/noise_meter.dart';

// Mock classes
class MockPermissionService extends Mock implements PermissionService {}

class MockNoiseMeter extends Mock implements NoiseMeter {}

class MockNoiseSubscription extends Mock
    implements StreamSubscription<NoiseReading> {}

class TestNoiseReading extends NoiseReading {
  TestNoiseReading(List<double> volumes) : super(volumes);
}

class MockLogger extends Mock implements Logger {}

void main() {
  late ProviderContainer container;
  late MockPermissionService mockPermissionService;
  late MockNoiseMeter mockNoiseMeter;
  late MockNoiseSubscription mockNoiseSubscription;
  late AutoTimerService autoTimerService;
  late StreamController<NoiseReading> streamController;

  setUp(() {
    mockPermissionService = MockPermissionService();
    mockNoiseMeter = MockNoiseMeter();
    mockNoiseSubscription = MockNoiseSubscription();

    container = ProviderContainer(overrides: [
      permissionServiceProvider.overrideWithValue(mockPermissionService),
      autoTimerServiceProvider
          .overrideWith((ref) => AutoTimerService(ref: ref)),
      loggerProvider.overrideWithValue(MockLogger()),
    ]);

    autoTimerService = container.read(autoTimerServiceProvider);

    container.read(loggerProvider).i('Test log message');

    // Configure MockNoiseMeter.noise to return a Stream
    streamController = StreamController<NoiseReading>();
    when(mockNoiseMeter.noise).thenAnswer((_) => streamController.stream);
    when(mockNoiseMeter.noise.listen(any, onError: anyNamed('onError')))
        .thenAnswer((Invocation invocation) {
      final onData =
          invocation.positionalArguments[0] as void Function(NoiseReading);
      final onError =
          invocation.namedArguments[const Symbol('onError')] as Function;

      streamController.stream.listen(onData, onError: onError);
      return mockNoiseSubscription;
    });
  });

  tearDown(() {
    container.dispose();
  });

  test('AutoTimerService detects first and end shot correctly', () async {
    // Callbacks
    bool firstShotDetected = false;
    double? shotDuration;

    // Start listening with provided callbacks
    await autoTimerService.beginLiveShotTimer(
      onFirstShotDetected: () {
        firstShotDetected = true;
      },
      onEndShotDetected: (duration) {
        shotDuration = duration;
      },
    );

    // Simulate noise readings
    streamController.add(TestNoiseReading([62, 63, 64])); // Start shot noise
    streamController.add(TestNoiseReading([65, 66, 67]));
    streamController.add(TestNoiseReading([64, 65, 66]));
    streamController.add(TestNoiseReading([63, 64, 65]));
    streamController.add(TestNoiseReading([59, 60, 61])); // End shot noise
    streamController.add(TestNoiseReading([58, 59, 60]));
    streamController.add(TestNoiseReading([57, 58, 59]));

    // Allow the stream to be processed
    await Future.delayed(Duration(seconds: 3));

    // Verify results
    expect(firstShotDetected, isTrue);
    expect(shotDuration, isNotNull);
    expect(shotDuration! > 0, isTrue);
  });
}
