import 'package:flutter/material.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Payment History"),
      ),
      body: const Center(
        child: Text("Payment History"),
      ),
    );
  }
}