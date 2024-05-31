/// [AudioConstant] is a class that contains all the audio related constants.
class AudioConstant {
  /// dB also known as decibel level indicating shot start for a expresso shot.
  /// This is used to determine the start of a shot.
  /// [startThreshold] is used to determine the start of a shot.
  static const double startThreshold = 70.0;

  /// dB also known as decibel level indicating shot end for a expresso shot.
  /// This is used to determine the end of a shot.
  /// [endThreshold] is used to determine the end of a shot.
  static const double endThreshold = 65.0;

  /// The length of the sequence of noise levels used to determine the start and end of an espresso shot.
  ///
  /// This value defines how many consecutive noise readings are considered to detect a shot.
  ///
  static const int sequenceLength = 2;
}
