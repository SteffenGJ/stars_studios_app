import 'package:flutter/material.dart';
import 'package:stars_studios/components/notification/notification_preview.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => const NotificationPreview(
          title: "Very incredibly long Notification Title", 
          imageUrl: "https://wallpapercave.com/dwp2x/wp3255731.jpg", 
          description: "Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest. Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest. Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest \n \n Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest. Notification Subtitle. Today we are announcing some bery big news. \n We have been offered to start a forest. Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest. Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest. Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest \n \n Notification Subtitle. Today we are announcing some bery big news. We have been offered to start a forest. ",
        ),
        itemCount: 10,
    ),
    );
  }
}