import 'package:flutter/material.dart';

//TODO: Implement AboutScreen

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Stars Studios"),
      ),
      body: const Center(
        child: Text("About Screen"),
      ),
    );
  }
}
