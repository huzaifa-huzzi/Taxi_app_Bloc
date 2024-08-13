import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();

  factory ConnectivityService() {
    return _instance;
  }

  ConnectivityService._internal() {
    _connectivity.onConnectivityChanged.listen((result) {
      _connectivityController.add(result != ConnectivityResult.none);
    });
    _checkInitialConnectivity();
  }

  Stream<bool> get connectivityStream => _connectivityController.stream;

  Future<void> _checkInitialConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _connectivityController.add(result != ConnectivityResult.none);
  }

  // Public method to trigger a connectivity check
  void checkConnectivity() async {
    await _checkInitialConnectivity();
  }

  void dispose() {
    _connectivityController.close();
  }
}
