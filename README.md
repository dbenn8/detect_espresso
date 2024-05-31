# Detect Espresso

Detect Espresso is a Flutter application that uses noise meter functionality to detect espresso machine sounds. This project demonstrates how to implement real-time audio monitoring and event detection in a Flutter app.

## Features

- **Live Shot Detection**: Detects the start and end of an espresso shot based on noise levels.
- **Real-time Monitoring**: Continuously monitors noise levels to detect espresso machine sounds.
- **Event Logging**: Logs events such as the start and end of shots along with their durations.
- **Settings Interface**: Allows users to adjust thresholds and sequence length for detection.

## Findings

1. **Effective Shot Detection:** The project successfully detects the start and end of espresso shots based on noise levels, enhancing user experience and functionality.

2. **Real-time Monitoring:** The real-time monitoring of noise levels allows for immediate feedback and response to espresso machine activities, improving user interaction.

3. **Adjustable Thresholds:** The ability to adjust thresholds for shot detection provides flexibility for different environments and user preferences, enhancing the robustness of the application.

4. **Logging and Event Handling:** Logging events such as the start and end of shots, along with their durations, provides valuable data for analysis and troubleshooting, improving system monitoring and maintenance.

## Drawbacks

1. **Threshold Sensitivity:** Sensitivity of threshold levels may lead to false positives or negatives in shot detection, impacting the accuracy of the application in varying noise environments.

2. **Sequence Length Impact:** The sequence length used for noise level analysis could impact responsiveness and accuracy, requiring a balance between quick detection and noise fluctuations.

3. **Resource Consumption:** Continuous monitoring of noise levels and real-time processing can consume significant device resources, requiring optimization for improved performance and user experience.

4. **Error Handling and Resilience:** Robust error handling and resilience in case of noise meter failures are essential for maintaining application reliability, requiring careful resource management and recovery strategies.

5. **User Interface and Feedback:** Clear user interface feedback based on shot detection events can enhance user experience, requiring intuitive visual indicators or notifications for better user interaction.

Addressing these drawbacks through testing, optimization, error handling improvements, and user interface enhancements can further improve the performance and usability of the application.

## Future Enhancements

1. **Custom Threshold Profiles:** Implementing custom threshold profiles for different espresso machines or environments can enhance detection accuracy and user customization.

2. **Logging and Analytics:** Integrating logging and analytics features for shot detection events can provide valuable insights for users and developers, improving system monitoring and analysis.

## Getting Started

To run this project on your local machine, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/your_username/detect_espresso.git
```

2. Navigate to the project directory:

```bash
cd detect_espresso
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

Optionally, There is a Test file in the test folder that you can run to test the AutoTimerService class. The Test May not work as expected or even may fail.

**Note**: This project is tested on iOS devices. It may not work as expected on Android devices.

Configuration
You can adjust the following settings in the AutoTimerService class:

- `startThreshold`: The noise level threshold for detecting the start of an espresso shot.
- `endThreshold`: The noise level threshold for detecting the end of an espresso shot.
- `sequenceLength`: the length of the sequence of noise levels used to determine the start and end of an espresso shot. This value defines how many consecutive noise readings are considered to detect a shot.

Please note that these settings may need to be adjusted based on the noise levels of your espresso machine and environment.

## Dependencies

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [noise_meter](https://pub.dev/packages/noise_meter)
- [permission_handler](https://pub.dev/packages/permission_handler)
- [logger](https://pub.dev/packages/logger)
- [freezed_annotation](https://pub.dev/packages/freezed_annotation)
- [lottie](https://pub.dev/packages/lottie)
- [avatar_glow](https://pub.dev/packages/avatar_glow)

## Conclusion

This project demonstrates the implementation of real-time audio monitoring and event detection in a Flutter application. By detecting espresso machine sounds based on noise levels, the application enhances user experience and functionality. Addressing the identified drawbacks and implementing future enhancements can further improve the performance and usability of the application. The project provides a foundation for developing similar real-time monitoring and event detection applications in Flutter.
