import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/components/buttons/elevated_icon_button.dart';
import 'package:stars_studios/components/dialogs/change_email_dialog.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';
import 'package:stars_studios/screens/settings/edit_profile/change_password_screen.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _emailController =
      TextEditingController(text: "user@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "*********");
  final TextEditingController _firstNameController =
      TextEditingController(text: "John");
  final TextEditingController _lastNameController =
      TextEditingController(text: "Doe");
  bool _isEditingProfile = false;
  //Temporary  variable
  final String _originalEmail = "user@gmail.com";

  void onPressed() {
    if (_emailController.text != _originalEmail) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeEmailDialog(
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
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
          "${_firstNameController.text} ${_lastNameController.text}",
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
        FormFieldWidget(
          labelText: "Password",
          controller: _passwordController,
          enabled: _isEditingProfile,
          isPasswordField: true,
          onTap: () {
            Get.to(() => const ChangePasswordScreen());
          },
          readOnly: true,
        ),
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
