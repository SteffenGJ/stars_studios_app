import 'package:flutter/material.dart';
import 'package:stars_studios/components/settings/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Settings"),
      ),
      body: const SizedBox(
        height: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: EditProfileForm(),
        ),
      ),
    );
  }
}
