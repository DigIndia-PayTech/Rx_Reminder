
import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/RemainderPage.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/listPages/HomePage.dart';
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

class AddManual extends StatefulWidget {
  String extractText;
  Pill pill;
  AddManual({
    this.extractText,
    this.pill
  });
  // const AddManual({Key? key}) : super(key: key);
  @override
  _AddManualState createState() => _AddManualState();
}

class _AddManualState extends State<AddManual> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  String medForm;
  Pill pill;

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
      onModelReady: (viewModel) {
        pill=widget.pill??Pill();
        qtyController.text=pill.totalTablets;
        medNameController.text=widget.extractText??pill.rxTitle;
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
                                  pill.type = 'Capsule';
                                });
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: pill.type == 'Capsule'
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
                                      color: pill.type == 'Capsule'
                                          ? Color(0xffffffff)
                                          : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Capsule",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: pill.type == 'Capsule'
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
                                  pill.type = 'Tablet';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: pill.type == 'Tablet'
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
                                      color: pill.type == 'Tablet'
                                          ? Color(0xffffffff)
                                          : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Tablet",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: pill.type == 'Tablet'
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
                                  pill.type = 'Tonic';
                                });
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: pill.type == 'Tonic'
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
                                      color: pill.type == 'Tonic'
                                          ? Color(0xffffffff)
                                    : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Tonic   \t",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: pill.type == 'Tonic'
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
                                  pill.type = 'Drops';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                height: 50,
                                decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: pill.type == 'Drops'
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
                                      color: pill.type == 'Drops'
                                          ? Color(0xffffffff)
                                    : null,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Drops",
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: pill.type == 'Drops'
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
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: InkWell(
                          onTap: () async {
                            pill.rxTitle=medNameController.text;
                            pill.totalTablets=qtyController.text;
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            int userID = sp.getInt('UserID');
                            if (userID == null) {
                              showAlertDialog(context, viewModel,pill: pill);
                            } else if (medNameController.text.toString()== '') {
                              return Fluttertoast.showToast(
                                  msg:
                                  "Enter Rx Title",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RemainderPage(pill:pill),
                                ),
                              );
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
          ),
        );
      },
    );
  }
}

showAlertDialog(BuildContext context,AddManuallyViewModel viewModel,{Pill pill}) {
  Widget signUp = FlatButton(
    child: Text(
      "SignUp",
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
    onPressed: () {

    },
  );
  Widget signIn = FlatButton(
    child: Text(
      "SignIn",
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
    onPressed: () {

    },
  );


  // set up the AlertDialog

  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    tittle: 'Alert',
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
