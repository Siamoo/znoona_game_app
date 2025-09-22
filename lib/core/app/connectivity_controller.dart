import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityController {
  ConnectivityController._();

  static final ConnectivityController instance = ConnectivityController._();

  ValueNotifier<bool> isConnected = ValueNotifier(true);

  Future<void> init() async {
    // Initial check (now returns a List<ConnectivityResult>)
    final results = await Connectivity().checkConnectivity();
    _updateFromList(results);

    // Listen to changes (also a List<ConnectivityResult>)
    Connectivity().onConnectivityChanged.listen(_updateFromList);
  }

  void _updateFromList(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet);

    isConnected.value = hasConnection;
  }
}
