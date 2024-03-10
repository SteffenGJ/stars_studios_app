import 'package:flutter/material.dart';
import 'package:stars_studios/models/notification.dart' as notification_model;

class NotificationScreen extends StatelessWidget {
  // final String title;
  // final String? imageUrl;
  // final String description;
  // const NotificationScreen({
  //   super.key,
  //   required this.title,
  //   required this.imageUrl,
  //   required this.description,
  // });
  final notification_model.Notification notification;

  const NotificationScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final image = notification.imageUrl != null
        ? Image.network(
            notification.imageUrl!,
            fit: BoxFit.cover,
          )
        : Image.network(
            "https://wallpapercave.com/dwp2x/wp3255731.jpg",
            fit: BoxFit.cover,
          );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          notification.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      //"06.01.2024",
                      notification.createdAt.toString(),
                      style: const TextStyle(color: Colors.grey),
                    )),
                const SizedBox(
                  height: 20,
                ),
                //Image.network(imageUrl, fit: BoxFit.cover,),
                image,
                const SizedBox(
                  height: 20,
                ),
                Text(notification.text),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
