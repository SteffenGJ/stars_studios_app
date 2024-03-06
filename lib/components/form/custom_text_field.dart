import 'package:flutter/material.dart';

/// A text field. It is used in the FormFieldWidget, but can also be used alone.

class CustomTextField extends StatelessWidget {
  final bool isPasswordField;
  final TextEditingController controller;
  final bool? enabled;
  final Function? onTap;
  final bool readOnly;
  final bool required;
  final bool emailField;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isPasswordField = false,
    this.enabled,
    this.onTap,
    this.readOnly = false,
    this.required = false,
    this.emailField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField ? true : false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap as void Function()?,
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return "Please enter a value";
        }
        if (emailField &&
            value != null &&
            !RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,4}$')
                .hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }
}
