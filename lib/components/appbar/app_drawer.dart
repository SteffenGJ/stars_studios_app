import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/screens/about_screen.dart';
import 'package:stars_studios/screens/booking_screen.dart';
import 'package:stars_studios/screens/content_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text("Drawer Header"),
          ),
          ListTile(
            title: const Text("Learn"),
            onTap: () {
              Get.to(() => const ContentScreen());
            },
          ),
          ListTile(
            title: const Text("Book a class"),
            onTap: () {
              Get.to(() => const BookingScreen());
            },
          ),
          ListTile(
            title: const Text("Stars Studios"),
            onTap: () {
              Get.to(() => const AboutScreen());
            },
          ),
        ],
      )
    );
  }
}