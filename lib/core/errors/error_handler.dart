import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static final Logger _logger = Logger();

  // Log error without showing to user
  static void logError(
    dynamic error,
    StackTrace stackTrace, {
    String? message,
  }) {
    _logger.e(
      message ?? 'Error occurred',
      error: error,
      stackTrace: stackTrace,
    );
  }

  // Show error to user
  static void showError(
    BuildContext context, {
    required String message,
    dynamic error,
    StackTrace? stackTrace,
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Log error
    if (error != null || stackTrace != null) {
      logError(error, stackTrace ?? StackTrace.current, message: message);
    } else {
      _logger.e(message);
    }

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        duration: duration,
        action: onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }

  // Show success message
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        duration: duration,
      ),
    );
  }

  // Show warning message
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange.shade700,
        duration: duration,
      ),
    );
  }

  // Handle error with custom dialog
  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    dynamic error,
    StackTrace? stackTrace,
    VoidCallback? onRetry,
  }) {
    // Log error
    if (error != null || stackTrace != null) {
      logError(
        error,
        stackTrace ?? StackTrace.current,
        message: '$title: $message',
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          if (onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onRetry();
              },
              child: const Text('Retry'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Handle network errors
  static String getNetworkErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Connection timeout. Please try again.';
    } else if (error.toString().contains('Connection refused')) {
      return 'Server is not responding. Please try again later.';
    } else {
      return 'Network error occurred. Please try again.';
    }
  }

  // Handle API errors
  static String getApiErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return "Access denied. You don't have permission.";
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Server error. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Handle Supabase errors
  static String getSupabaseErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network')) {
      return 'Network error connecting to server.';
    } else if (errorString.contains('timeout')) {
      return 'Connection timeout. Please try again.';
    } else if (errorString.contains('auth') ||
        errorString.contains('unauthorized')) {
      return 'Authentication failed. Please login again.';
    } else if (errorString.contains('permission')) {
      return 'Permission denied.';
    } else if (errorString.contains('not found')) {
      return 'Resource not found.';
    } else {
      return 'Server error occurred.';
    }
  }
}

// Extension for easier use
extension ErrorHandlerExtension on BuildContext {
  void showError(String message, {dynamic error, VoidCallback? onRetry}) {
    ErrorHandler.showError(
      this,
      error: error,
      message: message,
      onRetry: onRetry,
    );
  }

  void showSuccess(String message) {
    ErrorHandler.showSuccess(this, message);
  }

  void showWarning(String message) {
    ErrorHandler.showWarning(this, message);
  }

  Future<void> showErrorDialog({
    required String title,
    required String message,
    dynamic error,
    VoidCallback? onRetry,
  }) {
    return ErrorHandler.showErrorDialog(
      this,
      title: title,
      message: message,
      error: error,
      onRetry: onRetry,
    );
  }
}
