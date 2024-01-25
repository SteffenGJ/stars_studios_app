import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
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
      home: const HomeScreen(),
    );
  }
}