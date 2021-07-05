
import 'package:sms_scheduler/models/message.dart';
import 'package:sms_scheduler/sms_scheduler.dart';

scheduleMessage(int mobileNumber, DateTime dateTime){
  SmsScheduler.scheduleMessage(Message(
      number: mobileNumber,
      message: 'Your sms scheduler',
      scheduledTime: dateTime
  ));

  }