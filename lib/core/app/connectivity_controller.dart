import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ConnectivityController {
  ConnectivityController._();
  static final ConnectivityController instance = ConnectivityController._();

  final Logger _logger = Logger();
  final Connectivity _connectivity = Connectivity();
  
  // Value notifier for connection state
  final ValueNotifier<bool> isConnected = ValueNotifier(true);
  
  // Stream subscription
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  
  // Connection quality (if needed)
  final ValueNotifier<ConnectionQuality> connectionQuality = 
      ValueNotifier(ConnectionQuality.unknown);
  
  // Retry configuration
  static const int _maxRetries = 3;
  static const Duration _initialRetryDelay = Duration(seconds: 1);
  
  // Track if initialized
  bool _isInitialized = false;
  
  // Connection history for quality assessment
  final List<DateTime> _connectionChanges = [];
  static const int _maxHistoryLength = 10;

  Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      // Initial check
      await _checkConnectivity();
      
      // Listen to changes
      _subscription = _connectivity.onConnectivityChanged.listen(
        _handleConnectivityChange,
        onError: _handleError,
      );
      
      _isInitialized = true;
      _logger.i('✅ ConnectivityController initialized');
    } catch (e) {
      _logger.e('❌ Failed to initialize ConnectivityController', error: e);
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateConnectionState(results);
    } catch (e) {
      _logger.e('Failed to check connectivity', error: e);
      isConnected.value = false;
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    _updateConnectionState(results);
    _recordConnectionChange();
  }

  void _updateConnectionState(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) => 
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet);
    
    final previousState = isConnected.value;
    isConnected.value = hasConnection;
    
    // Update connection quality
    _updateConnectionQuality(results);
    
    // Log state change
    if (previousState != hasConnection) {
      _logger.i('📶 Connection state changed: ${hasConnection ? 'ONLINE' : 'OFFLINE'}');
    }
  }

  void _updateConnectionQuality(List<ConnectivityResult> results) {
    if (results.isEmpty || !isConnected.value) {
      connectionQuality.value = ConnectionQuality.none;
    } else if (results.contains(ConnectivityResult.wifi) ||
               results.contains(ConnectivityResult.ethernet)) {
      connectionQuality.value = ConnectionQuality.good;
    } else if (results.contains(ConnectivityResult.mobile)) {
      // Mobile connection - could be 3G/4G/5G
      connectionQuality.value = ConnectionQuality.fair;
    } else if (results.contains(ConnectivityResult.vpn)) {
      connectionQuality.value = ConnectionQuality.good;
    } else {
      connectionQuality.value = ConnectionQuality.poor;
    }
  }

  void _recordConnectionChange() {
    _connectionChanges.add(DateTime.now());
    if (_connectionChanges.length > _maxHistoryLength) {
      _connectionChanges.removeAt(0);
    }
  }

  void _handleError(Object error) {
    _logger.e('Connectivity error', error: error);
    isConnected.value = false;
    connectionQuality.value = ConnectionQuality.unknown;
  }

  /// Check if connection is stable (no frequent changes)
  bool get isConnectionStable {
    if (_connectionChanges.length < 3) return true;
    
    // Check if there were more than 3 changes in the last minute
    final oneMinuteAgo = DateTime.now().subtract(const Duration(minutes: 1));
    final recentChanges = _connectionChanges.where(
      (time) => time.isAfter(oneMinuteAgo)
    ).length;
    
    return recentChanges <= 3;
  }

  /// Retry connection check with exponential backoff
  Future<bool> retryConnection() async {
    var attempts = 0;
    var delay = _initialRetryDelay;
    
    while (attempts < _maxRetries) {
      attempts++;
      
      try {
        await _checkConnectivity();
        if (isConnected.value) {
          _logger.i('✅ Connection restored after $attempts attempts');
          return true;
        }
      } catch (e) {
        _logger.w('Connection check attempt $attempts failed');
      }
      
      if (attempts < _maxRetries) {
        await Future<dynamic>.delayed(delay);
        delay *= 2; // Exponential backoff
      }
    }
    
    _logger.w('❌ Failed to restore connection after $_maxRetries attempts');
    return false;
  }

  /// Force a connection check
  Future<void> refreshConnection() => _checkConnectivity();

  /// Get connection type as string
  Future<String> getConnectionType() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.wifi)) return 'WiFi';
      if (results.contains(ConnectivityResult.mobile)) return 'Mobile';
      if (results.contains(ConnectivityResult.ethernet)) return 'Ethernet';
      if (results.contains(ConnectivityResult.vpn)) return 'VPN';
      if (results.contains(ConnectivityResult.bluetooth)) return 'Bluetooth';
      if (results.contains(ConnectivityResult.other)) return 'Other';
      return 'None';
    } catch (e) {
      return 'Unknown';
    }
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
    isConnected.dispose();
    connectionQuality.dispose();
    _logger.i('✅ ConnectivityController disposed');
  }
}

/// Connection quality enum
enum ConnectionQuality {
  none,
  poor,
  fair,
  good,
  excellent,
  unknown
}

/// Extension for connection quality utilities
extension ConnectionQualityExtension on ConnectionQuality {
  bool get isUsable => this != ConnectionQuality.none && this != ConnectionQuality.unknown;
  bool get isGood => this == ConnectionQuality.good || this == ConnectionQuality.excellent;
  bool get isPoor => this == ConnectionQuality.poor;
  
  Color get color {
    switch (this) {
      case ConnectionQuality.none:
        return Colors.grey;
      case ConnectionQuality.poor:
        return Colors.red;
      case ConnectionQuality.fair:
        return Colors.orange;
      case ConnectionQuality.good:
        return Colors.lightGreen;
      case ConnectionQuality.excellent:
        return Colors.green;
      case ConnectionQuality.unknown:
        return Colors.grey;
    }
  }
  
  IconData get icon {
    switch (this) {
      case ConnectionQuality.none:
        return Icons.signal_wifi_off;
      case ConnectionQuality.poor:
        return Icons.signal_wifi_statusbar_connected_no_internet_4;
      case ConnectionQuality.fair:
        return Icons.network_wifi_2_bar;
      case ConnectionQuality.good:
        return Icons.network_wifi_3_bar;
      case ConnectionQuality.excellent:
        return Icons.network_wifi;
      case ConnectionQuality.unknown:
        return Icons.wifi_find;
    }
  }
}