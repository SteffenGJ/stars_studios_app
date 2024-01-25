import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/screens/notification_screen.dart';

class NotificationPreview extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  const NotificationPreview({super.key, required this.title, required this.description, required this.imageUrl});

  @override
  State<NotificationPreview> createState() => _NotificationPreviewState();
}

class _NotificationPreviewState extends State<NotificationPreview> {
  bool _isRead = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: _isRead ? Colors.white : const Color.fromARGB(255, 215, 231, 239),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      title: Text(widget.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(widget.description, overflow: TextOverflow.ellipsis, maxLines: 1,),
      onTap: () {
        setState(() {
          _isRead = true;
        },);
        //Få den til at huske at den er blevet læst.
        Get.to(() => NotificationScreen(title: widget.title, description: widget.description, imageUrl: widget.imageUrl,));
      },
    );
  }
}