import 'package:stars_studios/models/notification.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/repositories/notification_repository.dart';

class NotificationController {
  final NotificationRepository _notificationRepository;

  NotificationController({NotificationRepository? notificationRepository})
      : _notificationRepository =
            notificationRepository ?? NotificationRepository();

  Future<List<Notification>> getNotificationsForUser(User user) async {
    final notifications =
        await _notificationRepository.fetchNotifications(user);
    List<Notification> newNotifications = [];
    for (var notification in notifications) {
      newNotifications.add(Notification.fromJson(notification));
    }
    // final newNotifications =
    //     notifications.map((e) => Notification.fromJson(e)).toList();
    print(newNotifications);
    return newNotifications;
  }
}
