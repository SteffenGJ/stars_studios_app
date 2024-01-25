import 'package:flutter/material.dart';
import 'package:stars_studios/components/buttons/dropdown_icon_button.dart';
import 'package:stars_studios/screens/notifications_screen.dart';
import 'package:stars_studios/screens/profile_screen.dart';
import 'package:stars_studios/screens/settings_screen.dart';

class MenuDropdown extends StatelessWidget {
  const MenuDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: [
          DropdownIconButton(icon: Icons.person, text: "Profile", screen: ProfileScreen(),),
          const DropdownIconButton(icon: Icons.settings, text: "Settings", screen: SettingsScreen(),),
          const DropdownIconButton(icon: Icons.notifications, text: "Notifications", screen: NotificationsScreen(),),
        ],
      child: const Icon(Icons.more_vert, size: 30,),);
  }
}