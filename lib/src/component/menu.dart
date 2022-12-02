import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,                                          // Add this line
}

class Menu extends StatelessWidget {
  const Menu({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, controller) {
        return PopupMenuButton<_MenuOptions>(
          onSelected: (value) async {
            switch (value) {
              case _MenuOptions.navigationDelegate:
                controller.data!.loadUrl('https://youtube.com');
                break;
              case _MenuOptions.userAgent:
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(await controller.data!.runJavascriptReturningResult('navigator.userAgent')),)
                );
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.navigationDelegate,
              child: Text('Navigate to YouTube'),
            ),
            // Add from here ...
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.userAgent,
              child: Text('Show user-agent'),
            ),
          ],
        );
      },
    );
  }
}