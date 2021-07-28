import 'dart:async';

import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/OnBoardingScreens/onboarding.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/landingPage/landingPage.dart';
import 'package:Medicine_Remainder/landingPage/notService.dart';
import 'package:Medicine_Remainder/landingPage/notificationManager.dart';
import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:Medicine_Remainder/listPages/editRxlist.dart';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

SharedPreferences sp;
// final Telephony telephony = Telephony.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  FlutterBackgroundService.initialize(onStart);
  FlutterBackground.initialize();
  sp = await SharedPreferences.getInstance();
  initializeDateFormatting().then((_) => runApp(MyApp()));

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.blue[600],
  // ));
}
void onStart() {
  AddManuallyViewModel viewModel = AddManuallyViewModel();
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }
    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }
    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });
  // bring to foreground
  service.setForegroundMode(true);
  // if (!(await service.isServiceRunning())) timer.cancel();
  // var cron = Cron();
  // // viewModel.scheduleNotifications(pill, rxID, time);
  // cron.schedule(
  //     Schedule.parse(
  //         '*/5 */10 */1 * * *'),
  //         () async {
  //       print('Cron running');
  //       var telephony = Telephony.instance;
  //       int i = 0;
  //       // print('user phn: $userPhn');
  //       print('SMS sent to user ');
  //       final NotificationManager notificationManager = NotificationManager();
  //       notificationManager.initNotifications();
  //       notificationManager.showNotification(
  //         99,
  //         'Time to take your ',
  //         'Take 2 pills',
  //       );
  //       telephony.sendSms(
  //           to: '8618178237', message: 'Time to take your  Take 6 pills');
  //       cron.close();
  //     });
  // var telephony = Telephony.instance;
  // telephony.sendSms(
  //     to: '8884499678',
  //     message:
  //     'Time to take your  pills');
  // });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// class _MyAppState extends State<MyApp> {
//   String text = "Stop Service";
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Service App'),
//         ),
//         body: Container()
//       ),
//     );
//   }
// }

class _MyAppState extends State<MyApp> {
  bool onBoarding = sp.getBool('OnBoarding');
  String userID = sp.getInt('UserID').toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // EditManual()
      // HomePage()
      // StartPage()
      // LocalNotificationScreen(),

      getPage(onBoarding, userID),

    );
  }
}

getPage(bool onBoarding, userID) {
  if (onBoarding == null) {

    return OnBoarding();
  } else if (userID != 'null') {
    return MainPage();
  } else {
    return LandingPage();
  }
}

// class StartPage extends StatefulWidget {
//   @override
//   _StartPageState createState() => _StartPageState();
// }
//
// class _StartPageState extends State<StartPage> {
//   void init() {
//     // sendSms();
//   }
//
//   static const platform = const MethodChannel('sendSms');
//
//  // void sendSms() async {
//  //    print("SendSMS");
//  //    SmsScheduler.scheduleMessage(Message(
//  //        number: 8618178237,
//  //        message: 'Your sms scheduler works!',
//  //        scheduledTime: DateTime.now().add(Duration(seconds: 10))
//  //    ));
//  //  }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar Example'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: new FlatButton(onPressed: () => sendSms(), child: const Text("Send SMS")),
//       ),
//       // body: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     children: [
//       //       const SizedBox(height: 20.0),
//       //       ElevatedButton(
//       //         child: Text('Basics'),
//       //         onPressed: () => Navigator.push(
//       //           context,
//       //           MaterialPageRoute(builder: (_) => editprofile()),
//       //         ),
//       //       ),
//       //       const SizedBox(height: 12.0),
//       //       // ElevatedButton(
//       //       //   child: Text('Range Selection'),
//       //       //   onPressed: () => Navigator.push(
//       //       //     context,
//       //       //     MaterialPageRoute(builder: (_) => TableRangeExample()),
//       //       //   ),
//       //       // ),
//       //       // const SizedBox(height: 12.0),
//       //       // ElevatedButton(
//       //       //   child: Text('Events'),
//       //       //   onPressed: () => Navigator.push(
//       //       //     context,
//       //       //     MaterialPageRoute(builder: (_) => TableEventsExample()),
//       //       //   ),
//       //       // ),
//       //       // const SizedBox(height: 12.0),
//       //       // ElevatedButton(
//       //       //   child: Text('Multiple Selection'),
//       //       //   onPressed: () => Navigator.push(
//       //       //     context,
//       //       //     MaterialPageRoute(builder: (_) => TableMultiExample()),
//       //       //   ),
//       //       // ),
//       //       // const SizedBox(height: 12.0),
//       //       // ElevatedButton(
//       //       //   child: Text('Complex'),
//       //       //   onPressed: () => Navigator.push(
//       //       //     context,
//       //       //     MaterialPageRoute(builder: (_) => TableComplexExample()),
//       //       //   ),
//       //       // ),
//       //       const SizedBox(height: 20.0),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
//
// import 'package:Medicine_Remainder/notificationServices.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// ///Receive message when app is in background solution for on message
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification.title);
// }
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         "red": (_) => RedPage(),
//         "green": (_) => GreenPage(),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   String messageTitle = "Empty";
//   String notificationAlert = "alert";
//
//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   FirebaseMessaging messaging;
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _firebaseMessaging.configure(
//       onMessage: (message) async{
//         setState(() {
//           messageTitle = message["notification"]["title"];
//           notificationAlert = "New Notification Alert";
//         });
//
//       },
//       onResume: (message) async{
//         setState(() {
//           messageTitle = message["data"]["title"];
//           notificationAlert = "Application opened from Notification";
//         });
//
//       },
//
//       onBackgroundMessage:
//     );
//
//     LocalNotificationService.initialize(context);
//
//     ///gives you the message on which user taps
//     ///and it opened the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if(message != null){
//         final routeFromMessage = message.data["route"];
//
//         Navigator.of(context).pushNamed(routeFromMessage);
//       }
//     });
//
//     ///forground work
//     FirebaseMessaging.onMessage.listen((message) {
//       if(message.notification != null){
//         print(message.notification.body);
//         print(message.notification.title);
//       }
//
//       LocalNotificationService.display(message);
//     });
//
//     ///When the app is in background but opened and user taps
//     ///on the notification
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       final routeFromMessage = message.data["route"];
//
//       Navigator.of(context).pushNamed(routeFromMessage);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Center(
//             child: Text(
//               "You will receive message soon",
//               style: TextStyle(fontSize: 34),
//             )),
//       ),
//     );
//   }
// }
