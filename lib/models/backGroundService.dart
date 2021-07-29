import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class BackgroundService{

  static BackgroundService _instance;
  factory BackgroundService() => _instance ??= new BackgroundService._();
  BackgroundService._();


  void start() {
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


}

