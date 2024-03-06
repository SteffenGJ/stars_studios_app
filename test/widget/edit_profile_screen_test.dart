import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/components/buttons/elevated_icon_button.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/screens/settings/edit_profile_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

import '../mocks/mocks.dart';

void main() {
  late User user;
  late MockUserRepository mockUserRepository;
  late SharedPreferences mockSharedPreferences;
  late Widget editProfileScreen;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockUserRepository = MockUserRepository();
    user = User(
      userId: "1234",
      email: "email",
      firstName: "First",
      lastName: "Last",
      userController: UserController(userRepository: mockUserRepository),
    );
    editProfileScreen = MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (_) => user,
        ),
        ChangeNotifierProvider<SharedPrefsManager>(
          create: (_) => SharedPrefsManager(prefs: mockSharedPreferences),
        ),
      ],
      child: const GetMaterialApp(home: EditProfileScreen()),
    );
  });
  group("EditProfileScreen", () {
    testWidgets("should change user information when saved", (tester) async {
      await tester.pumpWidget(editProfileScreen);

      final editButton = find.byType(ElevatedIconButton);
      await tester.tap(editButton);
      await tester.pump();

      final firstNameTextField = find.byType(TextFormField).at(0);

      await tester.enterText(firstNameTextField, "NewName");
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      final fullNameText = find.textContaining("NewName");
      expect(fullNameText, findsNWidgets(2));
    });

    testWidgets("should alert user if email is being changed", (tester) async {
      await tester.pumpWidget(editProfileScreen);

      final editButton = find.byType(ElevatedIconButton);
      await tester.tap(editButton);
      await tester.pump();

      final emailTextField = find.byType(TextFormField).at(2);

      await tester.enterText(emailTextField, "New@email");
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      final dialog = find.byType(AlertDialog);
      expect(dialog, findsOneWidget);
    });

    testWidgets(
        "should guide user to reset password screen if changing passwords",
        (tester) async {
      await tester.pumpWidget(editProfileScreen);

      final resetPasswordButton = find.byType(TextButton);
      await tester.tap(resetPasswordButton);
      await tester.pumpAndSettle();

      expect(find.text("Reset Password"), findsOneWidget);
    });
  });
}
