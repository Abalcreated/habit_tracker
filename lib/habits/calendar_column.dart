import 'package:flutter/material.dart';
import 'package:Habits/constants.dart';
import 'package:Habits/habits/calendar_header.dart';
import 'package:Habits/habits/empty_list_image.dart';
import 'package:Habits/habits/habit.dart';
import 'package:Habits/habits/habits_manager.dart';
import 'package:provider/provider.dart';

class CalendarColumn extends StatelessWidget {
  const CalendarColumn({super.key});

  @override
  Widget build(BuildContext context) {
    List<Habit> calendars = Provider.of<HabitsManager>(context).getAllHabits;

    return Column(
      children: <Widget>[
        Container(
          color: HaboColors.primary,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: CalendarHeader(),
          ),
        ),
        Expanded(
          child: (calendars.isNotEmpty)
              ? ReorderableListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                  children: calendars
                      .map(
                        (index) => Container(
                          key: ObjectKey(index),
                          child: index,
                        ),
                      )
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    Provider.of<HabitsManager>(context, listen: false)
                        .reorderList(oldIndex, newIndex);
                  },
                )
              : const EmptyListImage(),
        ),
      ],
    );
  }
}
