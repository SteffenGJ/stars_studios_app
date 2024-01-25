import 'package:flutter/material.dart';
import 'package:stars_studios/components/dialogs/booking_dialog.dart';
import 'package:stars_studios/components/dialogs/class_picker_dialog.dart';
import 'package:stars_studios/enums/class_enum.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}


class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  ClassTemporaryEnumWillBeReplacedWithProperClass? _finalClass;
  Coach? _finalCoach;
  String _dropdownValue = "30 min";

  void _pickDate () async {
    final DateTime? day = await showDatePicker(
      context: context, 
      firstDate: DateTime(2024, 1, 10), 
      lastDate: DateTime(2024, 1, 20), 
      selectableDayPredicate: (day) => _isSelectableDay(day),
    );

    setState(() {
      _selectedDate = day;
    });
  }


  bool _isSelectableDay (DateTime day) {
    if (day.weekday == 6 || day.weekday == 7) {
        return false;
      }
    return true;
  }


  void _showClassPickerDialog () async {
    final value = await showDialog(context: context, builder: (_) => const ClassPickerDialog());
    
    setState(() {
      _finalClass = value;
    });
  }
  

  void _showBookingDialog (context) async {
    final value = await showDialog(context: context, builder: (context) => 
      BookingDialog(
        finalCoach: _finalCoach, 
        selectedDate: _selectedDate, 
        finalClass: _finalClass
      )
    );

    if (value == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking confirmed")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking a class"),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Booking Screen", style: Theme.of(context).textTheme.titleMedium,),
            const Text(
              "Place holder text. This is supposed to be a very detailed explanation of how this can work out. You bear the full responsibility and you have a cancel policy for about 365 years in a decade. If you accept the terms and conditions please move ahead."
            ),
            DropdownButton(
              value: _finalCoach,
              items: const [
                DropdownMenuItem(value: Coach.susanne, child: Text("Susanne")),
                DropdownMenuItem(value: Coach.francesca, child: Text("Francesca")),
              ], 
              onChanged: (value) {
                setState(() {
                  _finalCoach = value;
                });
              }
            ),
            Text(_finalCoach?.toString() ?? "No coach selected"),
            DropdownButton(
              value: _dropdownValue,
              items: const [
                DropdownMenuItem(value: "30 min", child: Text("30 min - 90€")),
                DropdownMenuItem(value: "60 min", child: Text("60 min - 160€")),
              ], 
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value.toString();
                });
              }
            ),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text("Book"),
            ),
            Text(_selectedDate?.toString() ?? "No date selected"),
            ElevatedButton(
              onPressed: _showClassPickerDialog,
              child: const Text("Select time"),
            ),
            Text(_finalClass?.toString() ?? "No available class selected"),
            ElevatedButton(
              onPressed: ()  => _showBookingDialog(context),
              child: const Text("Confirm booking")
            ),
          ],
        ),
      ),
    );
  }
}


