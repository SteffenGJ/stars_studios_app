import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stars_studios/models/user.dart';

class NotificationRepository {
  final db = FirebaseFirestore.instance.collection("notifications");

  Future<List<Map<String, dynamic>>> fetchNotifications(User user) async {
    List<Map<String, dynamic>> notifications = [];

    await db
        .where("createdAt", isGreaterThan: Timestamp.fromDate(user.createdAt!))
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        notifications.add(docSnapshot.data());
      }
    });

    return notifications;
  }
}
