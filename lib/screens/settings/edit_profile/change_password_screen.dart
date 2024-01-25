import 'package:flutter/material.dart';
import 'package:stars_studios/components/settings/password_form.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: const SizedBox(
        height: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: PasswordForm(),
        ),
      ),
    );
  }
}
