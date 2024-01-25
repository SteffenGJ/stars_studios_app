import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  final String description;

  const ErrorDialog({super.key, required this.text, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
