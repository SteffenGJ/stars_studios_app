import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/firebase_options.dart';
import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/screens/start_screen.dart';
import 'package:stars_studios/shared/shared_prefs_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPrefsManager sharedPrefsManager = SharedPrefsManager(prefs: prefs);
  User user = User();

  if (prefs.containsKey("userId")) {
    await user.fromId(prefs.getString("userId")!);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedPrefsManager>(
            create: (_) => sharedPrefsManager),
        ChangeNotifierProvider<User>(
          create: (_) => user,
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 244, 243, 243),
        ),
      ),
      home: const StartScreen(),
    );
  }
}
