import 'package:flutter/material.dart';

class ChangeEmailDialog extends StatelessWidget {
  final void Function() onPressed;

  const ChangeEmailDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Email Changed"),
      content:
          const Text("Are you sure you want to change your email address?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("OK"),
        ),
      ],
    );
  }
}
