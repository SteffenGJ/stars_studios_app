import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/models/notification.dart' as notification_model;
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/screens/notification_screen.dart';

class NotificationPreview extends StatelessWidget {
  // final String title;
  // final String description;
  // final String imageUrl;

  // const NotificationPreview({super.key, required this.title, required this.description, required this.imageUrl});
  final notification_model.Notification notification;

  const NotificationPreview({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final User user = User.of(context);
    //print(user.toJson());
    return ListTile(
      tileColor: user.hasRead(notification.id)
          ? Colors.white
          : const Color.fromARGB(255, 215, 231, 239),
      leading: CircleAvatar(
        backgroundImage: notification.imageUrl != null
            ? NetworkImage(notification.imageUrl!)
            : null,
      ),
      title: Text(
        notification.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        notification.text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () async {
        //Få den til at huske at den er blevet læst.
        if (!user.hasRead(notification.id)) {
          await user.readNotification(notification.id);
        }
        Get.to(() => NotificationScreen(
              // title: notification.title,
              // description: notification.text,
              // imageUrl: notification.imageUrl,
              notification: notification,
            ));
      },
    );
  }
}
