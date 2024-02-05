import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///A class for interacting with shared preferences

class SharedPrefsManager {
  final SharedPreferences prefs;

  SharedPrefsManager({required this.prefs});

  Future<void> setUserId(String userId) async {
    await prefs.setString("userId", userId);
  }

  String? getUserId() {
    return prefs.getString("userId");
  }

  Future<void> removeUserId() async {
    await prefs.remove("userId");
  }

  bool isUserLoggedIn() {
    return getUserId() != null;
  }
}

///A helper to set up SharedPrefsManager
SharedPrefsManager setupSharedPrefsManager(BuildContext context) {
  final prefs = context.read<SharedPreferences>();
  return SharedPrefsManager(prefs: prefs);
}
