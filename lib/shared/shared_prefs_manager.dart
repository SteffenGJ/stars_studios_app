import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///A class for interacting with shared preferences

class SharedPrefsManager extends ChangeNotifier {
  final SharedPreferences prefs;

  SharedPrefsManager({required this.prefs});

  Future<void> setUserId(String userId) async {
    await prefs.setString("userId", userId);
    notifyListeners();
  }

  String? getUserId() {
    return prefs.getString("userId");
  }

  Future<void> removeUserId() async {
    await prefs.remove("userId");
    notifyListeners();
  }

  bool isUserLoggedIn() {
    return getUserId() != null;
  }

  static SharedPrefsManager of(BuildContext context) {
    return context.read<SharedPrefsManager>();
  }
}
