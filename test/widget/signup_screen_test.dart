import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/screens/signup_screen.dart';
import '../mocks/mock_setup_functions.dart';
import '../mocks/mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
  });
  group("SignupScreen", () {
    testWidgets("should show an error when invalid email is entered",
        (tester) async {
      final credentials = {
        "email": "invalid-email-address",
        "password": "password",
      };
      setUpMockResponseForSignUpFailure(mockFirebaseAuth, credentials);

      await tester.pumpWidget(MaterialApp(
        home: SignupScreen(
          auth: mockFirebaseAuth,
        ),
      ));

      final emailTextField = find.byType(TextFormField).at(0);
      final passwordTextField = find.byType(TextFormField).at(1);
      final confirmPasswordTextField = find.byType(TextFormField).at(2);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);
      await tester.enterText(
          confirmPasswordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
    });

    testWidgets("should show an error when passwords do not match",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignupScreen()));

      final emailTextField = find.byType(TextFormField).at(0);
      final passwordTextField = find.byType(TextFormField).at(1);
      final confirmPasswordTextField = find.byType(TextFormField).at(2);
      final submitButton = find.byType(ElevatedButton);

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
        "email": "email@address.com",
        "password": "password",
      };
      setUpMockResponseForSignUpSuccess(mockFirebaseAuth, credentials);

      final SharedPreferences mockSharedPreferences = MockSharedPreferences();

      await tester.pumpWidget(Provider(
        create: (context) => mockSharedPreferences,
        child: GetMaterialApp(
          home: SignupScreen(
            auth: mockFirebaseAuth,
          ),
        ),
      ));

      final emailTextField = find.byType(TextFormField).at(0);
      final passwordTextField = find.byType(TextFormField).at(1);
      final confirmPasswordTextField = find.byType(TextFormField).at(2);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);
      await tester.enterText(
          confirmPasswordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text("Home Screen"), findsOneWidget);
    });
  });
}
