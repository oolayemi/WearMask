import '../database/moor_database.dart';
import '../models/Reminder.dart';
import 'package:flutter/material.dart';
import 'ReminderCard.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wearmask/animations/fade_animation.dart';

class ReminderGridView extends StatelessWidget {
  final List<RemindersTableData> list;
  ReminderGridView(this.list);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ReminderModel>(
        builder: (context, child, model) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: list.map((reminder) {
          return InkWell(
            onTap: () {
              // details screen
            },
            child: buildLongPressDraggable(reminder, model),
          );
        }).toList(),
      );
    });
  }

  LongPressDraggable<RemindersTableData> buildLongPressDraggable(
      reminder, ReminderModel model) {
    return LongPressDraggable<RemindersTableData>(
      data: reminder,
      onDragStarted: () {
        // show the delete icon
        model.toggleIconState();
      },
      onDragEnd: (v) {
        // hide the delete icon
        model.toggleIconState();
      },
      child: FadeAnimation(
        .05,
        Card(
          margin: EdgeInsets.all(10),
          child: ReminderCard(reminder, Colors.white),
        ),
      ),
      childWhenDragging: Container(
        color: Color(0xff3EB16E).withOpacity(.3),
      ),
      feedback: Card(
        child: ReminderCard(reminder, Colors.transparent),
      ),
    );
  }
}
