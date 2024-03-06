import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/repositories/user_repository.dart';
import 'package:stars_studios/screens/authentication/signup_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';
import '../mocks/mock_setup_functions.dart';
import '../mocks/mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late SharedPreferences mockSharedPreferences;
  late UserRepository mockUserRepository;
  late User mockUser;
  late Widget signUpScreen;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockSharedPreferences = MockSharedPreferences();
    mockUserRepository = MockUserRepository();
    mockUser = MockUserModel();
    signUpScreen = MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedPrefsManager>(
            create: (_) => SharedPrefsManager(prefs: mockSharedPreferences)),
        ChangeNotifierProvider<User>(
          create: (_) => User(),
        ),
      ],
      child: GetMaterialApp(
        home: SignupScreen(
          auth: mockFirebaseAuth,
          userController: UserController(userRepository: mockUserRepository),
          user: mockUser,
        ),
      ),
    );
  });
  group("SignupScreen", () {
    testWidgets("should show an error when invalid email is entered",
        (tester) async {
      final credentials = {
        "firstName": "First",
        "lastName": "Last",
        "email": "invalid-email-address",
        "password": "password",
      };

      await tester.pumpWidget(signUpScreen);

      final firstNameTextField = find.byType(TextFormField).at(0);
      final lastNameTextField = find.byType(TextFormField).at(1);
      final emailTextField = find.byType(TextFormField).at(2);
      final passwordTextField = find.byType(TextFormField).at(3);
      final confirmPasswordTextField = find.byType(TextFormField).at(4);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(firstNameTextField, credentials["firstName"]!);
      await tester.enterText(lastNameTextField, credentials["lastName"]!);
      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);
      await tester.enterText(
          confirmPasswordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsNothing);
    });

    testWidgets("should show an error when passwords do not match",
        (tester) async {
      await tester.pumpWidget(signUpScreen);

      final firstNameTextField = find.byType(TextFormField).at(0);
      final lastNameTextField = find.byType(TextFormField).at(1);
      final emailTextField = find.byType(TextFormField).at(2);
      final passwordTextField = find.byType(TextFormField).at(3);
      final confirmPasswordTextField = find.byType(TextFormField).at(4);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(firstNameTextField, "First");
      await tester.enterText(lastNameTextField, "Last");
      await tester.enterText(emailTextField, "email@address.com");
      await tester.enterText(passwordTextField, "password");
      await tester.enterText(confirmPasswordTextField, "wrong-password");

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
    });

    testWidgets("should guide user to home screen when sign up is successful",
        (tester) async {
      final credentials = {
        "firstName": "First",
        "lastName": "Last",
        "email": "email@address.com",
        "password": "password",
      };
      setUpMockResponseForSignUpSuccess(mockFirebaseAuth, credentials);

      await tester.pumpWidget(signUpScreen);

      final firstNameTextField = find.byType(TextFormField).at(0);
      final lastNameTextField = find.byType(TextFormField).at(1);
      final emailTextField = find.byType(TextFormField).at(2);
      final passwordTextField = find.byType(TextFormField).at(3);
      final confirmPasswordTextField = find.byType(TextFormField).at(4);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(firstNameTextField, credentials["firstName"]!);
      await tester.enterText(lastNameTextField, credentials["lastName"]!);
      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);
      await tester.enterText(
          confirmPasswordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsOneWidget);
    });

    testWidgets("should not be successfull if fields are missing",
        (tester) async {
      final credentials = {
        "email": "email@address.com",
        "password": "password",
      };

      await tester.pumpWidget(signUpScreen);

      final emailTextField = find.byType(TextFormField).at(2);
      final passwordTextField = find.byType(TextFormField).at(3);
      final confirmPasswordTextField = find.byType(TextFormField).at(4);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);
      await tester.enterText(
          confirmPasswordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsNothing);
    });
  });
}
