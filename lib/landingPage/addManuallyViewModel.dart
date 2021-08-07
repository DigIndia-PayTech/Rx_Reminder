import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/listPages/Profile.dart';
import 'package:Medicine_Remainder/utils/awesomeNotifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;
import 'package:Medicine_Remainder/Core/Models/familyModel.dart';
import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/Core/Models/profileModel.dart';
import 'package:Medicine_Remainder/Core/Models/rxHistoryModel.dart';
import 'package:Medicine_Remainder/landingPage/addManual.dart';
import 'package:Medicine_Remainder/landingPage/notificationManager.dart';
import 'package:Medicine_Remainder/log_Pages/Signup.dart';
import 'package:Medicine_Remainder/log_Pages/signIn.dart';
import 'package:Medicine_Remainder/server.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cron/cron.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smsker/smsker.dart';
import 'package:stacked/stacked.dart';
import 'package:telephony/telephony.dart';

class AddManuallyViewModel extends BaseViewModel {
  var text;
  File croppedFile;
  bool siPassword = false;
  Server server = new Server();
  List<Pill> pillList = [];
  List<Pill> scheduleList = [];

  List<FamilyMember> membersList = [];
  List<RxHistory> historyList = [];
  var userImage;

  //List<Pill> familyMembersList = [];
  List<Pill> selectedPillList = [];
  List<Pill> onGoingPillList = [];
  List<Pill> expiringList = [];
  List<Pill> expiredPillList = [];
  String pillStatus;
  String selectedDate;

  Time translateTime(String data) {
    int hh, mm;
    String meridian;
    meridian = data.substring(6, 8);
    hh = int.parse(data.substring(0, 2));
    hh = meridian == 'AM'
        ? hh
        : hh < 12
            ? (hh + 12)
            : hh;
    mm = int.parse(data.substring(3, 5));
    Time time = Time(hh, mm, 0);
    // print(time.hour);
    // print(time.minute);
    return time;
  }

  // final Telephony telephony = Telephony.instance;

  // AddManuallyViewModel({Key key, this.value}) : super();
  @override
  void initState() {
    siPassword = false;
    // SmsScheduler.smsSchedulerStream.listen((messages) {
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   SmsScheduler.getScheduledMessages;
    // });
    // if (time1 == Time(16, 57, 0)) {
    //   print('notifying');
    //   telephony.sendSms(to: '9743032112', message: 'Take your colpol 22 pill');
    //   //times.forEach((element) {});
    // }
    getText();
    // famname.text = famList[index].membername;
  }

  EditProfile editProfile = EditProfile();
  String userId;
  String memberId;
  SharedPreferences sp;
  String medName;
  TextEditingController dateController1 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();
  TextEditingController timeController1 = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  TextEditingController timeController3 = TextEditingController();
  TextEditingController famMember = TextEditingController();
  TextEditingController famPhone = TextEditingController();
  TextEditingController famMsg = TextEditingController();
  var famGender;
  var validText = '';
  var count = 0;
  var chosenvalue;
  var when;
  var data;
  var day;
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  var gender;
  TextEditingController password = TextEditingController();
  TextEditingController confPassword = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email_mob = TextEditingController();
  TextEditingController signinPass = TextEditingController();

  var gen;
  TextEditingController editdateController1 = TextEditingController();
  TextEditingController editdateController2 = TextEditingController();
  TextEditingController edittimeController1 = TextEditingController();
  TextEditingController edittimeController2 = TextEditingController();
  TextEditingController edittimeController3 = TextEditingController();
  var editfamGender;

  // var validText = '';
  var editcount = 0;
  var editchosenvalue;
  var editwhen;
  var editdata;
  var editday;
  var userPhn;

  // var user_id;

  initialise(text) async {
    // String temp = await getText();
    // String rxnmae = await getTitle();
    // medicineName.text = text;

    notifyListeners();
    // getUserid();
  }

  sharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    userPhn = sp.getInt('UserPhn').toString();
  }

  getMemberid() {
    memberId = sp.getInt('key').toString();
  }

  getUser() {
    userId = sp.getInt('UserID').toString();
  }

  var _extractText;
  String rxname;
  String rxtype;
  String qty;

  getDate(String data) {
    List<String> date = data.split('/');
    return date[2] + '-' + date[0] + '-' + date[1];
  }

  reverseGetDate(String data) {
    if (data != null) {
      List<String> date = data.split('-');
      return date[1] + '/' + date[2] + '/' + date[0];
    }
  }

  startBackgroundService() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterBackground.initialize();
    // await FlutterBackgroundService.initialize(onStart);
  }

  // void onStart() {
  //   // AddManuallyViewModel viewModel = AddManuallyViewModel();
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final service = FlutterBackgroundService();
  //   service.onDataReceived.listen((event) {
  //     if (event["action"] == "setAsForeground") {
  //       service.setForegroundMode(true);
  //       print('foreground');
  //       return;
  //     }
  //     if (event["action"] == "setAsBackground") {
  //       print('background');
  //       service.setForegroundMode(false);
  //     }
  //     if (event["action"] == "stopService") {
  //       service.stopBackgroundService();
  //       print('stopp');
  //     }
  //   });
  //   // bring to foreground
  //   service.setForegroundMode(true);
  //   Timer.periodic(Duration(seconds: 6), (timer) async {
  //     if (!(await service.isServiceRunning())) timer.cancel();
  //
  //     service.setNotificationInfo(
  //       title: "My App Service",
  //       content: "Updated at ${DateTime.now()}",
  //     );
  //     service.sendData(
  //       {"current_date": DateTime.now().toIso8601String()},
  //     );
  //   });
  //   // viewModel.rxList('ongoing');
  //   // if (!(await service.isServiceRunning())) timer.cancel();
  //   // var cron = Cron();
  //   // // viewModel.scheduleNotifications(pill, rxID, time);
  //   // cron.schedule(
  //   //     Schedule.parse(
  //   //         '*/5 */10 */1 * * *'),
  //   //         () async {
  //   //       print('Cron running');
  //   //       var telephony = Telephony.instance;
  //   //       int i = 0;
  //   //       // print('user phn: $userPhn');
  //   //       print('SMS sent to user ');
  //   //       final NotificationManager notificationManager = NotificationManager();
  //   //       notificationManager.initNotifications();
  //   //       notificationManager.showNotification(
  //   //         99,
  //   //         'Time to take your ',
  //   //         'Take 2 pills',
  //   //       );
  //   //       telephony.sendSms(
  //   //           to: '8618178237', message: 'Time to take your  Take 6 pills');
  //   //       cron.close();
  //   //     });
  //   // var telephony = Telephony.instance;
  //   // telephony.sendSms(
  //   //     to: '8884499678',
  //   //     message:
  //   //     'Time to take your  pills');
  //   // });
  // }

  // onStart() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final service = FlutterBackgroundService();
  //   service.setForegroundMode(true);
  //   Timer.periodic(Duration(seconds: 5), (timer) async {
  //     if (!(await service.isServiceRunning())) timer.cancel();
  //     service.setNotificationInfo(
  //       title: "My App Service",
  //       content: "Updated at ${DateTime.now()}",
  //     );
  //     service.sendData(
  //       {"current_date": DateTime.now().toIso8601String()},
  //     );
  //   });
  // }

  // getUserId() async {
  //   rxname = medName;
  //   //rxtype = medForm.toString();
  //   qty = qty.toString();
  //   setReminderPost();
  //   // Navigator.push(context, MaterialPageRoute(
  //   //      builder: (BuildContext context) => RemainderPage()));
  // }

  getText() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    medName = sp.getString('_extractText');
    print('$medName');
  }

  //------signUp post function----
  signUpPost(context, Pill pill) async {
    var url = '${server.serverurl}sign_up';
    var data = {
      "secretpass": "ADMIN",
      "first_name": username.text,
      "last_name": lastname.text,
      "mobile_no": phone.text.toString(),
      "email": email.text,
      "password": password.text,
      "age": age.text.toString(),
      "city": city.text,
      "gender": gender.toString(),
      "secretkey": "ADMIN",
    };
    // var body = json.encode(data);
    print('data..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success signed up');
      print(response.body);
      var parsed = json.decode('${response.body}');
      var responseCode = parsed[0]['response_code'];
      var status = parsed[0]['status'];
      print('$responseCode ,$status');
      print('signnnnn');
      if (responseCode == "000" && status == "Email ID Already Exist !") {
        print('email exists');
        showAlertDialogSignInEmail(context, pill: pill);
      } else if (responseCode == "000" &&
          status == "Mobile Number Already Exist !") {
        print('phone exists');
        showAlertDialogSignInMobile(context, pill: pill);
      } else if (responseCode == "001") {
        showAlertDialogSucessSignUp(context, pill: pill);
        await Future<String>.delayed(const Duration(seconds: 2));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignIn(
                      pill: pill,
                    )));
        print('tyuii');

        // showAlertDialogSucessSignUp(context, pill: pill);
        // // Timer(),
        // // await Future<String>.delayed(const Duration(seconds: 1));
        //
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => SignIn(
        //               pill: pill,
        //             )));

        // await Future<String>.delayed(const Duration(seconds: 2));
        //
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignIn(
        //   pill: pill,
        // )));

        // userId = data[0]['user_id'].toString();
        // sp.setInt('UserID', int.parse(userId));

        // SharedPreferences sp = await SharedPreferences.getInstance();
        // print('herrruuuuu');
        // sp.setString('user_id', userId.toString());
      }

      var userId = parsed[0]['user_id'];
      print('user id$userId');
      SharedPreferences sp = await SharedPreferences.getInstance();
      print('herrruuuuu');
      sp.setString('user_id', userId.toString());
    } else {
      print('failed...${response.statusCode}');
    }
  }

  //------Sign In function-----
  signInPost(context, Pill pill) async {
    {
      var url = "${server.serverurl}sign_in";
      var body = {
        "secretpass": "ADMIN",
        "secretkey": "ADMIN",
        "email_mob": email_mob.text.toString(),
        "password": signinPass.text.toString(),
      };
      var response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        print('successfully logged in....${response.body}');
        var data = json.decode('${response.body}');
        var responsecode = data[0]['response_code'];
        var status = data[0]['status'];
        print('$responsecode ,$status');
        print('signnnnn');
        if (responsecode == "000" && status == "Invalid Login Credentials !") {
          print('dfdf');
          showAlertDialogSignInInvalid(context, pill: pill);
        } else if (responsecode == "001") {
          print('tyuii');
          userId = data[0]['user_id'].toString();
          userPhn = data[0]['mobile_no'].toString();
          sp.setInt('UserID', int.parse(userId));
          sp.setInt('UserPhn', int.parse(userPhn));

          showAlertDialogSucessSignIn(context, pill: pill);
          await Future<String>.delayed(const Duration(seconds: 2));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddManual(pill: pill)));

          // SharedPreferences sp = await SharedPreferences.getInstance();
          // print('herrruuuuu');
          // sp.setString('user_id', userId.toString());
        }
        //
        // var userId = parsed['user_id'];
        // print('$username');
      } else {
        print('Failed...${response.statusCode}');
      }
    }
  }

  //-----Rx post function-------
  setReminderPost(Pill pill) async {
    setBusy(true);
    var familyMembers = [];
    pill.familyMembers.forEach((element) {
      familyMembers.add({'name': element.name, 'value': element.mobile});
    });
    print(
        '${dateController1.text.toString()}${dateController2.text.toString()}');
    var url = 'https://cr.digindiapaytech.in/mobile_api/save_rx_details';
    var map = Map<String, dynamic>();
    map["secretkey"] = "ADMIN";
    map["secretpass"] = "ADMIN";
    map["user_id"] = userId;
    // medForm.toString(),
    map["type"] = pill.type;
    map["rx_title"] = pill.rxTitle;
    map["total_tablets"] = pill.totalTablets;
    map["start_date"] = pill.startDate;
    map["end_date"] = pill.endDate;
    map['when_in_day'] = [
      {
        "attribute": pill.whenInDay[0].attribute,
        "time": pill.whenInDay[0].time,
        "count": pill.whenInDay[0].count,
        "food": pill.whenInDay[0].when
      },
      {
        "attribute": pill.whenInDay[0].attribute,
        "time": pill.whenInDay[1].time,
        "count": pill.whenInDay[0].count,
        "food": pill.whenInDay[0].when
      },
      {
        "attribute": pill.whenInDay[0].attribute,
        "time": pill.whenInDay[2].time,
        "count": pill.whenInDay[0].count,
        "food": pill.whenInDay[0].when
      }
    ];
    map['family_members'] = pill.familyMembers;
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId,
      // medForm.toString(),
      "type": pill.type,
      "rx_title": pill.rxTitle,
      "total_tablets": pill.totalTablets,
      "start_date": pill.startDate,
      "end_date": pill.endDate,
      "when_in_day": json.encode([
        {
          "attribute": pill.whenInDay[0].attribute,
          "time": pill.whenInDay[0].time,
          "count": pill.whenInDay[0].count,
          "food": pill.whenInDay[0].when
        },
        {
          "attribute": pill.whenInDay[0].attribute,
          "time": pill.whenInDay[1].time,
          "count": pill.whenInDay[0].count,
          "food": pill.whenInDay[0].when
        },
        {
          "attribute": pill.whenInDay[0].attribute,
          "time": pill.whenInDay[2].time,
          "count": pill.whenInDay[0].count,
          "food": pill.whenInDay[0].when
        }
      ]),
      "family_members": json.encode(familyMembers.toList()),
    };
    // manager.showNotificationDaily(medicineId, _name, _dose, hour, minute);
    // var body = json.encode(data);
    print('data..rxpost...$userId $map');
    var time1 = Time(16, 57, 0);
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success...rxpost posted....$userId');
      print(response.body);
      var parsed = json.decode('${response.body}');
      String rxID = parsed[0]['rx_id'].toString();
      print('Pill when in day length:${pill.whenInDay.length}');
      // pill.whenInDay.forEach(
      //   (element) {
      //     if (element.time.toString().trim() != '') {
      //       WidgetsFlutterBinding.ensureInitialized();
      //       scheduleNotifications(pill, rxID, translateTime(element.time));
      //     }
      //   },
      // );
      // WidgetsFlutterBinding.ensureInitialized();
      // // Firebase.initializeApp();
      // FlutterBackgroundService.initialize(onStart);
      // FlutterBackground.initialize();

      // scheduleMessage(8618178237, DateTime.parse('2021-07-05 19:15:00'));
      // pill.familyMembers.forEach((familyMember) {
      //   pill.whenInDay.forEach((whenInDay) {});
      // });
      // scheduleMessage();
      //
      // var time1 = translateTime(pill.whenInDay[0].time);
      // if (time1 == Time(10, 18, 0)) {
      //   manager.showNotificationDaily(01, pill.rxTitle, pill.whenInDay[0].count,
      //       translateTime(pill.whenInDay[0].time));
      //   telephony.sendSms(
      //       to: '8618178237', message: 'Take your colpol 22 pill');
      // }
    } else {
      print('failed...${response.statusCode}');
    }
    setBusy(false);
  }

  // void ff() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final service = FlutterBackgroundService();
  //   service.onDataReceived.listen((event) {
  //     if (event["action"] == "setAsForeground") {
  //       service.setForegroundMode(true);
  //       return;
  //     }
  //     if (event["action"] == "setAsBackground") {
  //       service.setForegroundMode(false);
  //     }
  //     if (event["action"] == "stopService") {
  //       service.stopBackgroundService();
  //     }
  //   });
  //   // bring to foreground
  //   service.setForegroundMode(true);
  //
  //   // if (!(await service.isServiceRunning())) timer.cancel();
  //   var cron = Cron();
  //   cron.schedule(
  //       Schedule.parse(
  //           '*/5 */13 */12 * * *'),
  //           () async {
  //         print('Cron running');
  //         var telephony = Telephony.instance;
  //         int i = 0;
  //         // print('user phn: $userPhn');
  //         print('SMS sent to user ');
  //         final NotificationManager notificationManager = NotificationManager();
  //         notificationManager.initNotifications();
  //         notificationManager.showNotification(
  //           99,
  //           'Time to take your ',
  //           'Take 2 pills',
  //         );
  //         telephony.sendSms(
  //             to: '8618178237', message: 'Time to take your  Take 6 pills');
  //         cron.close();
  //       });
  //   // var telephony = Telephony.instance;
  //   // telephony.sendSms(
  //   //     to: '8884499678',
  //   //     message:
  //   //     'Time to take your  pills');
  //   // });
  // }

  doubleDigit(int num) {
    if (num == 0) {
      return '00';
    } else {
      return '$num';
    }
  }
  scheduleNotifications(Pill pill, rxID, DateTime day) {
    final NotificationManager notificationManager = NotificationManager();

    var cron = Cron();
    Duration duration = day.difference(DateTime.now());
    if (duration.inSeconds > 1 &&
        !(day.minute == 0 || day.hour == 0 || day.month == 0)) {
      if (day.minute == 0 || day.hour == 0 || day.month == 0) {
        print('Failure');
      }
      cron.schedule(
          Schedule.parse(
              '*/5 */${day.minute} */${day.hour} */${day.day} */${day.month} *'),
          () async {
        print('Cron running');
        var telephony = Telephony.instance;
        int i = 0;
        print('user phn: $userPhn');
        print('SMS sent to user ');
        print('awesome scheduled');
        notificationManager.initNotifications();
        notificationManager.showNotification(
          int.parse(rxID),
          'Time to take your ${pill.rxTitle}',
          'Take ${pill.whenInDay[0].count} pills',
        );
        Smsker.sendSms(
                message:
                    'Time to take your ${pill.rxTitle} Take ${pill.whenInDay[0].count} pills',
                phone: '$userPhn')
            .catchError((onError) {
          print(onError);
        });
        print('sms sent to user $userId ');
        // telephony.sendSms(
        //     to: userPhn,
        //     message:
        //         'Time to take your ${pill.rxTitle} Take ${pill.whenInDay[0].count} pills');
        pill.familyMembers.forEach((member) {
          i++;
          print('Member Count: $i');
          print('SMS sent to ${member.mobile}');
          Smsker.sendSms(
              phone: '${member.mobile}',
              message:
                  'Time to take your ${pill.rxTitle} Take ${pill.whenInDay[0].count} pills');
        });
        cron.close();
        var url = '${server.serverurl}add_rx_history';
        print('fuiooo');
        var data = {
          "secretpass": "ADMIN",
          "secretkey": "ADMIN",
          "rx_id": rxID,
          "track_date": pill.startDate,
          "track_time": pill.timeData,
          "status": 'Completed',
          // "gender": famGender.toString(),
        };
        // var body = json.encode(data);
        print('data notiii..$data');
        var response = await http.post(Uri.parse(url), body: data);
        if (response.statusCode == 200) {
          print('success noti data ... posted');
          print(response.body);
          var parsed = json.decode('${response.body}');
          // scheduleMessage(famPhone.text);
          var trackId = parsed[0]['track_id'];
          print('track id $trackId');
          // sp.setInt('MemberID', trackId);
        } else {
          print('failed noti post..${response.statusCode}');
        }
      }
      );
    }
    //
    // final NotificationManager notificationManager = NotificationManager();
    // notificationManager.initNotifications();
    // notificationManager.showNotificationDaily(
    //     int.parse(rxID),
    //     'Time to take your ${pill.rxTitle}',
    //     'Take ${pill.whenInDay[0].count} pills',
    //     translateTime(pill.whenInDay[0].time));
  }
  //-------Add Family members post function-----
  familyPost(context, Pill pill, FamilyMember familyMember) async {
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    var url = '${server.serverurl}add_member';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId,
      "member_name": familyMember.membername,
      "mobile_no": familyMember.memberPhone,
      "message": familyMember.memberMsg,
      "gender": familyMember.memberGender,
    };
    // var body = json.encode(data);
    print('data family..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success fam members... posted');
      print(response.body);
      var parsed = json.decode('${response.body}');
      // scheduleMessage(famPhone.text);
      var memberId = parsed[0]['member_id'];
      var status = parsed[0]['status'];
      String respCode = parsed[0]['response_code'].toString();
      if (respCode == "000") {
        showAlertDialogFamFailure(context, status);
      } else {
        showAlertDialogFamSucess(context, pill: pill);
      }
      print('member id $memberId');
      sp.setInt('MemberID', memberId);
      // familyList();
    } else {
      print('failed fam members...${response.statusCode}');
    }
  }

  //------Family List get function----
  familyList() async {
    setBusy(true);
    notifyListeners();

    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    Uri url = Uri.parse(
        "${server.serverurl}members_list?secretkey=ADMIN&secretpass=ADMIN&user_id=$userId");

    var response = await http.get(url);
    data = jsonDecode(response.body)[0]["Data"];

    print("Data famlist:....$data");
    // return data;
    data = jsonDecode(response.body)[0]['Data'];
    membersList.clear();
    for (int i = 0; i < data.length; i++) {
      membersList.add(FamilyMember());
      membersList.last.memberid = data[i]['member_id'];
      membersList.last.membername = data[i]['member_name'];
      membersList.last.memberPhone = data[i]['mobile_no'];
      membersList.last.memberGender = data[i]['gender'];
      membersList.last.memberMsg = data[i]['message'];
    }
    setBusy(false);
  }

  //-----EditFamily members---
  editFamily(context, name, mobileNo, int index) async {
    var url = '${server.serverurl}edit_member';

    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "member_id": membersList[index].memberid,
      "member_name": name,
      "mobile_no": mobileNo,
      "message": famMsg.text.toString(),
      "gender": membersList[index].memberGender,
    };
    // var body = json.encode(data);
    print('data family update..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success fam members... edited');
      print(response.body);

      // var parsed = json.decode('${response.body}');
      // var memberId = parsed['member_id'];
      // print('member id $memberId');
      Navigator.pop(context);
      notifyListeners();
      familyList();
    } else {
      print('failed edit fam members...${response.statusCode}');
    }
  }

  //----DeleteFamily members----
  deleteFamily(int index) async {
    sp = await SharedPreferences.getInstance();
    memberId = sp.getInt('MemberID').toString();
    var url = '${server.serverurl}delete_member';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "member_id": membersList[index].memberid,
      // "member_name": famMember.text,
      // "mobile_no": famPhone.text.toString(),
      // "message": famMsg.text.toString(),
      // "gender": famGender.toString(),
    };
    // var body = json.encode(data);
    print('data family..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success fam members... deleted');
      print(response.body);
      // var parsed = json.decode('${response.body}');
      familyList();
    } else {
      print('failed fam members...${response.statusCode}');
    }
  }

  //------Rx list get function------
  rxList(String pageType) async {
    setBusy(true);
    onGoingPillList.clear();
    expiredPillList.clear();
    expiringList.clear();
    pillList.clear();
    selectedPillList.clear();
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    Uri url = Uri.parse(
        "${server.serverurl}rx_list?secretkey=ADMIN&secretpass=ADMIN&user_id=$userId");
    var response = await http.get(url);
    data = jsonDecode(response.body)[0]['Data'];
    print('rxxxxx$userId');
    pillList.clear();
    for (int i = 0; i < data.length; i++) {
      pillList.add(Pill());
      pillList.last.rxId = data[i]['rx_id'];
      pillList.last.rxTitle = data[i]['rx_title'];
      pillList.last.type = data[i]['type'];
      pillList.last.totalTablets = data[i]['total_tablets'];
      pillList.last.startDate = data[i]['start_date'];
      pillList.last.endDate = data[i]['end_date'];
      pillList.last.rxStatus = data[i]['rx_status'];
      pillList.last.timeData = '';
      //pillList.last.familyMembers= List <FamilyList>.empty(growable: true);
      //familyMembers=[];
      for (int j = 0; j < data[i]['family_members'].length; j++) {
        pillList.last.familyMembers.add(FamilyList());
        pillList.last.familyMembers.last.name =
            data[i]['family_members'][j]['name'];
        pillList.last.familyMembers.last.mobile =
            data[i]['family_members'][j]['mobile'];
      }
      for (int j = 0; j < data[i]['when_in_day'].length; j++) {
        pillList.last.timeData =
            pillList.last.timeData + data[i]['when_in_day'][j]['time'];
        if (j < (data[i]['when_in_day'].length - 1)) {
          pillList.last.timeData = pillList.last.timeData + ' - ';
        }
        pillList.last.whenInDay.add(WhenInDay());
        pillList.last.whenInDay.last.attribute =
            data[i]['when_in_day'][j]['attribute'];
        pillList.last.whenInDay.last.count = data[i]['when_in_day'][j]['count'];
        pillList.last.whenInDay.last.time = data[i]['when_in_day'][j]['time'];
        pillList.last.whenInDay.last.when = data[i]['when_in_day'][j]['when'];
      }
    }
    List<String> scheduledIDs = [];
    scheduledIDs = sp.getStringList('scheduledIDs');
    // print(scheduledIDs);
    List<DateTime> days = [];

    // for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    //   days.add(startDate.add(Duration(days: i)));
    // }

    if (scheduledIDs == null) {
      scheduledIDs = [];
      pillList.forEach((pill) {
        for (int i = 0;
            i <=
                DateTime.parse(pill.endDate)
                    .difference(DateTime.parse(pill.startDate))
                    .inDays;
            i++) {
          DateTime day = DateTime.parse(pill.startDate).add(Duration(days: i));
          Duration duration = DateTime.now().difference(day);
          if (duration.inDays > -1) {
            days.add(day);
          }
        }
        days.forEach((day) {
          pill.whenInDay.forEach((whenDay) {
            if (whenDay.time.trim() != '')
              scheduleNotifications(
                  pill,
                  pill.rxId,
                  DateTime(
                      day.year,
                      day.month,
                      day.day,
                      translateTime(whenDay.time).hour,
                      translateTime(whenDay.time).minute,
                      5));
          });
        });
        scheduledIDs.add(pill.rxId.toString());
      });
      sp.setStringList('scheduledIDs', scheduledIDs);
    } else {
      pillList.forEach((pill) {
        bool exists = false;
        scheduledIDs.forEach((rxId) {
          if (int.parse(rxId) == int.parse(pill.rxId)) {
            exists = true;
          }
        });
        if (!exists) {
          for (int i = 0;
              i <=
                  DateTime.parse(pill.endDate)
                      .difference(DateTime.parse(pill.startDate))
                      .inDays;
              i++) {
            days.add(DateTime.parse(pill.startDate).add(Duration(days: i)));
          }
          days.forEach((day) {
            pill.whenInDay.forEach((whenDay) {
              if (whenDay.time.trim() != '')
                // AwesomeNotifications().initialize(
                //   // set the icon to null if you want to use the default app icon
                //     'resource://drawable/res_app_icon',
                //     [
                //       NotificationChannel(
                //           channelKey: 'basic_channel',
                //           channelName: 'Basic notifications',
                //           channelDescription: 'Notification channel for basic tests',
                //           defaultColor: Color(0xFF9D50DD),
                //           ledColor: Colors.white
                //       )
                //     ]
                // );
                scheduleNotifications(
                    pill,
                    pill.rxId,
                    DateTime(
                        day.year,
                        day.month,
                        day.day,
                        translateTime(whenDay.time).hour,
                        translateTime(whenDay.time).minute,
                        5));
            });
          });
          scheduledIDs.add(pill.rxId.toString());
        }
      });
    }
    // if(){}
    for (int k = 0; k < pillList.length; k++) {
      switch (pillList[k].rxStatus) {
        case 'Ongoing':
          onGoingPillList.add(pillList[k]);
          break;
        case '1 day remaining.':
          expiringList.add(pillList[k]);
          break;
        case 'Expired':
          expiredPillList.add(pillList[k]);
          break;
      }
    }

    print("Data rxlist:....$data");
    updatePillListPageType(pageType);
    setBusy(false);
    //return data;
  }

  rxHistory(selectedDate) async {
    setBusy(true);
    notifyListeners();
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    // selectedDate = sp.getString('selectedDate');
    Uri url = Uri.parse(
        "${server.serverurl}rx_history_list?secretkey=ADMIN&secretpass=ADMIN&user_id=$userId&track_date=$selectedDate");
    var response = await http.get(url);
    print(url);
    data = jsonDecode(response.body)[0]["Data"];
    print("Data rxhistory:....$data");
    // return data;
    data = jsonDecode(response.body)[0]['Data'];
    historyList.clear();
    for (int i = 0; i < data.length; i++) {
      historyList.add(RxHistory());
      historyList.last.track_time = data[i]['track_time'];
      historyList.last.trackId = data[i]['track_id'];
      historyList.last.rx_name = data[i]['rx_name'];
      print(historyList.last.rx_name);
      historyList.last.type = data[i]['type'];
      historyList.last.status = data[i]['status'];
      historyList.last.rx_name = data[i]['rx_name'];
      for (int j = 0; j < data[i]['when_in_day'].length; j++) {
        historyList.last.hiswhenInDay.add(HisWhenInDay());
        historyList.last.hiswhenInDay.last.count =
            data[i]['when_in_day'][j]['count'];
        // pillList.last.familyMembers.last.mobile =
        // data[i]['family_members'][j]['mobile'];
      }
    }
    setBusy(false);
    notifyListeners();
  }

  updateHistory(trackId, status, selectedDate) async {
    sp = await SharedPreferences.getInstance();
    memberId = sp.getInt('MemberID').toString();
    var url = '${server.serverurl}update_rx_history';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "track_id": trackId,
      "status": status,
    };
    // var body = json.encode(data);
    print('data family..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success fam members... edited');
      print(response.body);
      // var parsed = json.decode('${response.body}');
      // var memberId = parsed['member_id'];
      // print('member id $memberId');
      // Navigator.pop(context);
      rxHistory(selectedDate);
      notifyListeners();
    } else {
      print('failed edit fam members...${response.statusCode}');
    }
  }

  updatePillListPageType(String pageType) {
    //selectedPillList.clear();
    switch (pageType) {
      case 'onGoing':
        selectedPillList = onGoingPillList;
        pillStatus = 'onGoing';
        //notifyListeners();
        break;
      case 'expiringSoon':
        selectedPillList = expiringList;
        pillStatus = 'Expiring Soon';
        //notifyListeners();
        break;
      case 'expired':
        selectedPillList = expiredPillList;
        pillStatus = 'Expired';
        //notifyListeners();
        break;
    }
    notifyListeners();
  }

  //-----Edit Rx details-----
  editRx(Pill pill, context) async {
    var familyMembers = [];
    pill.familyMembers.forEach((member) {
      familyMembers.add({"name": member.name, "value": '${member.mobile}'});
    });
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    var url = '${server.serverurl}edit_rx_details';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId,
      // medForm.toString(),
      "rx_id": pill.rxId,
      "type": pill.type,
      "rx_title": pill.rxTitle,
      "total_tablets": pill.totalTablets,
      "start_date": pill.startDate,
      "end_date": pill.endDate,
      "when_in_day": json.encode([
        {
          "attribute": day,
          "time": pill.whenInDay[0].time,
          "count": pill.whenInDay[0].count,
          "food": pill.whenInDay[0].when
        },
        {
          "attribute": day,
          "time": pill.whenInDay[1].time,
          "count": pill.whenInDay[0].count,
          "food": pill.whenInDay[0].when
        },
        {
          "attribute": day,
          "time": pill.whenInDay[2].time,
          "count": pill.whenInDay[0].count,
          "food": pill.whenInDay[0].when
        }
      ]),
      "family_members": json.encode(familyMembers.toList()),
    };
    // var body = json.encode(data);
    print('data..rxpost...$userId $data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success...rxpost updated....$userId');
      print(response.body);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      print('failed...${response.statusCode}');
    }
  }

  //-----Delete Rx details
  deleteRx(String rxId) async {
    setBusy(true);
    pillList.clear();
    // sp = await SharedPreferences.getInstance();
    // memberId = sp.getInt('MemberID').toString();
    var url = '${server.serverurl}delete_rx';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "rx_id": rxId,
      // "member_name": famMember.text,
      // "mobile_no": famPhone.text.toString(),
      // "message": famMsg.text.toString(),
      // "gender": famGender.toString(),
    };
    // var body = json.encode(data);
    print('data ..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success rx ... deleted');
      print(response.body);
      // var parsed = json.decode('${response.body}');
      rxList('onGoing');
    } else {
      print('failed rx delete...${response.statusCode}');
    }
    setBusy(false);
  }

  //----view specific Rx details----
  viewRxDetails() async {}

  // dii()async{
  //   String encodedImagePath = base64Encode(await userImage.path.readAsBytes());
  //   final resp = await http.post(
  //     Uri.parse('https://cr.digindiapaytech.in/admin_assets/images/users')
  //     ,
  //     body: {
  //       'photo':  encodedImagePath,
  //     },
  //   );
  //   final responseJson = resp.body;
  //   print(responseJson);
  //   print(encodedImagePath);
  // }
  //----editProfile----
  updateProfile(context, EditProfile profile) async {
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    profile.userID = int.parse(userId);
    var url = '${server.serverurl}update_profile';
    // print('imagee....${userImage.path}');
    // var pickedFile = File(userImage.path);
    // final baseImage = base64Encode(pickedFile.readAsBytesSync());
    // print('baseimage is..$baseImage');
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.files.add(await http.MultipartFile.fromPath('picture', file.path));
    // var res = await request.send();
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId.toString(),
      "first_name": profile.name.toString(),
      "last_name": profile.lastname.toString(),
      "mobile_no": profile.mobileNo.toString(),
      "email": profile.email.toString(),
      "age": profile.age.toString(),
      "city": profile.city.toString(),
      "gender": profile.gender.toString(),
      "password": profile.password.toString(),
      "photo": '',
    };
    // var pickedImage = File(userImage.path);
    // var baseImage = base64Encode(pickedImage.readAsBytes())`;
    //
    // Future getImageFromCamera() async {
    //   final pickedFile = await picker.getImage(source: ImageSource.camera);
    //   setState(() {
    //     _image = File(pickedFile.path);
    //     type = _image.path.split('.').last;
    //     base64Image = base64Encode(_image.readAsBytesSync());
    //   });
    // }

    // var stream = new http.ByteStream(DelegatingStream.typed(userImage.openRead()));
    // print('image...$userImage');
    // var length = await userImage.length;
    // print('image...$userImage');.le
    // _valuesPost() async {
    //   var url =
    //   Uri.parse(AppConstant.base_url + "manage/api/medical_records/add");
    //   var map = new Map<String, dynamic>();
    //   map['X-Api-Key'] = AppConstant.API_Key;
    //   map['category'] = category;
    //   map['user_id'] = AppConstant.userId;
    //   final response = await http.post(url, body: map);
    //   print(response.statusCode);
    //   if (response.statusCode == 200) {
    //     final jsonData = jsonDecode(response.body);
    //     print('Success ${jsonData}');
    //     _fileUpload(jsonData['id']);
    //     setState(() {
    //       docId=jsonData['id'];
    //     });
    //   } else {
    //     print('Failed');
    //   }
    // }
    //
    // _fileUpload(var responseId) async {
    //   var url = Uri.parse(AppConstant.base_url + "api/medical_records.php");
    //   var map = new Map<String, dynamic>();
    //   map['key'] = AppConstant.API_Key;
    //   map['id'] = responseId.toString();
    //   map['type'] = type;
    //   map['file'] = base64Image;
    //   map['file_name']=pathCont.text;
    //   print('yeahhh $map');
    //   final response = await http.post(url, body: map);
    //   print('yeahhh $map');
    //   print(response.statusCode);
    //   if (response.statusCode == 200) {
    //     final jsonBody = json.decode(response.body);
    //     print('Posted $jsonBody');
    //     jsonBody['success']=='true'?
    //     getData():Center(child: CircularProgressIndicator(strokeWidth: 2,));
    //     setState(() {
    //       base64Image = null;
    //       print('Base 64 $base64Image');
    //     });
    //   } else if (response.statusCode == 400) {
    //     print('Not Posted ${response.statusCode}');
    //   }
    // }

    //
    // var request = new http.MultipartRequest("POST", uri);
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(userImage.path));
    // //contentType: new MediaType('image', 'png'));
    //
    // request.files.add(multipartFile);
    // var resp = await request.send();
    // print(resp.statusCode);
    // resp.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });

    // var body = json.encode(data);
    print('data family..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('successfully updated members... posted');
      print(response.body);
      // var  data1 ={
      //    'photo': baseImage
      //  };
      //  var uri1 = Uri.parse('https://cr.digindiapaytech.in/admin_assets/images/users');
      //  var respo = await http.post(uri1, body: (data1));
      //  print('success image${respo.body}');
      viewProfile();
      notifyListeners();
      showAlertDialogSucessEditProfile(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
      // var parsed = json.decode('${response.body}');
    } else {
      print('failed to update members...${response.statusCode}');
    }
  }

  //----deleteProfile-----
  viewProfile() async {
    setBusy(true);
    notifyListeners();
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    Uri url = Uri.parse(
        "${server.serverurl}view_profile?secretkey=ADMIN&secretpass=ADMIN&user_id=$userId");
    var response = await http.get(url);
    // var dat = jsonDecode(response.body)[0]['Data'];
    // print('dataaa${response.body}');
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);
      editProfile.name = parsed[0]["first_name"];
      editProfile.lastname = parsed[0]["last_name"];
      editProfile.mobileNo = int.parse(parsed[0]['mobile_no']);
      editProfile.age = int.parse(parsed[0]['age']);
      // editProfile.gender = parsed[0]['gender'];
      editProfile.email = parsed[0]['email'];
      editProfile.city = parsed[0]['city'];
      editProfile.dob = parsed[0]['dob'];
      editProfile.password = parsed[0]['password'];
    } else {
      print(response.statusCode);
    }
    setBusy(false);

    // if (response.statusCode == 200) {
    //   print('success fam members... posted');
    //   print(response.body);
    //   var parsed = json.decode('${response.body}');
    //   // var memberId = parsed['member_id'];
    //   // print('member id $memberId');
    // } else {
    //   print('failed fam members...${response.statusCode}');
    // }
  }

  //----- Extract Text function------
  extractText() {
    Container(
      // height: 170,
      child: TextField(
          maxLines: null,
          controller: _extractText == null ? medName : _extractText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff343333),
            // fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          ),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          )),
    );
  }

