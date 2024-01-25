import 'package:flutter/material.dart';

class SwitchConsent extends StatefulWidget {
  final String text;
  final bool canToggle;

  const SwitchConsent({
    super.key, required this.text, required this.canToggle,
  });

  @override
  State<SwitchConsent> createState() => _SwitchConsentState();
}

class _SwitchConsentState extends State<SwitchConsent> {
  bool _agree = true;
  late final Color _color = widget.canToggle ? Colors.green : Colors.grey;

  void _handleChange(bool value) {
    //Make the greater state aware of this change
    if (!widget.canToggle) {
      null;
    } else {
    setState(() {
      _agree = value;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: Text(
          widget.text,
          maxLines: null,
        ),
        value: _agree,
        activeTrackColor: _color,
        onChanged: _handleChange,
      ),
    );
  }
}