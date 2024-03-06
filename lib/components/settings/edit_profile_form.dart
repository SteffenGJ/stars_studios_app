import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/components/buttons/elevated_icon_button.dart';
import 'package:stars_studios/components/buttons/link_button.dart';
import 'package:stars_studios/components/dialogs/change_email_dialog.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/models/snackbar_messenger.dart';
import 'package:stars_studios/models/user.dart' as user_model;
import 'package:stars_studios/screens/authentication/forgot_password_screen.dart';
import 'package:stars_studios/screens/authentication/login_screen.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

class EditProfileForm extends StatefulWidget {
  final FirebaseAuth? auth;
  const EditProfileForm({super.key, this.auth});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final user = user_model.User.of(context);
  late final FirebaseAuthentication _firebaseAuthentication =
      widget.auth != null
          ? FirebaseAuthentication(instance: widget.auth)
          : FirebaseAuthentication();
  late final TextEditingController _emailController =
      TextEditingController(text: user.email);
  late final TextEditingController _firstNameController =
      TextEditingController(text: user.firstName);
  late final TextEditingController _lastNameController =
      TextEditingController(text: user.lastName);
  bool _isEditingProfile = false;

//TODO: Refactor onPressed appropriately
  void onPressed() async {
    final snackbarMessenger =
        SnackBarMessenger(ScaffoldMessenger.of(context), duration: 10);
    final sharedPrefsManager = SharedPrefsManager.of(context);
    if (_isEditingProfile) {
      if (_emailController.text != user.email) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ChangeEmailDialog(
              onPressed: () async {
                final AuthenticationResponse response =
                    await _firebaseAuthentication
                        .changeEmail(_emailController.text);
                if (response.success) {
                  snackbarMessenger.showSnackBar(
                      "An email has been sent to the provided email address. Your email will be changed once you have confirmed in the email.");
                  await sharedPrefsManager.removeUserId();
                  Get.offAll(() => const LoginScreen());
                } else {
                  snackbarMessenger.showSnackBar(response.error!.message);
                }
              },
            );
          },
        );
      } else {
        await user.editProfile({
          "userId": user.userId,
          "email": _emailController.text,
          "firstName": _firstNameController.text,
          "lastName": _lastNameController.text,
        });
      }
      setState(() {
        _isEditingProfile = !_isEditingProfile;
      });
    } else {
      setState(() {
        _isEditingProfile = !_isEditingProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${user.firstName} ${user.lastName}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: FormFieldWidget(
                controller: _firstNameController,
                labelText: "First Name",
                enabled: _isEditingProfile,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: FormFieldWidget(
                controller: _lastNameController,
                labelText: "Last Name",
                enabled: _isEditingProfile,
              ),
            ),
          ],
        ),
        FormFieldWidget(
          labelText: "Email",
          controller: _emailController,
          enabled: _isEditingProfile,
        ),
        LinkButton(
            screen: () => const ForgotPasswordScreen(), text: "Reset password"),
        ElevatedIconButton(
          onPressed: onPressed,
          icon: _isEditingProfile ? Icons.done : Icons.edit,
          text: _isEditingProfile ? "Save" : "Edit profile",
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