// addNewList({text}) {
//   medList.add(Medicine());
//   addNewMedicine(medList.length-1,nameText: text??'');
//   notifyListeners();
// }
//   addNewMedicine(index,{nameText,descriptionText})async{
//   medList[index].rxName.add(TextEditingController(text: nameText??''));
//   medList[index].description.add(TextEditingController());
//   }
// removeMedicine(index) {
//   print(index);
//   medList.removeAt(index);
//   notifyListeners();
// }
  showAlertDialogFamSucess(BuildContext context, {Pill pill}) {
    // set up the buttons
    // Widget cancelButton = FlatButton(
    //   // shape: ShapeBorder.lerp(, 6, t),
    //   // color: Colors.redAccent,
    //   child: Text(
    //     "OK",
    //     style: TextStyle(color: Colors.black, fontSize: 20),
    //   ),
    //   onPressed: () {
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => MainPage()));
    //   },
    // );

    // Widget submitButton = FlatButton(
    //   child: Text("No", style: TextStyle(color: Colors.red, fontSize: 20),),
    //   onPressed: () {
    //
    //     // viewModel.setReminderPost();
    //     viewModel.getTitle();
    //     // getImage(imageSource);
    //     Navigator.pop(context);
    //     _showMessage();
    //
    //
    //   },
    // );

    // set up the AlertDialog
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Success',
      desc: 'Family member added successfully..!',
      btnOkOnPress: () {
        Navigator.pop(context);
        Navigator.pop(context);
        familyList();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SelectFamily(pill: pill)));
      },
      btnOkText: 'Okay',
      // btnOkIcon: Icons.app_registration_rounded,
    )..show();

    // show the dialog
  }

  showAlertDialogSucessEditProfile(BuildContext context, {Pill pill}) {
    // Widget cancelButton = FlatButton(
    //   child: Text(
    //     "Try Again",
    //     style: TextStyle(color: Colors.green, fontSize: 20),
    //   ),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // );

    Widget submitButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
      onPressed: () {
        // viewModel.setReminderPost();
        // getImage(imageSource);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => SignUp(pill:pill),
        //   ),
        // );
        //---log out of app----
        // _showMessage();
      },
    );

    // set up the AlertDialog
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Success',
      desc: 'Edited Successfully..',
      btnOkOnPress: () {},
      // btnOkText: 'Okay',
      // btnOkIcon: Icons.app_registration_rounded,
    )..show();
    // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
  }
}

