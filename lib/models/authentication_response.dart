import 'package:get/route_manager.dart';
import 'package:stars_studios/models/authentication_data.dart';
import 'package:stars_studios/models/authentication_error.dart';
import 'package:stars_studios/models/snackbar_messenger.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/screens/home_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

class AuthenticationResponse {
  final bool success;
  final AuthenticationData? data;
  final AuthenticationError? error;
  AuthenticationResponse({
    required this.success,
    required this.data,
    required this.error,
  });

  void handle(SharedPrefsManager sharedPrefsManager,
      SnackBarMessenger messenger, User user) async {
    if (success) {
      _handleSuccess(sharedPrefsManager, user);
    } else {
      messenger.showSnackBar(error!.message);
    }
  }

  void _handleSuccess(SharedPrefsManager sharedPrefsManager, User user) async {
    await sharedPrefsManager.setUserId(data!.userId);
    await user.fromId(data!.userId, email: data!.email);
    Get.to(() => const HomeScreen());
  }
}
