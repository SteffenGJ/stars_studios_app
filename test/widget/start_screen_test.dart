import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:stars_studios/screens/start_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';
import '../mocks/mock_setup_functions.dart';

void main() {
  group("StartScreen", () {
    testWidgets(
        "should show home screen when user has successfully logged in before",
        (tester) async {
      final prefs = await setUpSharedPrefsWithMockValues({"userId": "1234"});

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => SharedPrefsManager(prefs: prefs),
          child: const MaterialApp(home: StartScreen()),
        ),
      );

      expect(find.text("Home Screen"), findsOneWidget);
    });

    testWidgets("should show login screen when user has not logged in before",
        (tester) async {
      final prefs = await setUpSharedPrefsWithMockValues();

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => SharedPrefsManager(prefs: prefs),
          child: const MaterialApp(home: StartScreen()),
        ),
      );

      expect(find.text("Password"), findsOneWidget);
    });
  });
}
