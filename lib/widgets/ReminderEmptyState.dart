import 'package:flutter/material.dart';
import 'package:wearmask/animations/fade_animation.dart';

class ReminderEmptyState extends StatelessWidget {
  const ReminderEmptyState({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      .5,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/no_face_mask.png',
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            'No Reminders Yet',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 1.2),
          )
        ],
      ),
    );
  }
}
