import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars_studios/components/buttons/link_button.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/snackbar_messenger.dart';
import 'package:stars_studios/models/user.dart' as user_model;
import 'package:stars_studios/screens/authentication/login_screen.dart';
import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

//TODO: Refactor

class SignupScreen extends StatefulWidget {
  final FirebaseAuth? auth;
  final UserController? userController;
  final user_model.User? user;

  const SignupScreen({super.key, this.auth, this.user, this.userController});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  late final FirebaseAuthentication _firebaseAuthentication =
      widget.auth != null
          ? FirebaseAuthentication(
              instance: widget.auth, userController: widget.userController)
          : FirebaseAuthentication();

  //TODO: EXTRACT
  bool _doPasswordsMatch(String password, String confirmPassword,
      SnackBarMessenger snackBarMessenger) {
    if (password != confirmPassword) {
      snackBarMessenger.showSnackBar("Passwords do not match");
      return false;
    } else {
      return true;
    }
  }

  void _onPressed() async {
    if (_formKey.currentState!.validate()) {
      final SharedPrefsManager sharedPrefsManager =
          SharedPrefsManager.of(context);
      final SnackBarMessenger snackBarMessenger =
          SnackBarMessenger(ScaffoldMessenger.of(context));
      final currentUser = widget.user ?? context.read<user_model.User>();

      if (!_doPasswordsMatch(_passwordController.text,
          _confirmPasswordController.text, snackBarMessenger)) {
        return;
      }

      final AuthenticationResponse response =
          await _firebaseAuthentication.createUser({
        "email": _emailController.text,
        "password": _passwordController.text,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
      });

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
              height: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FormFieldWidget(
                            controller: _firstNameController,
                            labelText: "First Name",
                            required: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: FormFieldWidget(
                            controller: _lastNameController,
                            labelText: "Last Name",
                            required: true,
                          ),
                        ),
                      ],
                    ),
                    FormFieldWidget(
                      labelText: "E-mail",
                      controller: _emailController,
                      emailField: true,
                    ),
                    FormFieldWidget(
                      labelText: "Password",
                      controller: _passwordController,
                      required: true,
                      isPasswordField: true,
                    ),
                    FormFieldWidget(
                      labelText: "Confirm Password",
                      controller: _confirmPasswordController,
                      required: true,
                      isPasswordField: true,
                    ),
                    LinkButton(
                      screen: () => const LoginScreen(),
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
