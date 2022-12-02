import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/component/navigation_controls.dart';
import 'src/dialog/dialog.dart';
import 'src/component/web_view_stack.dart';
import 'src/component/menu.dart';
import 'src/component/bottom_appbar.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {

  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        outButtonsPressed(
            context, AlertType.info, '프로그램을 종료하시겠습니까?', '확인', '취소');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TEST'),
          actions: [
            NavigationControls(controller: controller),
            Menu(controller: controller),
          ],
        ),
        body: SafeArea(
          child: WebViewStack(controller: controller,),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BotAppBarNav(controller: controller),
      )
    );
  }
}



