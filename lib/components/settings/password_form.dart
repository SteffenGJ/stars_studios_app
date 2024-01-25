import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/components/buttons/elevated_icon_button.dart';
import 'package:stars_studios/components/dialogs/error_dialog.dart';
import 'package:stars_studios/components/form/form_field_widget.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final TextEditingController _enterOldPasswordController =
      TextEditingController();
  final TextEditingController _enterNewPasswordController =
      TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  String _currentPassword = "*********";

  void _onPressed() {
    if (_enterOldPasswordController.text == _currentPassword) {
      if (_enterNewPasswordController.text ==
          _confirmNewPasswordController.text) {
        _currentPassword = _enterNewPasswordController.text;
        _saveChanges();
      } else {
        showDialog(
          context: context,
          builder: (_) => const ErrorDialog(
            text: "Password Mismatch",
            description:
                "Please make sure the password matches the password confirmation field",
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => const ErrorDialog(
          text: "Incorrect Password",
          description: "The old password you entered is incorrect.",
        ),
      );
    }
  }

  void _saveChanges() {
    Get.back();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password changed."),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldWidget(
          labelText: "Old Password",
          controller: _enterOldPasswordController,
          isPasswordField: true,
        ),
        FormFieldWidget(
          labelText: "New Password",
          controller: _enterNewPasswordController,
          isPasswordField: true,
        ),
        FormFieldWidget(
          labelText: "Confirm New Password",
          controller: _confirmNewPasswordController,
          isPasswordField: true,
        ),
        ElevatedIconButton(
          onPressed: _onPressed,
          icon: Icons.done,
          text: "Save",
        ),
      ],
    );
  }
}
