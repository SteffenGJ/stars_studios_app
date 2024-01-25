import 'package:flutter/material.dart';

class ClassListHeader extends StatelessWidget {
  const ClassListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Center(child: Text("Date"))),
            Expanded(child: Center(child: Text("Time"))),
            Expanded(child: Center(child: Text("Coach"))),
            Expanded(child: Center(child: Text("Status"))),
          ]
        ),
      ),
    );
  }
}