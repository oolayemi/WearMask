import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wearmask/animations/fade_animation.dart';
import 'package:wearmask/widgets/AddReminder.dart';
import 'package:wearmask/widgets/ReminderEmptyState.dart';
import 'package:scoped_model/scoped_model.dart';
import 'GMap.dart';
import 'popup_menu.dart';

import 'enums/icon_enum.dart';
import 'models/Reminder.dart';
import 'widgets/AppBar.dart';
import 'widgets/DeleteIcon.dart';
import 'widgets/ReminderGridView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // dismiss the keyboard or focus
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Wear Mask',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff3EB16E),
          accentColor: Color(0xff00c853),
        ),
        home: MyReminder(),
      ),
    );
  }
}

class MyReminder extends StatefulWidget {
  MyReminder();

  @override
  _MyReminder createState() => _MyReminder();
}

class _MyReminder extends State<MyReminder> {
  GlobalKey btnKey = GlobalKey();
  double deviceHeight;
  ReminderModel model;
  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    deviceHeight = MediaQuery.of(context).size.height;

    return ScopedModel<ReminderModel>(
      model: model = ReminderModel(),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add Reminder',
            key: btnKey,
            onPressed: () {
              maxColumn();
              //buildBottomSheet(deviceHeight, model);
            },
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                MyAppBar(greenColor: Theme.of(context).primaryColor),
                Expanded(
                  child: ScopedModelDescendant<ReminderModel>(
                    builder: (context, child, model) {
                      return Stack(children: <Widget>[
                        buildRemindersView(model),
                        (model.getCurrentIconState() == DeleteIconState.hide)
                            ? Container()
                            : DeleteIcon()
                      ]);
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  FutureBuilder buildRemindersView(model) {
    return FutureBuilder(
      future: model.getReminderList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data.length == 0) {
            // No data
            return Center(child: ReminderEmptyState());
          }
          return ReminderGridView(snapshot.data);
        }
        return (Container());
      },
    );
  }

  void buildBottomSheet(double height, ReminderModel model) async {
    var reminderId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            AddReminder(height, model.getDatabase(), model.notificationManager),
          );
        });

    if (reminderId != null) {
      Fluttertoast.showToast(
          msg: "The Reminder was added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).accentColor,
          textColor: Colors.white,
          fontSize: 20.0);

      setState(() {});
    }
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        // backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        maxColumn: 1,
        items: [
          MenuItem(
            title: 'Map',
            image: Icon(
              Icons.map,
              color: Colors.white,
            ),
          ),
          MenuItem(
            title: 'Add Event',
            image: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    if (item.menuTitle == 'Map') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GMap()),
      );
    } else {
      buildBottomSheet(deviceHeight, model);
      //print('Click menu -> ${item.menuTitle}');
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
}
