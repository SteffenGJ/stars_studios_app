import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/components/buttons/link_button.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/screens/home_screen.dart';
import 'package:stars_studios/screens/signup_screen.dart';
import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseAuth? auth;

  const LoginScreen({super.key, this.auth});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final FirebaseAuthentication _firebaseAuthentication =
      widget.auth != null
          ? FirebaseAuthentication(instance: widget.auth)
          : FirebaseAuthentication();

  //Note: This is the exact same functionality as in SignupScreen. Fix this!
  void _handleAuthResponse(AuthenticationResponse response) async {
    if (response.success) {
      final sharedPrefsManager = setupSharedPrefsManager(context);
      await sharedPrefsManager.setUserId(response.userId!);
      Get.to(() => const HomeScreen());
    } else {
      showSnackbar(response.error == null
          ? "An error occured"
          : response.error!["message"] ?? "An error occurred");
    }
  }

  //Temporary snackbar solution
  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _onPressed() async {
    final AuthenticationResponse response = await _firebaseAuthentication.login(
      {"email": _emailController.text, "password": _passwordController.text},
    );
    _handleAuthResponse(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: 400,
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormFieldWidget(
                      labelText: "E-mail",
                      controller: _emailController,
                    ),
                    FormFieldWidget(
                      labelText: "Password",
                      controller: _passwordController,
                      isPasswordField: true,
                    ),
                    const LinkButton(
                      screen: SignupScreen(),
                      text: "Don't have an  account? Register here.",
                    ),
                    ElevatedButton(
                      onPressed: _onPressed,
                      child: const Text("Login"),
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
