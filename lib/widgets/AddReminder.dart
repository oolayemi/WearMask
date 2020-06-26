import 'package:flutter/material.dart';
import 'package:wearmask/database/moor_database.dart';
import 'package:wearmask/notifications/NotificationManager.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReminder extends StatefulWidget {
  final double height;
  final AppDatabase _database;
  final NotificationManager manager;
  AddReminder(this.height, this._database, this.manager);

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  static final _formKey = new GlobalKey<FormState>();
  final DateFormat dateFormat = DateFormat('EEE, MMM d, yyyy h:mma');

  String _name;
  String _dose;

  int year;
  int month;
  int day;
  int hour;
  int minute;

  DateTime selectedDate;

  int _selectedIndex = 0;
  List<String> _icons = [
    'home.png',
    'inhaler.png',
    'pill_rounded.png',
    'pill.png',
    'syringe.png',
    'ointment.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
        height: widget.height * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add New Reminder',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.cancel();
                    // back to main screen
                    Navigator.pop(context, null);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Theme.of(context).primaryColor.withOpacity(.65),
                  ),
                )
              ],
            ),
            _buildForm(),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Shape',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _buildShapesList(),
            SizedBox(
              height: 15,
            ),
            _getDateTime(),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  _submit(widget.manager);
                },
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                highlightColor: Theme.of(context).primaryColor,
                child: Text(
                  'Add Reminder'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildShapesList() {
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _icons
            .asMap()
            .entries
            .map((MapEntry map) => _buildIcons(map.key))
            .toList(),
      ),
    );
  }

  Widget _getDateTime() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0),
      ),
      color: Color(0xff00c853),
      textColor: Colors.white,
      child: Text(
        (selectedDate == null
            ? 'Choose Date & Time'
            : dateFormat.format(selectedDate)),
      ),
      onPressed: () async {
        Fluttertoast.cancel();
        final selectedDate = await _selectedDateTime(context);
        if (selectedDate == null) return;

        print(selectedDate);

        final selectedTime = await _selectedTime(context);
        if (selectedTime == null) return;

        print(selectedTime);

        setState(() {
          this.selectedDate = DateTime(
              year = selectedDate.year,
              month = selectedDate.month,
              day = selectedDate.day,
              hour = selectedTime.hour,
              minute = selectedTime.minute);
        });

        print(this.selectedDate);
      },
    );
  }

  Form _buildForm() {
    TextStyle labelsStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 25);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Where are you going?',
              labelStyle: labelsStyle,
            ),
            validator: (input) =>
                (input.length < 5) ? 'Place is too short' : null,
            onSaved: (input) => _name = input,
          ),
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Details',
              labelStyle: labelsStyle,
            ),
            validator: (input) =>
                (input.length > 50) ? 'Details is long' : null,
            onSaved: (input) => _dose = input,
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }

  void _submit(NotificationManager manager) async {
    if (_formKey.currentState.validate()) {
      if (selectedDate != null) {
        // form is validated
        _formKey.currentState.save();
        print(_name);
        print(_dose);

        // insert into database
        var reminderId = await widget._database.insertReminder(
            RemindersTableData(
                name: _name,
                dose: _dose,
                image: 'assets/images/' + _icons[_selectedIndex]));
        // schedule the notification
        manager.showScheduleNotification(
            reminderId, _name, _dose, year, month, day, hour, minute);
        // The reminder Id and Notitfaciton Id are the same
        print('New Reminder id' + reminderId.toString());
        // go back
        Navigator.pop(context, reminderId);
      }
      else {
        Fluttertoast.showToast(
          msg: "Please pick a date!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0);
      }
    }
  }

  Widget _buildIcons(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: (index == _selectedIndex)
              ? Theme.of(context).accentColor.withOpacity(.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image.asset('assets/images/' + _icons[index]),
      ),
    );
  }

  Future<TimeOfDay> _selectedTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> _selectedDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
}
