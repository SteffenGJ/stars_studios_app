import 'package:flutter/material.dart';

/// A text field. It is used in the FormFieldWidget, but can also be used alone.

class CustomTextField extends StatelessWidget {
  final bool isPasswordField;
  final TextEditingController controller;
  final bool? enabled;
  final Function? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isPasswordField = false,
    this.enabled,
    this.onTap,
    this.readOnly = false,
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
    );
  }
}
