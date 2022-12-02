import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';

Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    ) {
  return Align(
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}


Future outButtonsPressed(BuildContext context, type, title, text1, text2) async {
  var result = await Alert(
    alertAnimation: fadeAlertAnimation,
    context: context,
    type: type,
    title: title,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context, true),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
        child: Text(
          text1,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      DialogButton(
        onPressed: () => Navigator.pop(context, false),
        color: const Color.fromRGBO(158, 29, 90, 1.0),
        child: Text(
          text2,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
    ],
  ).show();

  if (result == true) {
    SystemNavigator.pop();
  }
}