
import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/Core/toastPage.dart';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/AddManuallyViewModel.dart';
import 'package:Medicine_Remainder/log_Pages/Signup.dart';
import 'package:Medicine_Remainder/log_Pages/signIn.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class EditManual extends StatefulWidget {
  String extractText;
  int index;
  Pill pill;
  EditManual({
    this.index,
    this.extractText,
    this.pill
  });
  // const EditManual({Key? key}) : super(key: key);
  @override
  _EditManualState createState() => _EditManualState();
}

class _EditManualState extends State<EditManual> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  String medForm;
  Pill pill;
  TextEditingController dateController1 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();
  TextEditingController timeController1 = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  TextEditingController timeController3 = TextEditingController();
  var count;
  var chosenvalue;
  String when;
  // setText(viewModel) async{
  //
  //   viewModel.rxTitle = medNameController.text.toString();
  //   SharedPreferences.setMockInitialValues({});
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   // Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(
  //   //         builder: (context) => EditManually()));
  //   print('herrruuuuu');
  //   sp.setString('rxtitle', medNameController.text.toString());
  // }
  final scaffoldState = GlobalKey<ScaffoldState>();

  String _hour, _minute, _time;
  String _setTime1, _setTime2, _setTime3, _setDate1, _setDate2;

  String dateTime;

  List<String> list = [
    '1/2',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectDate1(BuildContext context,AddManuallyViewModel viewModel) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        viewModel.dateController1.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectDate2(BuildContext context,AddManuallyViewModel viewModel) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        viewModel.dateController2.text = DateFormat.yMd().format(selectedDate);
      });
  }



  String confirmText, cancelText, helptext2 = 'Afternoon Timing';
  String helptext1 = 'Morning Timing';
  String helptext3 = 'Night Timing';

  Future<Null> _selectTime1(BuildContext context, AddManuallyViewModel viewModel) async {
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

  Future<Null> _selectTime2(BuildContext context, AddManuallyViewModel viewModel) async {
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

  Future<Null> _selectTime3(BuildContext context, AddManuallyViewModel viewModel) async {
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

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    //double sHeight = MediaQuery.of(context).size.height;
   // double sWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => AddManuallyViewModel(),
      onModelReady: (viewModel) {

        pill=widget.pill??Pill();
        // medNameController.text=widget.extractText??pill.rxTitle;
        medNameController.text = pill.rxTitle;
        medForm= pill.type;
        qtyController.text = pill.totalTablets;
        timeController1.text = pill.whenInDay[0].time;
        timeController2.text = pill.whenInDay[1].time;
        timeController3.text = pill.whenInDay[2].time;
        when= pill.whenInDay[0].when;
        count=int.parse(pill.whenInDay[0].count);
        dateController1.text = pill.startDate;
        dateController2.text = pill.endDate;
        // qtyController.text=pill.totalTablets;
        // medNameController.text=widget.extractText??pill.rxTitle;
      },
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: scaffoldState,
            backgroundColor: Color(0xff2c98f0),
            appBar: AppBar(
              backgroundColor: Color(0xff2c98f0),
              toolbarHeight: 70,
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left_sharp,
                    size: 40,
                  )),
              elevation: 0.0,
              title: Text(
                'Edit Pill',
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
                  height: MediaQuery.of(context).size.height+200,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Text("Medicine Name",
                            style: TextStyle(
                              fontFamily: 'Oxygen',
                              color: Color(0xff4b5567),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.408,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          controller: medNameController,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Text("Medicine Form",
                            style: TextStyle(
                              fontFamily: 'Oxygen',
                              color: Color(0xff4b5567),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.408,
                            )),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  medForm = 'Capsule';
                                });
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: medForm == 'Capsule'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/pillList.png',
                                      height: 40,
                                      width: 40,
                                      color: medForm == 'Capsule'
                                          ? Color(0xffffffff)
                                          : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Capsule",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: medForm == 'Capsule'
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
                                  medForm = 'Tablet';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: medForm== 'Tablet'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/pilll.png',
                                      // fit: BoxFit.cover,
                                      height: 70,
                                      width: 30,
                                      color: medForm == 'Tablet'
                                          ? Color(0xffffffff)
                                          : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Tablet",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: medForm== 'Tablet'
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
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  medForm = 'Tonic';
                                });
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: medForm == 'Tonic'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/tonic.png',
                                      height: 40,
                                      width: 40,
                                      color: medForm == 'Tonic'
                                          ? Color(0xffffffff)
                                          : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Tonic   \t",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: medForm == 'Tonic'
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
                                  medForm = 'Drops';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: medForm == 'Drops'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/drops.png',
                                      height: 35,
                                      width: 35,
                                      color: medForm == 'Drops'
                                          ? Color(0xffffffff)
                                          : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Drops",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: medForm == 'Drops'
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
                        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        alignment: Alignment.centerLeft,
                        child: Text("Total number of capsules contains in the bottle:",
                            style: TextStyle(
                              fontFamily: 'Oxygen',
                              color: Color(0xff4b5567),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.408,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: qtyController,
                                decoration: InputDecoration(

                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Text("Nos",
                                style: TextStyle(
                                  fontFamily: 'Oxygen',
                                  color: Color(0xff9c9b9f),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.408,
                                ))
                          ],
                        ),

                      ),
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
                                _selectTime1(context, viewModel );
                                viewModel.day = 'Morning';
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  enabled: false,
                                  onSaved: (String val) {
                                    _setTime1 = val;
                                  },
                                  maxLines: 1,
                                  controller: timeController1,
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
                                _selectTime2(context,viewModel);

                                viewModel.day = 'Afternoon';
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  enabled: false,
                                  onSaved: (String val) {
                                    _setTime2 = val;
                                  },
                                  maxLines: 1,
                                  controller: timeController2,
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
                              _selectTime3(context,viewModel);

                              viewModel.day = 'Night';
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.420,
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
                                controller: timeController3,
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
                                  when = 'before food';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                height: 70,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: when == 'before food'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/bfre.png',
                                      height: 30,
                                      color: when == 'before food'
                                          ? Color(0xffffffff)
                                          : Colors.black,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Before Food",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: when == 'before food'
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

                                  when = 'After food';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                height: 70,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color:  when == 'After food'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/aftr.png',
                                      color:  when == 'After food'
                                          ? Color(0xffffffff)
                                          : Colors.black,
                                      height: 30,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("After Food",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color:  when == 'After food'
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
                          child: Text("How many pills  need to take at once ?",
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                color: Color(0xff4b5567),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.408,
                              ))),
                      Row(children: [
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
                                    count = value;
                                  });
                                },
                                value: count,//viewModel.chosenvalue,

                                // displaying the selected value
                              ),
                            ),
                          ),
                        ),],),
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
                                _selectDate1(context,viewModel);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  enabled: false,
                                  onSaved: (String val) {
                                    _setDate1 = val;
                                  },
                                  maxLines: 1,
                                  controller: dateController1,
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
                                    border: Border.all(color: Colors.black12),
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  enabled: false,
                                  onSaved: (String val) {
                                    _setDate2 = val;
                                  },
                                  maxLines: 1,
                                  controller: dateController2,
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
                          onTap: () async {
                            pill.rxTitle=medNameController.text;
                            pill.totalTablets=qtyController.text;
                            SharedPreferences sp =
                            await SharedPreferences.getInstance();
                            // int userID = sp.getInt('UserID');
                         if (medNameController.text.toString()== '') {
                              showToast('Enter Rx Title');
                            }
                            else if (qtyController.text.toString()== '') {
                              return Fluttertoast.showToast(
                                  msg:
                                  "Enter Quantity",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            else if (pill.type== null) {
                              return Fluttertoast.showToast(
                                  msg:
                                  "Select Pill type",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                            else

                            {
                              viewModel.editRx(pill,context);
                            }

                            // var route = new MaterialPageRoute(
                            //   builder: (BuildContext context) =>
                            //
                            //       RemainderPage(
                            //
                            //           // value: User(
                            //           //     medName: medNameController.text,
                            //           //     qty: qtyController.text,
                            //           //     medType: medForm.toString(),
                            //           //     // imageUrl: _imageURLController.text
                            //
                            //       // ),
                            //       ));
                            // Navigator.push(context, route);

                            // _showMessage();
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
                              child: Text("Edit Reminder",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

showAlertDialog(BuildContext context,AddManuallyViewModel viewModel,{Pill pill}) {




  // set up the AlertDialog

  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Alert',
    desc: 'You have not logged in...!',
    btnCancelOnPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(pill:pill),
        ),
      );
    },
    btnCancelText: 'SignIn',
    btnCancelColor: Colors.green,
    btnCancelIcon: Icons.login,
    btnOkOnPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignUp(pill:pill),
        ),
      );
    },
    btnOkText: 'SignUp',
    btnOkColor: Colors.blue,
    btnOkIcon: Icons.app_registration_rounded,
  )..show();



  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AwesomeDialog();
  //   },
  // );
}
