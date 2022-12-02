import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview/src/component/menu.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BotAppBarNav extends StatelessWidget {
  const BotAppBarNav({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller2 = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller2 == null) {
          return BottomAppBar(
            color: Colors.deepPurple,
            shape: const CircularNotchedRectangle(),
            child: IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: Row(
                children: const <Widget>[
                  Icon(Icons.arrow_back_ios),
                  Icon(Icons.arrow_forward_ios),
                  Icon(Icons.replay),
                ],
              ),
            ),
          );
        }

        return BottomAppBar(
          color: Colors.deepPurple,
          shape: const CircularNotchedRectangle(),
          child: IconTheme(
            data: const IconThemeData(color: Colors.white),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 10,),
                Menu(controller: controller),
                IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: () {
                    controller2.reload();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () async {
                    if (await controller2.canGoBack()) {
                      await controller2.goBack();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No back history item')),
                      );
                      return;
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    if (await controller2.canGoForward()) {
                      await controller2.goForward();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No forward history item')),
                      );
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
