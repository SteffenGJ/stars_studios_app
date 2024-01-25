import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DropdownIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget screen;

  const DropdownIconButton({
    super.key, required this.icon, required this.text, required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(text),
          ),
        ],
      ),
      onPressed: () {
        Get.to(() => screen);
      },
    );
  }
}