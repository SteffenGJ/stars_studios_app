import 'package:flutter/material.dart';
import 'package:stars_studios/components/form/custom_text_field.dart';

/// A field with label and text field.

class FormFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool enabled;
  final Function? onTap;
  final bool readOnly;

  const FormFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPasswordField = false,
    this.enabled = true,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          child: CustomTextField(
            controller: controller,
            isPasswordField: isPasswordField,
            enabled: enabled,
            onTap: onTap,
            readOnly: readOnly,
          ),
        ),
      ],
    );
  }
}
