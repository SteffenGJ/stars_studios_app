import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/repositories/user_repository.dart';
import 'package:stars_studios/screens/authentication/login_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';
import '../mocks/mock_setup_functions.dart';
import '../mocks/mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late Widget loginScreen;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    final SharedPreferences mockSharedPreferences = MockSharedPreferences();
    final UserRepository mockUserRepository = MockUserRepository();
    final User mockUser = MockUserModel();
    loginScreen = MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedPrefsManager>(
            create: (_) => SharedPrefsManager(prefs: mockSharedPreferences)),
        ChangeNotifierProvider<User>(
          create: (_) => mockUser,
        ),
      ],
      child: GetMaterialApp(
        home: LoginScreen(
            auth: mockFirebaseAuth,
            userController: UserController(userRepository: mockUserRepository),
            user: mockUser),
      ),
    );
  });
  group("LoginScreen", () {
    testWidgets("should show an error when invalid credentials are entered",
        (tester) async {
      final credentials = {
        "email": "invalid-email-address",
        "password": "password"
      };
      setUpMockResponseForLogInFailure(mockFirebaseAuth, credentials);

      await tester.pumpWidget(loginScreen);

      final emailTextField = find.byType(TextFormField).at(0);
      final passwordTextField = find.byType(TextFormField).at(1);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsNothing);
    });

    testWidgets("should guide user to home screen when log in is successful",
        (tester) async {
      final credentials = {
        "email": "email@address.com",
        "password": "password",
      };
      setUpMockResponseForLogInSuccess(mockFirebaseAuth, credentials);

      await tester.pumpWidget(loginScreen);

      final emailTextField = find.byType(TextFormField).at(0);
      final passwordTextField = find.byType(TextFormField).at(1);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsOneWidget);
    });
  });
}
