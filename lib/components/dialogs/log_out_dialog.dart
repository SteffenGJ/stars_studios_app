import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/screens/authentication/login_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    super.key,
  });

  void _logOut(context) async {
    final sharedPrefsManager = SharedPrefsManager.of(context);
    await sharedPrefsManager.removeUserId();
    Get.offAll(() => const LoginScreen());
  }

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
            child: const Text("Cancel")),
        TextButton(
          onPressed: () => _logOut(context),
          child: const Text("Log out"),
        ),
      ],
    );
  }
}
