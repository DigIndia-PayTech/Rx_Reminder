
import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:Medicine_Remainder/listPages/Profile.dart';
import 'package:Medicine_Remainder/listPages/pillList.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:smsker/smsker.dart';


class MainPage extends StatefulWidget {
  // const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final Telephony telephony = Telephony.instance;

@override
 void initState(){
  super.initState();
  // _sendSMS();
  // WidgetsFlutterBinding.ensureInitialized();
  // // Firebase.initializeApp();
  // FlutterBackgroundService.initialize(onStart);
  // FlutterBackground.initialize();


  // AndroidNotificationChannel channel;
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification notification = message.notification;
  //   AndroidNotification android = message.notification?.android;
  //   if (notification != null && android != null && !kIsWeb) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channel.description,
  //             // TODO add a proper drawable resource to android, for now using
  //             //      one that already exists in example app.
  //             icon: 'launch_background',
  //           ),
  //         ));
  //   }
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('A new onMessageOpenedApp event was published!');
  // });
}
// void _sendSMS() async {
//   String _result = await Smsker.sendSms(message: 'taake', phone: '9945904497')
//       .catchError((onError) {
//     print(onError);
//   });
//   print('rrr$_result');
//   print('sms sent');
// }
  var selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MyPills(),
    HomePage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    print('Date data:${DateTime.now()}');
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
