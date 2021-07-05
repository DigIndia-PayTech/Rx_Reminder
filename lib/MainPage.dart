import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:Medicine_Remainder/listPages/Profile.dart';
import 'package:Medicine_Remainder/listPages/pillList.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:telephony/telephony.dart';

class MainPage extends StatefulWidget {
  // const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final Telephony telephony = Telephony.instance;


  var selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MyPills(),
    HomePage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          // selectedItemBorderColor: Colors.yellow,
          selectedItemBackgroundColor: Colors.blue,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.grey,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.list_alt,
            label: 'My Pills',
            selectedLabelColor: Color(0xff757478),
          ),

          FFNavigationBarItem(
            iconData: Icons.calendar_today_outlined,
            label: 'History',
            selectedLabelColor: Color(0xff757478),
          ),
          FFNavigationBarItem(iconData: Icons.person_rounded, label: 'Account',
            selectedLabelColor: Color(0xff757478),)
        ],
      ),
 body: _widgetOptions.elementAt(selectedIndex),


    );
  }
}
