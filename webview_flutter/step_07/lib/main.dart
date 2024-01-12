// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/components.dart';
import 'src/myconnectivity.dart';
import 'src/navigation_controls.dart';
import 'src/web_view_stack.dart';

void main() {
  runApp(
    ChangeNotifierProvider<Myconnectivity>(
      create: (context) => Myconnectivity(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const WebViewApp(),
      ),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  bool isOffline = false; // Declare a variável em um escopo externo
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        actions: [
          NavigationControls(controller: controller),
        ],
      ),
      body: Consumer<Myconnectivity>(
        builder: (context, myconnectivity, child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${myconnectivity.offline}'),
                  if (!myconnectivity.offline)
                    Expanded(child: WebViewStack(controller: controller)),
                ],
              ),
              if (myconnectivity.offline)
                Column(
                  children: [
                    buildAlertIconWithText(),
                    const NoInternetWidget(),
                  ],
                ), // Sempre no topo
            ],
          );
        },
      ),
    );
  }
}

void onStatusChanged(String status) {}
