import 'package:flutter/material.dart';
import 'package:stars_studios/enums/class_enum.dart';

class ClassPickerDialog extends StatefulWidget {
  const ClassPickerDialog({super.key});

  @override
  State<ClassPickerDialog> createState() => _ClassPickerDialogState();
}

class _ClassPickerDialogState extends State<ClassPickerDialog> {
  ClassTemporaryEnumWillBeReplacedWithProperClass? _selectedClass =
      ClassTemporaryEnumWillBeReplacedWithProperClass.first;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        children: [
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.first,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.second,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.third,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.fourth,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.fifth,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.sixth,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.seventh,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.eighth,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.nineth,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          RadioListTile(
              value: ClassTemporaryEnumWillBeReplacedWithProperClass.tenth,
              groupValue: _selectedClass,
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
              title: const Text("11:30 - 12:00")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedClass);
              },
              child: const Text("Confirm choice"))
        ],
      ),
    );
  }
}
