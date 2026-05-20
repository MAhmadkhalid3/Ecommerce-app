import 'package:flutter/services.dart';

/// User-friendly Platform exception handler
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'Network error. Please check your internet connection.';

      case 'timeout':
        return 'Request timed out. Please try again.';

      case 'invalid_credentials':
        return 'Invalid credentials. Please check and try again.';

      case 'sign_in_failed':
        return 'Sign in failed. Please try again.';

      case 'sign_out_failed':
        return 'Sign out failed. Please try again.';

      case 'not_available':
        return 'This feature is not available on your device.';

      case 'permission_denied':
        return 'Permission denied. Please allow required permissions.';

      case 'camera_access_denied':
        return 'Camera access denied. Please allow camera permission.';

      case 'storage_access_denied':
        return 'Storage access denied. Please allow storage permission.';

      case 'microphone_access_denied':
        return 'Microphone access denied. Please allow microphone permission.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
