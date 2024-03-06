import 'package:flutter/material.dart';
import 'package:stars_studios/components/buttons/link_button.dart';
import 'package:stars_studios/components/buttons/log_out_button.dart';
import 'package:stars_studios/components/profile/class_list.dart';
import 'package:stars_studios/enums/status.dart';
import 'package:stars_studios/models/class.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/screens/booking_screen.dart';
import 'package:stars_studios/screens/settings/edit_profile_screen.dart';

//TODO: Refactor the whole list of classes thing.

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<Class> listOfClasses = [
    Class(
        date: "12/01-2024",
        time: "12:13",
        coach: "Susanne",
        status: Status.completed),
    Class(
        date: "12/01-2024",
        time: "12:13",
        coach: "Susanne",
        status: Status.cancelled),
    Class(
        date: "12/01-2024",
        time: "12:13",
        coach: "Francesca",
        status: Status.completed),
    Class(
        date: "12/01-2024",
        time: "12:13",
        coach: "Francesca",
        status: Status.cancelled),
  ];

  @override
  Widget build(BuildContext context) {
    final User user = User.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                LinkButton(
                    screen: () => const EditProfileScreen(),
                    text: "Go to profile settings"),
                const SizedBox(height: 16),
                ExpansionTile(
                    title: const Text("Upcomming classes"),
                    children: [ClassList(list: listOfClasses)]),
                const SizedBox(height: 2),
                ExpansionTile(
                    title: const Text("Past classes"),
                    children: [ClassList(list: listOfClasses)]),
                LinkButton(
                    screen: () => const BookingScreen(), text: "Book a class"),
                const SizedBox(height: 16),
                const LogOutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
