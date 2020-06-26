import 'package:flutter/material.dart';
import 'package:wearmask/animations/fade_animation.dart';
import 'package:scoped_model/scoped_model.dart';
import '../database/moor_database.dart';
import '../models/Reminder.dart';

class DeleteIcon extends StatefulWidget {
  Color color = Colors.grey;
  @override
  _DeleteIconState createState() => _DeleteIconState();
}

class _DeleteIconState extends State<DeleteIcon> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: 100,
        right: 100,
        child: ScopedModelDescendant<ReminderModel>(
            builder: (context, child, model) {
          return DragTarget<RemindersTableData>(
            builder: (context, rejectedData, candidtateData) {
              return FadeAnimation(
                .5,
                Container(
                  width: 250,
                  height: 220,
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.delete,
                      color: widget.color,
                      size: 60,
                    ),
                  ),
                ),
              );
            },
            onWillAccept: (reminder) {
              print('onWillAccept was called');
              setState(() {
                widget.color = Colors.red;
              });
              return true;
            },
            onLeave: (v) {
              setState(() {
                widget.color = Colors.grey;
              });
              print('onLeave');
            },
            onAccept: (reminder) {
              // remove it from the database
              model.getDatabase().deleteReminder(reminder);
              //remove the reminder notifcation
              model.notificationManager.removeReminder(reminder.id);
              // for debugging
              print("Reminder deleted" + reminder.toString());
              // show delete snakbar
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Reminder deleted',
                    style: TextStyle(fontSize: 20),
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        }));
  }
}
