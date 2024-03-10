import 'package:flutter/material.dart';
import 'package:stars_studios/components/notification/notification_preview.dart';
import 'package:stars_studios/controllers/notification_controller.dart';
import 'package:stars_studios/models/user.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: FutureBuilder(
        future:
            NotificationController().getNotificationsForUser(User.of(context)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NotificationPreview(notification: snapshot.data![index]);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
