/// User-friendly Firebase exception handler
class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'Something went wrong. Please try again.';

      case 'invalid-argument':
        return 'Invalid input. Please check your data and try again.';

      case 'deadline-exceeded':
        return 'Request timed out. Please check your internet connection.';

      case 'not-found':
        return 'The requested data was not found.';

      case 'already-exists':
        return 'This data already exists.';

      case 'permission-denied':
        return 'You do not have permission to perform this action.';

      case 'resource-exhausted':
        return 'Server is busy. Please try again later.';

      case 'failed-precondition':
        return 'Unable to complete your request. Please try again.';

      case 'aborted':
        return 'The process was interrupted. Please try again.';

      case 'internal':
        return 'Server error occurred. Please try again later.';

      case 'unavailable':
        return 'Service is currently unavailable. Please check your internet connection.';

      case 'unauthenticated':
        return 'Your session has expired. Please log in again.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
