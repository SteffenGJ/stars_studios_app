import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:stars_studios/components/notification/notification_preview.dart';
import 'package:stars_studios/controllers/notification_controller.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/screens/notifications_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

import '../mocks/mocks.dart';

void main() {
  late Widget notificationsScreen;
  group("NotificationsScreen", () {
    setUp(() {
      final mockNotificationRepository = MockNotificationRepository();
      notificationsScreen = MultiProvider(
        providers: [
          ChangeNotifierProvider<SharedPrefsManager>(
              create: (_) =>
                  SharedPrefsManager(prefs: MockSharedPreferences())),
          ChangeNotifierProvider<User>(
            create: (_) => User(
                createdAt: DateTime(2024, 3, 5, 17, 30, 0),
                userController:
                    UserController(userRepository: MockUserRepository())),
          ),
        ],
        child: GetMaterialApp(
          home: NotificationsScreen(
              controller: NotificationController(
                  notificationRepository: mockNotificationRepository)),
        ),
      );
    });
    testWidgets(
        "should show a loading indicator when the future is not complete",
        (tester) async {
      await tester.pumpWidget(notificationsScreen);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        "should show a list of notifications when the future is complete",
        (tester) async {
      await tester.pumpWidget(notificationsScreen);

      await tester.pumpAndSettle();

      expect(find.byType(NotificationPreview), findsWidgets);
    });

    testWidgets("should only show notifications created after the user",
        (tester) async {
      await tester.pumpWidget(notificationsScreen);

      await tester.pumpAndSettle();

      expect(find.byType(NotificationPreview), findsNWidgets(2));
    });
  });
}
