import 'package:Medicine_Remainder/landingPage/notService.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  var flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }
  void initNotifications() async{
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

   await  flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  // void showNotificationDaily(
  //     int id, String title, String body, int hour, int minute) async {
  //   var time = new Time(hour, minute, 0);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       id, title, body, time, getPlatformChannelSpecfics());
  //   print('Notification Succesfully Scheduled at ${time.toString()}');
  // }
  void showNotification(
    int id,
    String title,
    String body,
  ) async {
    await flutterLocalNotificationsPlugin.show(
        id, title, body, getPlatformChannelSpecfics());
    print('notification');
  }

  void showNotificationDaily(
      int id, String title, String body, Time time, DateTime dateTime) async {
    // Time time = new Time(hour, minute, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics());
    print('Notification Succesfully Scheduled at ${time.hour}:${time.minute}, ${dateTime.month}, ${dateTime.day}');
    // flutterLocalNotificationsPlugin.schedule(1, "Times Uppp", task,
    //     scheduledTime, generalNotificationDetails);
  }
  getPlatformChannelSpecfics() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'Medicine Reminder');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }
  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
