// import 'package:Medicine_Remainder/divyaNoti/NotificationPlugin.dart';
// import 'package:Medicine_Remainder/divyaNoti/NotificationScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:telephony/telephony.dart';
// import 'package:flutter/services.dart';
//
// class LocalNotificationScreen extends StatefulWidget {
//   @override
//   _LocalNotificationScreenState createState() =>
//       _LocalNotificationScreenState();
// }
//
// class _LocalNotificationScreenState extends State<LocalNotificationScreen> {
//
//   int count = 0;
// // void sendsms() {
// //   telephony.sendSms(to: 'to', message: 'message');
// // }
//   var time= Time(11,47, 0);
//   static const platform = const MethodChannel('sendSms');
//   final Telephony telephony = Telephony.instance;
//   @override
//   void initState() {
//     if (time == Time(11, 47, 0)) {
//
//        platform.invokeMethod(
//           'send', <String, dynamic>{
//         "phone": "8618178237",
//         "msg": "Hello! I'm sent programatically."
//       });
//     }
//     notificationPlugin.showDailyAtTime();
//     //List<Time> times = [];
//     // NotificationPlugin notificationPlugin;
//     notificationPlugin.init();
//     super.initState();
//     // if(time == Time(10,30,0))
//
//     // print('msggg');
//
//     // var time1 = Time(17, 40, 0);
//     // if (time1 == Time(17, 40, 0)) {
//     //   print('notifying');
//     //   notificationPlugin.init();
//     //   notificationPlugin.showDailyAtTime();
//       print('notti');
//     //   setState(() {
//     //     telephony.sendSms(to: '9743032112', message: 'message');
//     //   });
//
//       //times.forEach((element) {});
//     // }
//     // ificationPlugin.setOnNotificationClick(onNotificationClick);
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightGreen,
//         title: Text('Medicine Reminder',),
//       ),
//       body: Row(
//         children: [
//           Container(
//             margin: EdgeInsets.all(3),
//             width: 175,
//             height: 130,
//             color: Colors.green,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(3),
//                   width: 50,
//                   height: 50,
//                   child:
//
//                   Hero(
//                       tag: Text('Paracetamol 250mg'),
//                       child: Icon(Icons.medical_services_sharp, size: 50, color: Colors.pink,)
//                   ),
//                 ),
//                 Container(
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 5, right: 5),
//                       child: Text(
//                         'Colpol 100: 1 pill',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   child: Center(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 50,),
//                         Icon(Icons.alarm,color: Colors.red,),
//                         Text(
//                           '1:00 PM',
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,)
//               ],
//             ),
//           ),
//           Container(
//             width: 175,
//             height: 130,
//             color: Colors.green,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(3),
//                   width: 50,
//                   height: 50,
//                   child: Hero(
//                     tag: Text('Paracetamol 250mg'),
//                     child: Icon(Icons.medical_services_sharp, size: 50, color: Colors.pink,)
//                   ),
//                 ),
//                 Container(
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 5, right: 5),
//                       child: Text(
//                        'Zincovit: 1 pill',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   child: Center(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 50,),
//                         Icon(Icons.alarm, color: Colors.red,),
//                         Text(
//                           '4:00 PM',
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
//     print('Notification Received ${receivedNotification.id}');
//   }
//
//   onNotificationClick(String payload) {
//     print('Payload $payload');
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return NotificationScreen(
//         payload: payload,
//       );
//     }));
//   }
// }
