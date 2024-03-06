import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LinkButton extends StatelessWidget {
  final Widget Function() screen;
  final String text;

  const LinkButton({super.key, required this.screen, required this.text});

  void _onPressed() {
    Get.to(screen);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _onPressed, child: Text(text));
  }
}
