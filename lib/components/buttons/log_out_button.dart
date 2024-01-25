import 'package:flutter/material.dart';
import 'package:stars_studios/components/dialogs/log_out_dialog.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(context: context, builder: (_) => const LogOutDialog());
      }, 
      style: ElevatedButton.styleFrom(
        surfaceTintColor: const Color.fromARGB(255, 176, 29, 18), 
        shadowColor: Colors.redAccent, 
        minimumSize: const Size(double.maxFinite, 39)
      ), 
      child: const Text("Log out", style: TextStyle(color: Colors.red),),
    );
  }
}