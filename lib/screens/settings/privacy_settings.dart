import 'package:flutter/material.dart';
import 'package:stars_studios/components/settings/switch_consent.dart';

//TODO: Implement this screen

class PrivacySettings extends StatelessWidget {
  const PrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Settings"),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            SwitchConsent(
                canToggle: false,
                text:
                    "I allow something to gather some information according to Stars Studios privacy policy"),
            SwitchConsent(
                canToggle: true,
                text:
                    "I allow something to gather some information according to Stars Studios privacy policy"),
          ],
        ),
      ),
    );
  }
}
