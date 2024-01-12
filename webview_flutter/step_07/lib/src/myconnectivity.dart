import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyConnectivity extends StatefulWidget {
  final void Function(String status) onStatusChanged;

  const MyConnectivity({super.key, required this.onStatusChanged});
  // final WebViewController webViewController;

  @override
  _MyConnectivityState createState() => _MyConnectivityState();
}

class _MyConnectivityState extends State<MyConnectivity> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    widget.onStatusChanged(_connectionStatus.toString());
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_connectionStatus.toString() == 'ConnectivityResult.none') {
      return buildAlertIconWithText();
    }
    return Container();
  }
}

Widget buildAlertIconWithText() {
  return Container(
    color: Colors.red, // Cor de fundo vermelho
    padding: const EdgeInsets.all(8), // Espaçamento interno do Container
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline, // Ícone de erro
          color: Colors.white, // Cor do ícone (branco)
          size: 24,
        ),
        SizedBox(width: 8),
        Text(
          'No Internet', // Texto personalizado
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
