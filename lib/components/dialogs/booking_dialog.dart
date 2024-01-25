import 'package:flutter/material.dart';
import 'package:stars_studios/enums/class_enum.dart';

class BookingDialog extends StatelessWidget {
  final Coach? finalCoach;
  final DateTime? selectedDate;
  final ClassTemporaryEnumWillBeReplacedWithProperClass? finalClass;

  const BookingDialog({
    super.key,
    required this.finalCoach,
    required this.selectedDate,
    required this.finalClass,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm booking"),
      content: Text(
          "You are about to book a class with $finalCoach on $selectedDate at $finalClass. Do you want to proceed?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Confirm"))
      ],
    );
  }
}