class Medicine {
  List<TextEditingController> rxName = [];
// List<TextEditingController> description = [];

}

showAlertDialogFamFailure(BuildContext context, status, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //
  //   },
  // );

  // Widget submitButton = FlatButton(
  //   child: Text(
  //     "SignUp",
  //     style: TextStyle(color: Colors.red, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     // viewModel.setReminderPost();
  //     // getImage(imageSource);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => SignUp(pill:pill),
  //       ),
  //     );
  //     //---log out of app----
  //     // _showMessage();
  //   },
  // );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text(
      "Invalid login credentials..!!!",
      style: TextStyle(color: Colors.red),
    ),
    // actions: [
    //   submitButton,
    //   cancelButton
    // ],
  );
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Alert',
    desc: status,
    // btnCancelIcon: Icons.login,
    btnOkOnPress: () {
      Navigator.of(context).pop();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => SignIn(pill: pill),
      //   ),
      // );
    },
    btnOkText: 'Okay',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}

showAlertDialogSignInInvalid(BuildContext context, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //
  //   },
  // );

  // Widget submitButton = FlatButton(
  //   child: Text(
  //     "SignUp",
  //     style: TextStyle(color: Colors.red, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     // viewModel.setReminderPost();
  //     // getImage(imageSource);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => SignUp(pill:pill),
  //       ),
  //     );
  //     //---log out of app----
  //     // _showMessage();
  //   },
  // );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text(
      "Invalid login credentials..!!!",
      style: TextStyle(color: Colors.red),
    ),
    // actions: [
    //   submitButton,
    //   cancelButton
    // ],
  );
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Alert',
    desc: 'Invalid Login Credentials...!',
    btnCancelOnPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignUp(pill: pill),
        ),
      );
    },
    btnCancelText: 'SignUp',
    // btnCancelIcon: Icons.login,
    btnOkOnPress: () {
      // Navigator.of(context).pop();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => SignIn(pill: pill),
      //   ),
      // );
    },
    btnOkText: 'Try Again',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}

