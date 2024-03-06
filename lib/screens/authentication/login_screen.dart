import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars_studios/components/buttons/link_button.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/snackbar_messenger.dart';
import 'package:stars_studios/models/user.dart' as user_model;
import 'package:stars_studios/screens/authentication/forgot_password_screen.dart';
import 'package:stars_studios/screens/authentication/signup_screen.dart';
import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

//TODO: Refactor

class LoginScreen extends StatefulWidget {
  final FirebaseAuth? auth;
  final UserController? userController;
  final user_model.User? user;

  const LoginScreen({super.key, this.auth, this.userController, this.user});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final FirebaseAuthentication _firebaseAuthentication =
      widget.auth != null
          ? FirebaseAuthentication(
              instance: widget.auth, userController: widget.userController)
          : FirebaseAuthentication();

  void _onPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final SharedPrefsManager sharedPrefsManager =
          SharedPrefsManager.of(context);
      final SnackBarMessenger snackBarMessenger =
          SnackBarMessenger(ScaffoldMessenger.of(context));
      final currentUser = widget.user ?? context.read<user_model.User>();
      final AuthenticationResponse response =
          await _firebaseAuthentication.login(
        {"email": _emailController.text, "password": _passwordController.text},
      );
      response.handle(sharedPrefsManager, snackBarMessenger, currentUser);
    }
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
                      emailField: true,
                    ),
                    FormFieldWidget(
                      labelText: "Password",
                      controller: _passwordController,
                      isPasswordField: true,
                      required: true,
                    ),
                    LinkButton(
                      screen: () => const ForgotPasswordScreen(),
                      text: "Forgot password?",
                    ),
                    const SizedBox(height: 20),
                    LinkButton(
                      screen: () => const SignupScreen(),
                      text: "Don't have an  account? Register here.",
                    ),
                    ElevatedButton(
                      onPressed: () => _onPressed(context),
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
