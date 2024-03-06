import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/models/snackbar_messenger.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';

//TODO: Refactor

class ForgotPasswordScreen extends StatefulWidget {
  final FirebaseAuth? auth;

  const ForgotPasswordScreen({super.key, this.auth});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  late final FirebaseAuthentication _firebaseAuthentication =
      widget.auth != null
          ? FirebaseAuthentication(instance: widget.auth)
          : FirebaseAuthentication();

  void _onPressed() async {
    if (_formKey.currentState!.validate()) {
      final SnackBarMessenger snackBarMessenger =
          SnackBarMessenger(ScaffoldMessenger.of(context));
      final AuthenticationResponse response =
          await _firebaseAuthentication.resetPassword(_emailController.text);
      if (response.success) {
        snackBarMessenger.showSnackBar("Password reset email sent");
        Get.back();
      } else {
        snackBarMessenger.showSnackBar("Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: 200,
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormFieldWidget(
                      controller: _emailController,
                      labelText: "Enter your email",
                      emailField: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _onPressed,
                      child: const Text("Send verification email"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
