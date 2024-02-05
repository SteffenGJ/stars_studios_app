import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/screens/login_screen.dart';
import '../mocks/mock_setup_functions.dart';
import '../mocks/mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
  });
  group("LoginScreen", () {
    testWidgets("should show an error when invalid credentials are entered",
        (tester) async {
      final credentials = {
        "email": "invalid-email-address",
        "password": "password"
      };
      setUpMockResponseForLogInFailure(mockFirebaseAuth, credentials);

      await tester.pumpWidget(MaterialApp(
        home: LoginScreen(
          auth: mockFirebaseAuth,
        ),
      ));

      final emailTextField = find.byType(TextFormField).at(0);
      final passwordTextField = find.byType(TextFormField).at(1);
      final submitButton = find.byType(ElevatedButton);

      await tester.enterText(emailTextField, credentials["email"]!);
      await tester.enterText(passwordTextField, credentials["password"]!);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets("should guide user to home screen when log in is successful",
        (tester) async {
      final credentials = {
        "email": "email@address.com",
        "password": "password",
      };
      setUpMockResponseForLogInSuccess(mockFirebaseAuth, credentials);

      final SharedPreferences mockSharedPreferences = MockSharedPreferences();

      await tester.pumpWidget(Provider(
        create: (_) => mockSharedPreferences,
        child: GetMaterialApp(
          home: LoginScreen(
            auth: mockFirebaseAuth,
          ),
        ),
      ));

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
