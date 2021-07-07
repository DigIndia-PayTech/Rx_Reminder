import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:telephony/telephony.dart';

class AddManuallyViewModel extends BaseViewModel {
  var text;
  File croppedFile;
  bool siPassword = false;
  Server server = new Server();
  List<Pill> pillList = [];
  List<FamilyMember> membersList = [];
  List<RxHistory> historyList = [];

  //List<Pill> familyMembersList = [];
  List<Pill> selectedPillList = [];
  List<Pill> onGoingPillList = [];
  List<Pill> expiringList = [];
  List<Pill> expiredPillList = [];
  String pillStatus;

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
    print(time.hour);
    print(time.minute);
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

  TextEditingController editUsername = TextEditingController();
  TextEditingController editUserphone = TextEditingController();
  TextEditingController editUserage = TextEditingController();
  TextEditingController editUsercity = TextEditingController();
  TextEditingController editUserpassword = TextEditingController();
  TextEditingController editUseremail = TextEditingController();

  var editUsergender;

  TextEditingController famname = TextEditingController();
  TextEditingController famPhn = TextEditingController();
  TextEditingController fammsg = TextEditingController();
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
      "full_name": username.text,
      "": lastname.text,
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
        print('tyuii');
        showAlertDialogSucessSignUp(context, pill: pill);
        // Timer(),
        await Future<String>.delayed(const Duration(seconds: 2));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignIn(
                      pill: pill,
                    )));
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
          sp.setInt('UserID', int.parse(userId));

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
      pill.whenInDay.forEach((time) {
        if (time.toString().toString() != '') {
          scheduleNotifications(pill, rxID, translateTime(time.time));
        }
      });
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

  scheduleNotifications(Pill pill, rxID, Time time) {
    var cron = Cron();
    print(time);
    cron.schedule(Schedule.parse('*/5 */${time.minute} */${time.hour} * * *'),
        () async {
      print('Cron running');
      var telephony = Telephony.instance;
      pill.familyMembers.forEach((member) {
        print('SMS sent to ${member.mobile}');
        telephony.sendSms(
            to: member.mobile,
            message:
                'Time to take your ${pill.rxTitle} Take ${pill.whenInDay[0].count} pills');
      });
      final NotificationManager notificationManager = NotificationManager();
      notificationManager.initNotifications();
      notificationManager.showNotification(
        int.parse(rxID),
        'Time to take your ${pill.rxTitle}',
        'Take ${pill.whenInDay[0].count} pills',
      );
      var url = '${server.serverurl}add_rx_history';
      var data = {
        "secretpass": "ADMIN",
        "secretkey": "ADMIN",
        "rx_id": rxID,
        "track_date": pill.startDate,
        "track_time": pill.whenInDay[0].time,
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
      cron.close();
    });
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
  familyPost() async {
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    var url = '${server.serverurl}add_member';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId,
      "member_name": famMember.text,
      "mobile_no": famPhone.text.toString(),
      "message": famMsg.text.toString(),
      "gender": famGender.toString(),
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
  editFamily(context) async {
    sp = await SharedPreferences.getInstance();
    memberId = sp.getInt('MemberID').toString();
    var url = '${server.serverurl}edit_member';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "member_id": memberId,
      "member_name": famname.text,
      "mobile_no": famPhn.text.toString(),
      "message": famMsg.text.toString(),
      "gender": gen.toString(),
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
      Navigator.pop(context);
      notifyListeners();
      familyList();
    } else {
      print('failed edit fam members...${response.statusCode}');
    }
  }

  //----DeleteFamily members----
  deleteFamily() async {
    sp = await SharedPreferences.getInstance();
    memberId = sp.getInt('MemberID').toString();
    var url = '${server.serverurl}delete_member';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "member_id": memberId,
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
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    setBusy(true);
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

  rxHistory() async {
    setBusy(true);
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    Uri url = Uri.parse(
        "${server.serverurl}rx_history_list?secretkey=ADMIN&secretpass=ADMIN&user_id=$userId");
    var response = await http.get(url);
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
  }

  updateHistory(trackId, status) async {
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
      rxHistory();
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
  editRx() async {
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    var url = '${server.serverurl}edit_member';
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId,
      // medForm.toString(),
      "type": rxtype,
      "rx_title": rxname,
      "total_tablets": qty,
      "start_date": dateController1.text.toString(),
      "end_date": dateController2.text.toString(),
      "when_in_day": json.encode([
        {
          "attribute": day,
          "time": timeController1.text.toString(),
          "count": chosenvalue,
          "food": when
        },
        {
          "attribute": day,
          "time": timeController2.text.toString(),
          "count": chosenvalue,
          "food": when
        },
        {
          "attribute": day,
          "time": timeController3.text.toString(),
          "count": chosenvalue,
          "food": when
        }
      ]),
      "family_members": json.encode(
        [
          {"name": "divva", "value": '9089089070'},
          {"name": "yooo", "value": '9090909090'},
        ],
      ),
    };
    // var body = json.encode(data);
    print('data..rxpost...$userId $data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('success...rxpost posted....$userId');
      print(response.body);
    } else {
      print('failed...${response.statusCode}');
    }
  }

  //-----Delete Rx details
  deleteRx() async {}

  //----view specific Rx details----
  viewRxDetails() async {}

  //----editProfile----
  updateProfile() async {
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
    var url = '${server.serverurl}update_profile';
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.files.add(await http.MultipartFile.fromPath('picture', file.path));
    // var res = await request.send();
    var data = {
      "secretpass": "ADMIN",
      "secretkey": "ADMIN",
      "user_id": userId,
      "name": editUsername.text,
      "mobile_no": editUserphone.text.toString(),
      "email": editUseremail.text.toString(),
      "age": editUserage.text.toString(),
      "city": editUsercity.text.toString(),
      "gender": editUsergender.toString(),
      "password": editUserpassword.text.toString(),
      // "photo": ,
    };
    // var body = json.encode(data);
    print('data family..$data');
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print('successfully updated members... posted');
      print(response.body);
      // var parsed = json.decode('${response.body}');

    } else {
      print('failed to update members...${response.statusCode}');
    }
  }

  //----deleteProfile-----
  viewProfile() async {
    setBusy(true);
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
      editProfile.name = parsed[0]["name"];
      editProfile.mobile_no = parsed[0]['mobile_no'];
      editProfile.age = parsed[0]['age'];
      editProfile.gender = parsed[0]['gender'];
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
//   notifyListeners();
//   }
// removeMedicine(index) {
//   print(index);
//   medList.removeAt(index);
//   notifyListeners();
// }
}

class Medicine {
  List<TextEditingController> rxName = [];
// List<TextEditingController> description = [];

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
    tittle: 'Alert',
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
      Navigator.pop(context);
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
    tittle: 'Alert',
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
      Navigator.pop(context);
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
    tittle: 'Alert',
    desc: 'Mobile Number Already Exists...!',
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
      Navigator.pop(context);
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

showAlertDialogSucessSignUp(BuildContext context, {Pill pill}) {
  Widget cancelButton = FlatButton(
    child: Text(
      "Try Again",
      style: TextStyle(color: Colors.green, fontSize: 20),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

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
    tittle: 'Success',
    desc: 'User created Successfully..',
    btnOkOnPress: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddManual(pill: pill)));
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
  Widget cancelButton = FlatButton(
    child: Text(
      "Try Again",
      style: TextStyle(color: Colors.green, fontSize: 20),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

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
    tittle: 'Success',
    desc: 'Login Successfull..',
    btnOkOnPress: () {},
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
