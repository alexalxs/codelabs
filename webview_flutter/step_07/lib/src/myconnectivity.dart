import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Myconnectivity extends ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Myconnectivity() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  bool _offline = false;

  bool get offline => _offline;

  Future<void> initConnectivity() async {
    try {
      _connectionStatus = await _connectivity.checkConnectivity();
      _updateConnectionStatus(_connectionStatus);
    } on Exception catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;

    if (_connectionStatus.toString() == 'ConnectivityResult.none') {
      _offline = true;
    }
    if (_connectionStatus.toString() != 'ConnectivityResult.none') {
      _offline = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
  }
}
