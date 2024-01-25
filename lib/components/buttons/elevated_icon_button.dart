import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;

  const ElevatedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
