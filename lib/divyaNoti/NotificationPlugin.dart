// import 'dart:ffi';
// import 'package:sms_scheduler/sms_scheduler.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_sms/flutter_sms.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' show File, Platform;
// import 'package:sms_scheduler/models/message.dart';
// import 'package:sms_scheduler/sms_scheduler.dart';
// import 'package:http/http.dart' as http;
// import 'package:rxdart/subjects.dart';
//
// import 'package:telephony/telephony.dart';
//
// class NotificationPlugin {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   final BehaviorSubject<ReceivedNotification>
//   didReceivedLocalNotificationSubject =
//   BehaviorSubject<ReceivedNotification>();
//   var initializationSettings;
//
//   NotificationPlugin._() {
//     init();
//   }
//
//   // var time = Time(21, 20, 0);
//
//   init() async {
//     tz.initializeTimeZones();
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     bool permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
//     // if (Platform.isIOS) {
//     //   await flutterLocalNotificationsPlugin
//     //       .resolvePlatformSpecificImplementation<
//     //       IOSFlutterLocalNotificationsPlugin>()
//     //       .requestPermissions(
//     //     alert: true,
//     //     badge: true,
//     //     sound: true,
//     //   );
//     // }
//
//     initializePlatformSpecifics();
//
//     // showDailyAtTime(time);
//   }
//
//   final Telephony telephony = Telephony.instance;
//   var time = Time(10, 34, 0);
//
//   // // final Telephony telephony = Telephony.instance;
//   // var to = '8618178237';
//   // var message = 'hftuyj';
//
//
//   // bool permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
//
//   initializePlatformSpecifics() {
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         ReceivedNotification receivedNotification = ReceivedNotification(
//           id: id,
//           title: title,
//           body: body,
//           payload: payload,
//           // sms: telephony.sendSms(to: to, message: message)
//
//         );
//         didReceivedLocalNotificationSubject.add(receivedNotification);
//       },
//     );
//
//     initializationSettings = InitializationSettings(
//         initializationSettingsAndroid,  initializationSettingsIOS);
//   }
//
//   // _requestIOSPermission() async {
//   //   await flutterLocalNotificationsPlugin
//   //       .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//   //       .requestPermissions(
//   //     alert: false,
//   //     badge: true,
//   //     sound: true,
//   //   );
//   // }
//
//   setListenerForLowerVersions(Function onNotificationInLowerVersions) {
//     didReceivedLocalNotificationSubject.listen((receivedNotification) {
//       onNotificationInLowerVersions(receivedNotification);
//     });
//   }
//
//   setOnNotificationClick(Function onNotificationClick) async {
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String payload) async {
//           onNotificationClick(payload);
//         });
//   }
//
//   Future<void> showNotification() async {
//     var time = Time(00, 23, 0);
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'CHANNEL_NAME',
//       "CHANNEL_DESCRIPTION",
//       importance: Importance.Max,
//       priority: Priority.High,
//       playSound: true,
//       ticker: '5000',
//       styleInformation: DefaultStyleInformation(true, true),
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//          androidChannelSpecifics, iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Test Title',
//       'Test Body',
//       //null
//       platformChannelSpecifics,
//       payload: 'New Payload',
//     );
//   }
//
//   Future<void> showDailyAtTime() async {
//     var time = Time(11, 59, 0);
//     // var tele= telephony.sendSms(to: to, message: message);
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 4',
//       'CHANNEL_NAME 4',
//       "CHANNEL_DESCRIPTION 4",
//       importance: Importance.Max,
//       priority: Priority.High,
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//        androidChannelSpecifics,iosChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.showDailyAtTime(
//       0,
//       'Time to take your pill${time.hour}:${time.minute}.${time.second}',
//       'colpol 250mg', //null
//       time,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//
//     );
//
//
//     time == Time(11, 59, 0)
//         ?
//     telephony.sendSms(to: '8618178237', message: 'Take your colpol 22 pill')
//         : telephony.sendSms(to: '', message: 'message');
//
//
//     print('donee..');
//
//     // SmsScheduler.scheduleMessage(Message(
//     //     number: '',
//     //     message: 'Your sms scheduler works!',
//     //     scheduledTime: DateTime.now().add(Duration(seconds: 10))
//     // ),);
//
//     }
//
//   Future<void> showWeeklyAtDayTime() async {
//     var time = Time(7, 43, 0);
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 5',
//       'CHANNEL_NAME 5',
//       "CHANNEL_DESCRIPTION 5",
//       importance: Importance.Max,
//       priority: Priority.High,
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       androidChannelSpecifics, iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//       0,
//       'Test Title at ${time.hour}:${time.minute}.${time.second}',
//       'Test Body', //null
//       Day.Tuesday,
//       time,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//     );
//   }
//
//   Future<void> repeatNotification() async {
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 3',
//       'CHANNEL_NAME 3',
//       "CHANNEL_DESCRIPTION 3",
//       importance: Importance.Max,
//       priority: Priority.High,
//       styleInformation: DefaultStyleInformation(true, true),
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidChannelSpecifics,  iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0,
//       'Repeating Test Title',
//       'Repeating Test Body',
//       RepeatInterval.EveryMinute,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//     );
//   }
//
//   // Future<void> scheduleNotification() async {
//   //   var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
//   //   var androidChannelSpecifics = AndroidNotificationDetails(
//   //     'CHANNEL_ID 1',
//   //     'CHANNEL_NAME 1',
//   //     "CHANNEL_DESCRIPTION 1",
//   //     icon: 'secondary_icon',
//   //     sound: RawResourceAndroidNotificationSound('my_sound'),
//   //     largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
//   //     enableLights: true,
//   //     color: const Color.fromARGB(255, 255, 0, 0),
//   //     ledColor: const Color.fromARGB(255, 255, 0, 0),
//   //     ledOnMs: 1000,
//   //     ledOffMs: 500,
//   //     importance: Importance.max,
//   //     priority: Priority.high,
//   //     playSound: true,
//   //     timeoutAfter: 5000,
//   //     styleInformation: DefaultStyleInformation(true, true),
//   //   );
//   //   var iosChannelSpecifics = IOSNotificationDetails(
//   //     sound: 'my_sound.aiff',
//   //   );
//   //   var platformChannelSpecifics = NotificationDetails(
//   //      androidChannelSpecifics,
//   //    iosChannelSpecifics,
//   //   );
//   //   await flutterLocalNotificationsPlugin.schedule(
//   //     0,
//   //     'Test Title nw',
//   //     'Test Body nw',
//   //     scheduleNotificationDateTime,
//   //     platformChannelSpecifics,
//   //     payload: 'Test Payload',
//   //   );
//   // }
//
//   // Future<void> showNotificationWithAttachment() async {
//   //   var attachmentPicturePath = await _downloadAndSaveFile(
//   //       'https://via.placeholder.com/800x200', 'attachment_img.jpg');
//   //   var iOSPlatformSpecifics = IOSNotificationDetails(
//   //     attachments: [IOSNotificationAttachment(attachmentPicturePath)],
//   //   );
//   //   var bigPictureStyleInformation = BigPictureStyleInformation(
//   //     FilePathAndroidBitmap(attachmentPicturePath),
//   //     contentTitle: '<b>Attached Image</b>',
//   //     htmlFormatContentTitle: true,
//   //     summaryText: 'Test Image',
//   //     htmlFormatSummaryText: true,
//   //   );
//   //   var androidChannelSpecifics = AndroidNotificationDetails(
//   //     'CHANNEL ID 2',
//   //     'CHANNEL NAME 2',
//   //     'CHANNEL DESCRIPTION 2',
//   //     importance: Importance.high,
//   //     priority: Priority.high,
//   //     styleInformation: bigPictureStyleInformation,
//   //   );
//   //   var notificationDetails = NotificationDetails(
//   //       android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
//   //   await flutterLocalNotificationsPlugin.show(
//   //     0,
//   //     'Title with attachment',
//   //     'Body with Attachment',
//   //     notificationDetails,
//   //   );
//   // }
//
//   _downloadAndSaveFile(String url, String fileName) async {
//     var directory = await getApplicationDocumentsDirectory();
//     var filePath = '${directory.path}/$fileName';
//     var response = await http.get(Uri.parse(url));
//     var file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }
//
//   Future<int> getPendingNotificationCount() async {
//     List<PendingNotificationRequest> p =
//     await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//     return p.length;
//   }
//
//   Future<void> cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancel(0);
//   }
//
//   Future<void> cancelAllNotification() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
//
// NotificationPlugin notificationPlugin = NotificationPlugin._();
//
// class ReceivedNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;
//
//   // Future<void> sms;
//
//   ReceivedNotification({
//     @required this.id,
//     @required this.title,
//     @required this.body,
//     @required this.payload,
//     // @required this.sms,
//   });
// }
