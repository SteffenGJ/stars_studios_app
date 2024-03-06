import 'package:flutter/material.dart';

//TODO: Find ud af hvordan man kan lave Snackbars og Dialogs med Get. Er det bedre? Undersøg muligheden i hvert fald.

class SnackBarMessenger {
  final ScaffoldMessengerState messenger;
  int duration;

  SnackBarMessenger(this.messenger, {this.duration = 5});

  void showSnackBar(String text) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: duration),
      ),
    );
  }
}
