import 'package:flutter/material.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Log out"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: const Text("Cancel")
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); 
          }, 
          child: const Text("Log out"),
        ),
      ],
    );
  }
}