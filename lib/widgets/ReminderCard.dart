import 'package:flutter/material.dart';
import '../database/moor_database.dart';

class ReminderCard extends StatelessWidget {
  final RemindersTableData reminder;
  final Color color;

  ReminderCard(this.reminder, this.color);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: 180,
      height: 180,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            width: 50,
            height: 50,
            child: Hero(
              tag: reminder.name,
              child: Image.asset(
                reminder.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  reminder.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: width * .06),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                reminder.dose.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: width * .034,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
