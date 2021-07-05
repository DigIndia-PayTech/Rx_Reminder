
import 'package:Medicine_Remainder/FamilyMembers/AddFamily.dart';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class User {
  final String medName, qty, medType;

  const User({
    this.medName,
    this.qty,
    this.medType,
  });
}

User value;
class EditAddManual extends StatefulWidget {
  String extractText;

  EditAddManual({
    this.extractText,
  });

  // const EditAddManual({Key? key}) : super(key: key);

  @override
  _EditAddManualState createState() => _EditAddManualState();
}

class _EditAddManualState extends State<EditAddManual> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  String medForm;





  // setText(viewModel) async{
  //
  //   viewModel.rxTitle = medNameController.text.toString();
  //   SharedPreferences.setMockInitialValues({});
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   // Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(
  //   //         builder: (context) => AddManually()));
  //   print('herrruuuuu');
  //   sp.setString('rxtitle', medNameController.text.toString());
  // }


  final scaffoldState = GlobalKey<ScaffoldState>();

  bool capsule = false;
  bool tablet = false;
  bool tonic = false;
  bool drops = false;

  void _editMsg() {
    scaffoldState.currentState.showBottomSheet(
          (context) => Container(
        height: 462,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(150, 20, 0, 0),
                    child: new Text("Message",
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          color: Color(0xff4b5567),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.408,
                        ))),
                Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.fromLTRB(80, 20, 0, 0),
                    child: new Text("Edit",
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          color: Color(0xff4b5567),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.408,
                        )))
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 123,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,

                // maxLines: 1,
                // controller: viewModel.medicineName,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintMaxLines: 4,
                  hintStyle: TextStyle(
                    fontFamily: 'Oxygen',
                    color: Color(0xff9c9b9f),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  hintText:
                  " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit in pretium urna ullamcorper elit amet. Posuere massa risus tempus",
                ),
              ),
            ),

            Spacer(),
            // Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => RemainderPage()));
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
                    child: Text("Save",
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

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => AddManuallyViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(widget.extractText),
      builder: (context, viewModel, child) {
        return Scaffold(
          key: scaffoldState,
          backgroundColor: Color(0xff2c98f0),
          appBar: AppBar(
            backgroundColor: Color(0xff2c98f0),
            toolbarHeight: 70,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_sharp,
                  size: 40,
                )),
            elevation: 0.0,
            title: Text(
              'Add Pill',
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
                height: MediaQuery.of(context).size.height - 110,
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
                        maxLines: 1,
                        controller: medNameController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
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
                                capsule = !capsule;
                                tablet = false;
                                tonic = false;
                                drops = false;
                                medForm = 'Capsule';
                              });
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                              decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  color: capsule
                                      ? Color(0xff2c98f0)
                                      : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/matre.png',
                                    height: 40,
                                    width: 40,
                                    color: capsule
                                        ? Color(0xffffffff)
                                        : Color(0xff2c98f0),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text("Capsule",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: capsule
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
                                tablet = !tablet;
                                capsule = false;
                                tonic = false;
                                drops = false;
                                medForm = 'Tablet';
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                              height: 50,
                              decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  color: tablet
                                      ? Color(0xff2c98f0)
                                      : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/matre.png',
                                    height: 40,
                                    width: 40,
                                    color: tablet
                                        ? Color(0xffffffff)
                                        : Color(0xff2c98f0),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text("Tablet",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: tablet
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
                                capsule = false;
                                tablet = false;
                                tonic = !tonic;
                                drops = false;
                              });
                              medForm = 'Tonic';
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                              decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  color: tonic
                                      ? Color(0xff2c98f0)
                                      : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/matre.png',
                                    height: 40,
                                    width: 40,
                                    color: tonic
                                        ? Color(0xffffffff)
                                        : Color(0xff2c98f0),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text("Tonic   \t",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: tonic
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
                                tablet = false;
                                capsule = false;
                                tonic = false;
                                drops = !drops;
                                medForm = 'Drops';
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                              height: 50,
                              decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  color: drops
                                      ? Color(0xff2c98f0)
                                      : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/matre.png',
                                    height: 40,
                                    width: 40,
                                    color: drops
                                        ? Color(0xffffffff)
                                        : Color(0xff2c98f0),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text("Drops",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: drops
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
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      alignment: Alignment.centerLeft,
                      child: Text("Quantity",
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
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => EditRemainderPage(
                                  name: medNameController.text,
                                  qty: qtyController.text,
                                  medForm: medForm
                              ),
                            ),
                          );

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
                            child: Text("Add Pill",
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
        );
      },
    );
  }
}

class EditRemainderPage extends StatefulWidget {
  String name,qty,medForm;

  EditRemainderPage({this.name,this.qty,this.medForm}) ;
  @override
  _EditRemainderPageState createState() => _EditRemainderPageState();
}

class _EditRemainderPageState extends State<EditRemainderPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  String _hour, _minute, _time;
  String _setTime1, _setTime2, _setTime3, _setDate1, _setDate2;
  void _showMessage() {
    scaffoldState.currentState.showBottomSheet(
          (context) => Container(
        height: 462,
        width: MediaQuery.of(context).size.width,
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


  // var count_in_day = count*chosenvalue;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
      viewModelBuilder: () => AddManuallyViewModel(),
      disposeViewModel: false,
      onModelReady: (viewModel){
        viewModel.sharedPreferences();
        //viewModel.getUser();
        viewModel.rxname=widget.name;
        viewModel.qty=widget.qty;
        viewModel.rxtype=widget.medForm;
      },
      builder: (context, viewModel, child){
        return Scaffold(
            key: scaffoldState,
            backgroundColor: Color(0xff2c98f0),
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Color(0xff2c98f0),
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left_sharp,
                    size: 40,
                  )),
              elevation: 0.0,
              title: Text(
                '${widget.name} ${widget.qty} ${widget.medForm}',//'Remainder',
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
                    height: MediaQuery.of(context).size.height - 110,
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
                                  _selectTime1(context, viewModel );
                                  mrng = !mrng;
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
                                  _selectTime2(context,viewModel);
                                  noon = !noon;
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
                                _selectTime3(context,viewModel);
                                night = !night;
                                viewModel.day = 'Night';
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
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
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                                      border: Border.all(color: Colors.black12),
                                      color: bfood
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
                                      border: Border.all(color: Colors.black12),
                                      color: afood
                                          ? Color(0xff2c98f0)
                                          : Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10)),
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
                            margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
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
                                      viewModel.chosenvalue = value;


                                    });
                                  },
                                  value: viewModel.chosenvalue,

                                  // displaying the selected value
                                ),
                              ),
                            ),
                          ),],),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
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
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
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
                                      border: Border.all(color: Colors.black12),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10)),
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
                              showAlertDialog(context, viewModel);

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
            ));

      },);
  }
  showAlertDialog(BuildContext context,AddManuallyViewModel viewModel) {
    // set up the buttons
    Widget cancelButton = FlatButton(

      // shape: ShapeBorder.lerp(, 6, t),
      // color: Colors.redAccent,
      child: Text("Yes", style: TextStyle(color: Colors.green, fontSize: 20),),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddFamily()));
      },
    );

    Widget submitButton = FlatButton(
      child: Text("No", style: TextStyle(color: Colors.red, fontSize: 20),),
      onPressed: () {
        //viewModel.setReminderPost(widget.pill);
        // getImage(imageSource);
        Navigator.pop(context);
        _showMessage();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("AlertDialog"),
      content: Text("Do you want to remind your Family members..??"),
      actions: [
        cancelButton,
        submitButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return alert;
      },
    );
  }

}