showAlertDialogSignInEmail(BuildContext context, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //
  //   },
  // );

  // Widget submitButton = FlatButton(
  //   child: Text(
  //     "SignUp",
  //     style: TextStyle(color: Colors.red, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     // viewModel.setReminderPost();
  //     // getImage(imageSource);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => SignUp(pill:pill),
  //       ),
  //     );
  //     //---log out of app----
  //     // _showMessage();
  //   },
  // );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text(
      "Invalid login credentials..!!!",
      style: TextStyle(color: Colors.red),
    ),
    // actions: [
    //   submitButton,
    //   cancelButton
    // ],
  );
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Alert',
    desc: 'Email Already Exists..!',
    // btnCancelOnPress: () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => SignIn(pill:pill),
    //     ),
    //   );
    // },
    // btnCancelText: 'SignUp',
    // btnCancelIcon: Icons.login,
    btnOkOnPress: () {
      // Navigator.pop(context);
    },
    btnOkText: 'Okay',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}

showAlertDialogSignInMobile(BuildContext context, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //
  //   },
  // );

  // Widget submitButton = FlatButton(
  //   child: Text(
  //     "SignUp",
  //     style: TextStyle(color: Colors.red, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     // viewModel.setReminderPost();
  //     // getImage(imageSource);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => SignUp(pill:pill),
  //       ),
  //     );
  //     //---log out of app----
  //     // _showMessage();
  //   },
  // );

  // set up the AlertDialog
  // AlertDialog alert = AlertDialog(
  //   title: Text("AlertDialog"),
  //   content: Text(
  //     "Invalid login credentials..!!!",
  //     style: TextStyle(color: Colors.red),
  //   ),
  //   // actions: [
  //   //   submitButton,
  //   //   cancelButton
  //   // ],
  // );
  AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Alert',
      desc: 'Mobile Number Already Exists...!',
      btnOkText: 'Okay',
      btnOkOnPress: () {})
    ..show();
}

