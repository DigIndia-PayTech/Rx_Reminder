import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/OnBoardingScreens/onboarding.dart';
import 'package:Medicine_Remainder/landingPage/landingPage.dart';
import 'package:Medicine_Remainder/landingPage/notService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences sp;
// final Telephony telephony = Telephony.instance;

void init() {
  // var time1 = Time(17, 17, 0);
  // if (time1 == Time(17, 17, 0)) {
  //   print('notifying');
  //   telephony.sendSms(to: '9743032112', message: 'Take your colpol 22 pill');
    //times.forEach((element) {});
  // }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().in(); // <
  // await NotificationService().init();
  sp = await SharedPreferences.getInstance();
  initializeDateFormatting().then((_) => runApp(
      MyApp()));
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.blue[600],
  // ));
}
class MyApp extends StatelessWidget {
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
