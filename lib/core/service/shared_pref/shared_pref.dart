import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Injectable SharedPreferences service with proper error handling
class SharedPref {
  
  // Private constructor for factory method
  SharedPref._(this._prefs, this._logger);
  
  /// For testing - allow injection of mock SharedPreferences
  factory SharedPref.fromPrefs(SharedPreferences prefs, {Logger? logger}) {
    return SharedPref._(prefs, logger ?? Logger());
  }
  final SharedPreferences _prefs;
  final Logger _logger;
  
  /// Factory method to create instance with dependencies
  static Future<SharedPref> create() async {
    final prefs = await SharedPreferences.getInstance();
    final logger = Logger();
    return SharedPref._(prefs, logger);
  }

  /// Set string value with error handling
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e, stackTrace) {
      _logger.e('Failed to set string for key: $key', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Get string value with fallback
  String? getString(String key, {String? defaultValue}) {
    try {
      return _prefs.getString(key) ?? defaultValue;
    } catch (e, stackTrace) {
      _logger.e('Failed to get string for key: $key', error: e, stackTrace: stackTrace);
      return defaultValue;
    }
  }

  /// Set boolean value with error handling
  Future<bool> setBoolean(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e, stackTrace) {
      _logger.e('Failed to set boolean for key: $key', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Get boolean value with fallback
  bool? getBoolean(String key, {bool? defaultValue}) {
    try {
      return _prefs.getBool(key) ?? defaultValue;
    } catch (e, stackTrace) {
      _logger.e('Failed to get boolean for key: $key', error: e, stackTrace: stackTrace);
      return defaultValue;
    }
  }

  /// Set double value with error handling
  Future<bool> setDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e, stackTrace) {
      _logger.e('Failed to set double for key: $key', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Get double value with fallback
  double? getDouble(String key, {double? defaultValue}) {
    try {
      return _prefs.getDouble(key) ?? defaultValue;
    } catch (e, stackTrace) {
      _logger.e('Failed to get double for key: $key', error: e, stackTrace: stackTrace);
      return defaultValue;
    }
  }

  /// Set int value with error handling
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e, stackTrace) {
      _logger.e('Failed to set int for key: $key', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Get int value with fallback
  int? getInt(String key, {int? defaultValue}) {
    try {
      return _prefs.getInt(key) ?? defaultValue;
    } catch (e, stackTrace) {
      _logger.e('Failed to get int for key: $key', error: e, stackTrace: stackTrace);
      return defaultValue;
    }
  }

  /// Check if key exists
  bool containsKey(String key) {
    try {
      return _prefs.containsKey(key);
    } catch (e, stackTrace) {
      _logger.e('Failed to check key: $key', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Remove preference with error handling
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e, stackTrace) {
      _logger.e('Failed to remove key: $key', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Clear all preferences with error handling
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e, stackTrace) {
      _logger.e('Failed to clear preferences', error: e, stackTrace: stackTrace);
      return false;
    }
  }
}