import 'package:firebase_auth/firebase_auth.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';

class ExceptionHandler {
  static AppException handleException(exception) {
    if (exception is FirebaseAuthException) {
      switch (exception.code) {
         case 'weak-password':
          return AppException(
              code: "email_in_use_code", message: "The password is too weak");
        case 'email-already-in-use':
          return AppException(
              code: "email_in_use_code", message: "Email is already in use.");
        case 'user-not-found':
          return AppException(
              code: "user_not_found_code", message: "User not found.");
        case 'wrong-password':
          return AppException(
              code: "wrong_password_code", message: "Wrong password provided.");
        case 'user-disabled':
          return AppException(
              code: "user_disabled_code",
              message: "User account has been disabled.");
        case 'too-many-requests':
          return AppException(
              code: "too_many_requests_code",
              message: "Too many requests. Please try again later.");
        case 'operation-not-allowed':
          return AppException(
              code: "operation_not_allowed_code",
              message: "Operation not allowed.");
        case 'invalid-action-code':
          return AppException(
              code: "invalid_action_code", message: "Invalid action code.");
        case 'expired-action-code':
          return AppException(
              code: "expired_action_code", message: "Expired action code.");
        case 'invalid-email':
          return AppException(
              code: "invalid_email_code", message: "Invalid email address.");
        default:
          return AppException(
              code: "default_code", message: "An error occurred.");
      }
    } else {
      return AppException(
          code: "unknown_code", message: "An unknown error occurred.");
    }
  }
}
