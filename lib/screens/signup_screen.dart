import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/components/buttons/link_button.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/errors/errors.dart';
import 'package:stars_studios/screens/home_screen.dart';
import 'package:stars_studios/screens/login_screen.dart';
import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

class SignupScreen extends StatefulWidget {
  final FirebaseAuth? auth;

  const SignupScreen({super.key, this.auth});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late final FirebaseAuthentication _firebaseAuthentication =
      widget.auth != null
          ? FirebaseAuthentication(instance: widget.auth)
          : FirebaseAuthentication();

  void _doPasswordsMatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      throw PasswordsDoNotMatchException("Passwords do not match");
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

  //Note: This is the exact same functionality as in LoginScreen. Fix this!
  void handleResponse(AuthenticationResponse response) async {
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

  void _onPressed() async {
    try {
      _doPasswordsMatch(
          _passwordController.text, _confirmPasswordController.text);
    } on PasswordsDoNotMatchException catch (e) {
      showSnackbar(e.message);
      return;
    }
    final AuthenticationResponse response = await _firebaseAuthentication
        .createUser({
      "email": _emailController.text,
      "password": _passwordController.text
    });
    handleResponse(response);
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
                    FormFieldWidget(
                      labelText: "Confirm Password",
                      controller: _confirmPasswordController,
                      isPasswordField: true,
                    ),
                    const LinkButton(
                      screen: LoginScreen(),
                      text: "Already an account? Log in here.",
                    ),
                    ElevatedButton(
                      onPressed: _onPressed,
                      child: const Text("Sign up"),
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
