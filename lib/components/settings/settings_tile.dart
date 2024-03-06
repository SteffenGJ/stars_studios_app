import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget Function() screen;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.text,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 17,
      ),
      onTap: () {
        Get.to(screen);
      },
      leading: Icon(icon),
    );
  }
}
