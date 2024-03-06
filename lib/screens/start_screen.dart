import 'package:flutter/material.dart';
import 'package:stars_studios/screens/home_screen.dart';
import 'package:stars_studios/screens/authentication/login_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  Widget _hasUserLoggedIn(bool loggedIn) {
    if (loggedIn) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }

  Widget _determineReturnWidget(context) {
    final sharedPrefsManager = SharedPrefsManager.of(context);
    return _hasUserLoggedIn(sharedPrefsManager.isUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return _determineReturnWidget(context);
  }
}