// showAlertDialogSucessSignUp(BuildContext context, {Pill pill}) {
//   // set up the AlertDialog
//   AwesomeDialog(
//     context: context,
//     dialogType: DialogType.SUCCES,
//
//     animType: AnimType.BOTTOMSLIDE,
//     tittle: 'Success',
//     desc: 'User created Successfully..',
//     btnOkOnPress: () {
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => SignIn(pill: pill)));
//     },
//     btnOkText: 'Okay',);
//     // btnOkIcon: Icon
// }
showAlertDialogSucessSignUp(BuildContext context, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //   },
  // );

  Widget submitButton = FlatButton(
    child: Text(
      "Ok",
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
    onPressed: () {
      // viewModel.setReminderPost();
      // getImage(imageSource);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => SignUp(pill:pill),
      //   ),
      // );
      //---log out of app----
      // _showMessage();
    },
  );

  // set up the AlertDialog
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Success',
    desc: 'User Created.....',
    btnOkOnPress: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn(pill: pill)));
    },
    btnOkText: 'Okay',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}

showAlertDialogSucessSignIn(BuildContext context, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //   },
  // );

  Widget submitButton = FlatButton(
    child: Text(
      "Ok",
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
    onPressed: () {
      // viewModel.setReminderPost();
      // getImage(imageSource);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => SignUp(pill:pill),
      //   ),
      // );
      //---log out of app----
      // _showMessage();
    },
  );

  // set up the AlertDialog
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Success',
    desc: 'Login Successfull..',
    btnOkOnPress: () {},
    // btnOkText: 'Okay',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}

// void _submit(NotificationManager manager) async {
//   if (_formKey.currentState.validate()) {
//     // form is validated
//     _formKey.currentState.save();
//     print(_name);
//     print(_dose);
//     //show the time picker dialog
//     showTimePicker(
//       initialTime: TimeOfDay.now(),
//       context: context,
//     ).then((selectedTime) async {
//       int hour = selectedTime.hour;
//       int minute = selectedTime.minute;
//       print(selectedTime);
//       // insert into database
//       var medicineId = await widget._database.insertMedicine(
//           MedicinesTableData(
//               name: _name,
//               dose: _dose,
//               image: 'assets/images/' + _icons[_selectedIndex]));
//       // sehdule the notification
//       manager.showNotificationDaily(medicineId, _name, _dose, hour, minute);
//       // The medicine Id and Notitfaciton Id are the same
//       print('New Med id' + medicineId.toString());
//       // go back
//       Navigator.pop(context, medicineId);
//     });
//   }
// }
showAlertDialogSucessEditProfile(BuildContext context, {Pill pill}) {
  // Widget cancelButton = FlatButton(
  //   child: Text(
  //     "Try Again",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
  //   },
  // );

  Widget submitButton = FlatButton(
    child: Text(
      "Ok",
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
    onPressed: () {
      // viewModel.setReminderPost();
      // getImage(imageSource);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => SignUp(pill:pill),
      //   ),
      // );
      //---log out of app----
      // _showMessage();
    },
  );

  // set up the AlertDialog
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Success',
    desc: 'Edited Successfully..',
    btnOkOnPress: () {},
    // btnOkText: 'Okay',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}
