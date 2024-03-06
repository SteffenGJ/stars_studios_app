import 'package:flutter/material.dart';
import 'package:stars_studios/components/buttons/log_out_button.dart';
import 'package:stars_studios/components/settings/settings_tile.dart';
import 'package:stars_studios/screens/settings/edit_profile_screen.dart';
import 'package:stars_studios/screens/settings/help_and_support.dart';
import 'package:stars_studios/screens/settings/payment_history.dart';
import 'package:stars_studios/screens/settings/privacy_policy.dart';
import 'package:stars_studios/screens/settings/privacy_settings.dart';
import 'package:stars_studios/screens/settings/terms_and_conditions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SettingsTile(
                icon: Icons.person,
                text: "Account",
                screen: () => const EditProfileScreen(),
              ),
              SettingsTile(
                  icon: Icons.security,
                  text: "Privacy settings",
                  screen: () => const PrivacySettings()),
              SettingsTile(
                  icon: Icons.payment,
                  text: "Payment history",
                  screen: () => const PaymentHistory()),
              SettingsTile(
                  icon: Icons.gavel,
                  text: "Terms and conditions",
                  screen: () => const TermsAndConditions()),
              SettingsTile(
                  icon: Icons.lock,
                  text: "Privacy policy",
                  screen: () => const PrivacyPolicy()),
              SettingsTile(
                  icon: Icons.help,
                  text: "Help & support",
                  screen: () => const HelpAndSupport()),
              const SizedBox(
                height: 20,
              ),
              const LogOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
