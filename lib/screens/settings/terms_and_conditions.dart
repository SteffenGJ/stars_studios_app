import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and conditions"),
      ),
      body: const Center(
        child: Text("Terms and conditions"),
      ),
    );
  }
}