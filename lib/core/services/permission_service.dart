import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_service.g.dart';

@riverpod
PermissionService permissionService(PermissionServiceRef ref) =>
    PermissionServiceImpl();

abstract class PermissionService {
  /// Get the microphone permission status.
  /// This will return the [PermissionStatus] of the microphone permission.
  /// returns the [PermissionStatus] of the permission.
  ///
  Future<PermissionStatus> get microphonePermissionStatus;

  /// Request the microphone permission.
  /// This will request the microphone permission.
  /// returns the [bool] if the permission is granted.
  /// else it will return false.
  ///
  Future<bool> requestMicrophonePermission();
}

/// This service is used to manage the permissions.
/// The permissions are used to manage the permissions of the app.
///
///
class PermissionServiceImpl implements PermissionService {
  @override
  Future<PermissionStatus> get microphonePermissionStatus async =>
      await Permission.microphone.status;

  @override
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
}
