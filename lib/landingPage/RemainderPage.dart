import 'dart:convert';
import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/FamilyMembers/AddFamily.dart';
import 'package:Medicine_Remainder/FamilyMembers/selectFamily.dart';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/addManual.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class RemainderPage extends StatefulWidget {
  Pill pill;

  RemainderPage({this.pill});

  @override
  _RemainderPageState createState() => _RemainderPageState();
}

class _RemainderPageState extends State<RemainderPage> {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  final scaffoldState = GlobalKey<ScaffoldState>();
  String _hour, _minute, _time;
  String _setTime1, _setTime2, _setTime3, _setDate1, _setDate2;

  void _showMessage() {
    scaffoldState.currentState.showBottomSheet(
          (context) =>
          Container(
            height: 462,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color(0xfffafafa)),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 134,
                    height: 4,
                    decoration: new BoxDecoration(
                        color: Color(0xff343434),
                        borderRadius: BorderRadius.circular(100))),
                Container(
                  margin: EdgeInsets.fromLTRB(100, 50, 100, 0),
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  // height: 50,

                  child: Image.asset('assets/images/addtab.png'),
                ),

                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("Medicine Added \n   Successfully",
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          color: Color(0xff343434),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ))),

                Spacer(),
                // Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Color(0xff2c98f0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        child: Text("Ok",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xffffffff),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    ),
                  ),
                )
                // Spacer(),
              ],
            ),
          ),
    );
  }

  bool mrng = false;
  bool noon = false;
  bool night = false;
  bool bfood = false;
  bool afood = false;
  String dateTime;

  List<String> list = [
    '1/2',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  acquireData(AddManuallyViewModel viewModel) {
    widget.pill.whenInDay[0].time = viewModel.timeController1.text;
    widget.pill.whenInDay[1].time = viewModel.timeController2.text;
    widget.pill.whenInDay[2].time = viewModel.timeController3.text;
    widget.pill.whenInDay[0].count = viewModel.chosenvalue;
    widget.pill.whenInDay[1].count = viewModel.chosenvalue;
    widget.pill.whenInDay[2].count = viewModel.chosenvalue;
    widget.pill.whenInDay[0].when = viewModel.when;
    widget.pill.whenInDay[1].when = viewModel.when;
    widget.pill.whenInDay[2].when = viewModel.when;
    widget.pill.whenInDay[0].attribute = viewModel.day;
    widget.pill.whenInDay[1].attribute = viewModel.day;
    widget.pill.whenInDay[2].attribute = viewModel.day;
    widget.pill.startDate =
        viewModel.getDate(viewModel.dateController1.text.toString());
    widget.pill.endDate =
        viewModel.getDate(viewModel.dateController2.text.toString());
  }

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectDate1(BuildContext context,
      AddManuallyViewModel viewModel) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        viewModel.dateController1.text = DateFormat("MM/dd/yyyy").format(selectedDate);
      });
  }
  Future<Null> _selectDate2(BuildContext context,
      AddManuallyViewModel viewModel) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        viewModel.dateController2.text = DateFormat("MM/dd/yyyy").format(selectedDate);
      });
  }

  String confirmText,
      cancelText,
      helptext2 = 'Afternoon Timing';
  String helptext1 = 'Morning Timing';
  String helptext3 = 'Night Timing';

  Future<Null> _selectTime1(BuildContext context,
      AddManuallyViewModel viewModel) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helptext1,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;

        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        viewModel.timeController1.text = _time;

        viewModel.timeController1.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        viewModel.count++;
      });
  }

  Future<Null> _selectTime2(BuildContext context,
      AddManuallyViewModel viewModel) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        cancelText: cancelText,
        confirmText: confirmText,
        initialTime: selectedTime,
        helpText: helptext2);
    if (picked != null)
      setState(() {
        selectedTime = picked;

        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        viewModel.timeController2.text = _time;

        viewModel.timeController2.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        viewModel.count++;
      });
  }

  Future<Null> _selectTime3(BuildContext context,
      AddManuallyViewModel viewModel) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        cancelText: cancelText,
        confirmText: confirmText,
        initialTime: selectedTime,
        helpText: helptext3);
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        viewModel.timeController3.text = _time;

        viewModel.timeController3.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        viewModel.count++;
      });
  }

  // var count_in_day = count*chosenvalue;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
      viewModelBuilder: () => AddManuallyViewModel(),
      disposeViewModel: false,
      onModelReady: (viewModel) {
        viewModel.sharedPreferences();
        widget.pill.whenInDay.add(WhenInDay());
        widget.pill.whenInDay.add(WhenInDay());
        widget.pill.whenInDay.add(WhenInDay());
        viewModel.timeController1.text = widget.pill.whenInDay[0].time;
        viewModel.timeController2.text = widget.pill.whenInDay[1].time;
        viewModel.timeController3.text = widget.pill.whenInDay[2].time;
        viewModel.chosenvalue = widget.pill.whenInDay[0].count;
        viewModel.when = widget.pill.whenInDay[0].when;
        viewModel.day = widget.pill.whenInDay[0].attribute;
        viewModel.dateController1.text =
            viewModel.reverseGetDate(widget.pill.startDate);
        viewModel.dateController2.text =
            viewModel.reverseGetDate(widget.pill.endDate);
        //viewModel.getUser();
        viewModel.rxname = widget.pill.rxTitle;
        viewModel.qty = widget.pill.totalTablets;
        viewModel.rxtype = widget.pill.type;
      },
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              key: scaffoldState,
              backgroundColor: Color(0xff2c98f0),
              appBar: AppBar(
                toolbarHeight: 70,
                backgroundColor: Color(0xff2c98f0),
                leading: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddManual()));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      size: 40,
                    )),
                elevation: 0.0,
                title: Text(
                  'Remainder',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Color(0xfffafafa),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 110,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Text("Select Time",
                                    style: TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Color(0xff4b5567),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.408,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectTime1(context, viewModel);
                                    mrng = !mrng;
                                    viewModel.day = 'Morning';
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black12),
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: TextFormField(
                                      enabled: false,
                                      onSaved: (String val) {
                                        _setTime1 = val;
                                      },
                                      maxLines: 1,
                                      controller: viewModel.timeController1,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: Icon(
                                            Icons.access_time_outlined,
                                          ),
                                          // suffixIconConstraints: ,
                                          hintText: '   Morning ',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: Color(0xff9c9b9f),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectTime2(context, viewModel);
                                    noon = !noon;
                                    viewModel.day = 'Afternoon';
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black12),
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: TextFormField(
                                      enabled: false,
                                      onSaved: (String val) {
                                        _setTime2 = val;
                                      },
                                      maxLines: 1,
                                      controller: viewModel.timeController2,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: Icon(
                                            Icons.access_time_outlined,
                                          ),
                                          // suffixIconConstraints: ,
                                          hintText: '  Afternoon ',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: Color(0xff9c9b9f),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _selectTime3(context, viewModel);
                                  night = !night;
                                  viewModel.day = 'Night';
                                },
                                child: Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.420,
                                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    enabled: false,
                                    onSaved: (String val) {
                                      _setTime3 = val;
                                    },
                                    maxLines: 1,
                                    controller: viewModel.timeController3,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.access_time_outlined,
                                        ),
                                        // suffixIconConstraints: ,
                                        hintText: '  \t\t Night  ',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Oxygen',
                                          color: Color(0xff9c9b9f),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                                // alignment: Alignment.topLeft,
                                child: Text("How you want to take your pill?",
                                    style: TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Color(0xff4b5567),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.408,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      bfood = !bfood;
                                      afood = false;
                                      viewModel.when = 'before food';
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                    height: 70,
                                    decoration: new BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black12),
                                        color: bfood
                                            ? Color(0xff2c98f0)
                                            : Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/bfre.png',
                                          height: 30,
                                          color: bfood
                                              ? Color(0xffffffff)
                                              : Colors.black,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(left: 1),
                                            child: Text("Before Food",
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  color: bfood
                                                      ? Color(0xffffffff)
                                                      : Color(0xff9c9b9f),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: -0.408,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      afood = !afood;
                                      bfood = false;
                                      viewModel.when = 'After food';
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                    height: 70,
                                    decoration: new BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black12),
                                        color: afood
                                            ? Color(0xff2c98f0)
                                            : Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/aftr.png',
                                          color: afood
                                              ? Color(0xffffffff)
                                              : Colors.black,
                                          height: 30,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(left: 1),
                                            child: Text("After Food",
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  color: afood
                                                      ? Color(0xffffffff)
                                                      : Color(0xff9c9b9f),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: -0.408,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 25, 10, 0),
                              alignment: Alignment.centerLeft,
                              child:
                              Text("How many pills  need to take at once ?",
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    color: Color(0xff4b5567),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.408,
                                  ))),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  height: 50,
                                  decoration: new BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonHideUnderline(
                                    // to hide the default underline of the dropdown button
                                    child: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 35,
                                        color: Colors.black,
                                      ),
                                      // icon color of the dropdown button
                                      items: list.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            '\t\t\t$value',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          viewModel.chosenvalue = value;
                                        });
                                      },
                                      value: viewModel.chosenvalue,

                                      // displaying the selected value
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 25, 10, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Starts From",
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        color: Color(0xff4b5567),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -0.408,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 25, 20, 0),
                                  // alignment: Alignment.topLeft,
                                  child: Text("Ends At",
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        color: Color(0xff4b5567),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -0.408,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectDate1(context, viewModel);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black12),
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: TextFormField(
                                      enabled: false,
                                      onSaved: (String val) {
                                        _setDate1 = val;
                                      },
                                      maxLines: 1,
                                      controller: viewModel.dateController1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.calendar_today_outlined,
                                        ),
                                        // suffixIconConstraints: ,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectDate2(context, viewModel);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black12),
                                        color: Color(0xffffffff),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: TextFormField(
                                      enabled: false,
                                      onSaved: (String val) {
                                        _setDate2 = val;
                                      },
                                      maxLines: 1,
                                      controller: viewModel.dateController2,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.calendar_today_outlined,
                                        ),
                                        // suffixIconConstraints: ,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: InkWell(
                              onTap: () {
                                if (viewModel.timeController1.text == ''&&
                                    viewModel.timeController2.text == '' &&
                                    viewModel.timeController3.text == '') {
                                  return Fluttertoast.showToast(
                                      msg: "Select Time to set Reminder",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                else if (viewModel.when == null) {
                                  return Fluttertoast.showToast(
                                      msg: "Select Before/After food",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                else if (viewModel.chosenvalue == null) {
                                  return Fluttertoast.showToast(
                                      msg: "Select No. of pills",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                else
                                if (viewModel.dateController1.text.toString() ==
                                    '' &&
                                    viewModel.dateController2.text.toString() ==
                                        '') {
                                  return Fluttertoast.showToast(
                                      msg: "Select Start Date and End Date",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }

                                // viewModel.^(?:[+0]9)?[0-9]{10}$(
                                //     context, widget.pill);
                                else {
                                  acquireData(viewModel);
                                  if (widget.pill.familyMembers.isNotEmpty) {
                                    viewModel.setReminderPost(widget.pill);
                                    _showMessage();
                                  } else
                                    showAlertDialog(context, viewModel);
                                }
                              },
                              child: Container(
                                width: 320,
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: Color(0xff2c98f0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text("Set Reminder",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xffffffff),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              )),
        );
      },
    );
  }

  showAlertDialog(BuildContext context, AddManuallyViewModel viewModel) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      // shape: ShapeBorder.lerp(, 6, t),
      // color: Colors.redAccent,
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.green, fontSize: 20),
      ),
      onPressed: () {},
    );

    Widget submitButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
      onPressed: () {},
    );

    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,

      animType: AnimType.BOTTOMSLIDE,
      title: 'Alert',
      desc: 'Do You want to remind your family members..?',
      btnCancelOnPress: () {
        viewModel.setReminderPost(widget.pill);
        // getImage(imageSource);
        // Navigator.pop(context);
        _showMessage();
      },
      btnCancelText: 'No',
      // btnCancelIcon: Icons.login,
      btnOkOnPress: () {
        // Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectFamily(pill: widget.pill)));
      },
      btnOkText: 'Yes',
      // btnOkIcon: Icons.app_registration_rounded,
    )
      ..show();

    // set up the AlertDialog
    // AlertDialog alert = AlertDialog(
    //
    //   title: Text("AlertDialog"),
    //   content: Text("Do you want to remind your Family members..??"),
    //   actions: [
    //     cancelButton,
    //     submitButton
    //   ],
    // );

    // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //
    //     return alert;
    //   },
    // );
  }
}
