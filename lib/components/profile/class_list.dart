import 'package:flutter/material.dart';
import 'package:stars_studios/components/profile/class_list_header.dart';
import 'package:stars_studios/components/profile/class_list_row.dart';
import 'package:stars_studios/models/class.dart';

class ClassList extends StatelessWidget {
  final List<Class> list;

  const ClassList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ClassListHeader(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            final currentClass = list[index];
            return ClassListRow(
              date: currentClass.date,
              time: currentClass.time,
              coach: currentClass.coach,
              status: currentClass.status,
            );
          },
        ),
      ],
    );
  }
}

