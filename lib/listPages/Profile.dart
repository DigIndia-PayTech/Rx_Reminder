import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/FamilyMembers/AddFamily.dart';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/addManual.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/landingPage/landingPage.dart';
import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:Medicine_Remainder/listPages/editProfile.dart';
import 'package:Medicine_Remainder/listPages/pillList.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatefulWidget {
  String extractText;

  Profile({
    this.extractText,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  // TextEditingController medNameController = TextEditingController();

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
      onModelReady: (viewModel) => viewModel.viewProfile(),
      builder: (context, viewModel, child) {
        return Scaffold(
          key: scaffoldState,
          backgroundColor: Color(0xff2c98f0),
          appBar: AppBar(
            backgroundColor: Color(0xff2c98f0),
            // toolbarHeight: 70,
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
              'Account',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: viewModel.isBusy
              ? Center(child: CircularProgressIndicator(color: Colors.white,),)
              :Stack(children: [
             Container(
                    height: 108,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: new BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              'assets/images/wife.png')),
                                      color: Color(0xfffafafa),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(viewModel.editProfile.name??'User Name',
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: Color(0xffffffff),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.408,
                                            ))),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 5, 0, 0),
                                        child: Text(
                                            '${viewModel.editProfile.gender??'gender'}, ${viewModel.editProfile.age??'Age'}',
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              color: Color(0xffffffff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.408,
                                            ))),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 5, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    editprofile(
                                                  editProfile:
                                                      viewModel.editProfile,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Edit Details",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: 'Oxygen',
                                                color: Color(0xffffffff),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.408,
                                              )),
                                        )),
                                  ],
                                ),
                              ],
                            ))
                        //
                      ],
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 100),
              padding: EdgeInsets.only(top: 30),
              // width: 360,
              // height: 155,
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),

              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Medicines",
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                color: Color(0xff9c9b9f),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.408,
                              ))),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyPills()));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: AssetImage('assets/images/ptab.png',),
                                  //   fit: BoxFit.contain
                                  // ),
                                  color: Color(0xffe8f1fe),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset('assets/images/ptab.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  child: Text("My Pills",
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -0.408,
                                      )),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                    child: Text("Activity ,pauses ,edit",
                                        style: TextStyle(
                                          fontFamily: 'Oxygen',
                                          color: Color(0xff9c9b9f),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.408,
                                        )))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Account",
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                color: Color(0xff9c9b9f),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.408,
                              ))),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddFamily()));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: AssetImage('assets/images/proFam.png', ),
                                  //
                                  // fit: BoxFit.contain),
                                  color: Color(0xffe0f7f9),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/proFam.png',
                                height: 2,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  child: Text("family Members",
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -0.408,
                                      )),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                    child: Text("Add ,Remove ,Remind",
                                        style: TextStyle(
                                          fontFamily: 'Oxygen',
                                          color: Color(0xff9c9b9f),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: -0.408,
                                        )))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            height: 40,
                            width: 40,
                            decoration: new BoxDecoration(
                                // image: DecorationImage(
                                //   image: AssetImage('assets/images/pol.png'),
                                //   fit: BoxFit.contain
                                // ),
                                color: Color(0xfff2e5fc),
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              'assets/images/pol.png',
                              height: 10,
                              width: 10,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Text("Privacy policy",
                                    style: TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Color(0xff000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.408,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      InkWell(
                        onTap: () async{

                          showAlertDialogConfirm(context, viewModel);
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              height: 40,
                              width: 40,
                              decoration: new BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: AssetImage('assets/images/log.png'),
                                  //     fit: BoxFit.contain
                                  // ),
                                  color: Color(0xfffee7e3),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/log.png',
                                height: 20,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  child: Text("Log Out",
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -0.408,
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
showAlertDialogLogout(BuildContext context,AddManuallyViewModel viewModel,{Pill pill}) {

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
    desc: 'Logged Out',
    btnOkOnPress: () {

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
showAlertDialogConfirm(BuildContext context,AddManuallyViewModel viewModel,{Pill pill}) {

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
    dialogType: DialogType.WARNING,
    animType: AnimType.BOTTOMSLIDE,
    tittle: 'Confirm',
    desc: 'Are you sure..?',
    btnCancelOnPress: () {
      Navigator.pop(context);
    },
    btnCancelText: 'Cancel',
    btnCancelIcon: Icons.cancel,
    btnOkOnPress: () async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
      sp.setBool('OnBoarding', true);
      showAlertDialogLogout(context,viewModel);
      await Future<String>.delayed(const Duration(seconds: 2));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    },
    btnOkText: 'Yes',
    btnOkIcon: Icons.arrow_forward_outlined,
  )..show();
  // show the dialog
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}