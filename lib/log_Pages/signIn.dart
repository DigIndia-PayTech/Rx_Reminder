
import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/log_Pages/Signup.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';

class SignIn extends StatefulWidget {
  Pill pill;
  SignIn({this.pill});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool last = false;
  bool today = false;
  bool isvalid = false;
  var selectedValue = 1;
  bool phnVisible = false;
  bool mailVisible = true;
  var pp;

  @override
  void initState() {
    // userpasswrd = false;
  }

// var sendData = {
//   "name": name1.toString(),
//   "phoneNo": mobile,
//   "email": email1.toString(),
//   "role": _role,
//   "password": passwod,
//   "password1": password1,
//   "page_access": acessdetails
// };
// var body = json.encode(sendData);
// print("my datta$body");
// var response = await http.post(url,
// headers: {'content-type': 'application/json'},
// body: body);
// if (response.statusCode == 200) {
// _saveDialog();
// print('successfully posted');
// // _displayDialog();
// print(response.body);
// } else {
// print('response error ${response.statusCode}');
// }
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => AddManuallyViewModel(),
        onModelReady: (viewModel){viewModel.sharedPreferences();},
        builder: (context, viewModel, child) {
          return Form(
            key: _form,
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  backgroundColor: Color(0xff2c98f0),
                  body: Stack(
                    children: [
                      Container(
                        height: 178,
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("SignIn",
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    color: Color(0xffffffff),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.408,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text("Welcome back",
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    color: Color(0xffffffff),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.408,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 178),
                        padding: EdgeInsets.only(top: 58),
                        // width: 360,
                        // height: 155,
                        decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(30),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(20, 10, 5, 0),
                                        padding: EdgeInsets.all(5),
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black12),
                                            color: Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                          'assets/images/google.png',
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                                        padding: EdgeInsets.all(5),
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black12),
                                            color: Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                          'assets/images/fb.png',
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 10, 20, 0),
                                        padding: EdgeInsets.all(5),
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black12),
                                            color: Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(40, 40, 0, 0),
                                        width: 69,
                                        height: 1,
                                        decoration: new BoxDecoration(
                                            color: Color(0xff9c9b9f))),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 40, 0, 0),
                                      child: Text("Or register with email",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: Color(0xff9c9b9f),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.408,
                                          )),
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(5, 40, 0, 0),
                                        width: 69,
                                        height: 1,
                                        decoration: new BoxDecoration(
                                            color: Color(0xff9c9b9f))),
                                  ],
                                ),
                                // Container(
                                //   margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                                //   alignment: Alignment.centerLeft,
                                //   child: Text("E-Mail/Mobile No.",
                                //       style: TextStyle(
                                //         fontFamily: 'Oxygen',
                                //         color: Color(0xff4b5567),
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.w700,
                                //         fontStyle: FontStyle.normal,
                                //         letterSpacing: -0.408,
                                //       )),
                                // ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 40, 0, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Radio(
                                          value: 1,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                              mailVisible= true;
                                              phnVisible = false;
                                              viewModel.email_mob.clear();
                                              // colr = true;
                                              // colr1 = false;
                                              // plans = false;
                                              // smeText = true;
                                            });
                                          },
                                          activeColor: Colors.blue,
                                        ),
                                      ),
                                      Text("E-Mail",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: Color(0xff4b5567),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.408,
                                          )),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Radio(
                                          value: 2,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                              phnVisible= true;
                                              mailVisible = false;
                                              viewModel.email_mob.clear();
                                              // colr = true;
                                              // colr1 = false;
                                              // plans = false;
                                              // smeText = true;
                                            });
                                          },
                                          activeColor: Colors.blue,
                                        ),
                                      ),
                                      Text("Mobile No.",
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: Color(0xff4b5567),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.408,
                                          )),

                                    ],
                                  ),

                                ),
                                Visibility(
                                  visible: mailVisible,
                                  child: Container(
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
                                      controller: viewModel.email_mob,
                                      decoration:
                                          InputDecoration(border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: phnVisible,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black12),
                                        color: Color(0xffffffff),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: IntlPhoneField(
                                      // initialCountryCode: '+91',
                                      autoValidate: false,
                                      textInputAction: TextInputAction.next,
                                      // maxLines: 1,
                                      controller: viewModel.email_mob,
                                      decoration:
                                      InputDecoration(border: InputBorder.none,
                                      counterText: ""),
                                      onChanged: (phn) {
                                        print(phn.completeNumber);
                                        // viewModel.phone.text = phn.completeNumber;
                                        // print(viewModel.phone.text);
                                        pp = phn.completeNumber;
                                        print(pp);// viewModel.phone.text = pp;
                                      },
                                      onCountryChanged: (phn) {
                                        print('Country code changed to: '+ phn.countryCode);
                                        var kk = phn.countryCode + viewModel.email_mob.text;
                                        print('kk$kk');
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Password",
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
                                    obscureText: !viewModel.siPassword,
                                    maxLines: 1,
                                    controller: viewModel.signinPass,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          viewModel.siPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            viewModel.siPassword =
                                                !viewModel.siPassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 5),
                                    width: MediaQuery.of(context).size.width * 23,
                                    child: Visibility(
                                        visible: viewModel.siPassword,
                                        child: Text(
                                          '${viewModel.validText}',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                // Container(
                                //     alignment: Alignment.centerRight,
                                //     margin: EdgeInsets.only(top:5),
                                //     width:MediaQuery.of(context).size.width,
                                //     child: Visibility(
                                //         visible:true,
                                //
                                //         child: Text('$validText', style: TextStyle(color: Colors.white),))

                                // Spacer(),
                                SizedBox(height: 40,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: InkWell(
                                    onTap: () {
                                      print('hhh');
                                      if (viewModel.email_mob.text.toString() == '') {
                                        showAlertDialogMob(context, viewModel);
                                      } else if (viewModel.signinPass.text.toString() ==
                                          '') {
                                        showAlertDialogPass(context, viewModel);
                                      }
                                      else {
                                        viewModel.email_mob.text = pp;
                                        print(viewModel.email_mob.text);
                                      // final isValid = _formKey.currentState.validate();
                                      // isvalid = EmailValidator.validate(viewModel.email.text);
                                      // if (isvalid) {
                                      // viewModel.signInPost(context,widget.pill);
                                      // //     context, widget.pill);
                                      // } else {
                                      // return Fluttertoast.showToast(
                                      // msg: "Please Enter a valid Email",
                                      // toastLength: Toast.LENGTH_SHORT,
                                      // gravity: ToastGravity.CENTER,
                                      // timeInSecForIosWeb: 2,
                                      // backgroundColor: Colors.red,
                                      // textColor: Colors.white,
                                      // fontSize: 16.0);

                                      // viewModel.signUpPost(
                                      //     context, widget.pill);
                                      // _form.currentState.validate();
                                      // }
                                        viewModel.signInPost(
                                              context, widget.pill);
                                        _form.currentState.validate();
                                      }

                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          color: Color(0xff2c98f0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Text("SignIn",
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => SignUp(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Container(
                                            // margin: EdgeInsets.fromLTRB(70, 10, 0, 10),
                                            child: Text('Not an User?')),
                                        SizedBox(width: 5,),
                                        Container(
                                          // padding: EdgeInsets.all(6),
                                          // alignment: Alignment.center,
                                          child: Text("SignUp",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.fromLTRB(
                            0, 32 + AppBar().preferredSize.height, 48.8, 0),
                        child: Container(
                          height: 141.3,
                          child: Image.asset('assets/images/phn.png'),
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }
}

showAlertDialogMob(BuildContext context, AddManuallyViewModel viewModel) {
  // set up the buttons
  // Widget cancelButton = FlatButton(
  //   // shape: ShapeBorder.lerp(, 6, t),
  //   // color: Colors.redAccent,
  //   child: Text(
  //     "Yes",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     // Navigator.push(context,
  //     //     MaterialPageRoute(builder: (context) => AddFamily()));
  //   },
  // );

  Widget submitButton = FlatButton(
    child: Text(
      "Ok",
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
    onPressed: () {
      //viewModel.setReminderPost(widget.pill);
      // getImage(imageSource);
      Navigator.pop(context);
      // _showMessage();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text(
      "E-mail/Mobile Empty..!!",
      style: TextStyle(color: Colors.red),
    ),
    actions: [ submitButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogPass(BuildContext context, AddManuallyViewModel viewModel) {
  // set up the buttons
  // Widget cancelButton = FlatButton(
  //   // shape: ShapeBorder.lerp(, 6, t),
  //   // color: Colors.redAccent,
  //   child: Text(
  //     "Yes",
  //     style: TextStyle(color: Colors.green, fontSize: 20),
  //   ),
  //   onPressed: () {
  //     // Navigator.push(context,
  //     //     MaterialPageRoute(builder: (context) => AddFamily()));
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
      Navigator.pop(context);
      // _showMessage();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text(
      "Password Empty..!!!",
      style: TextStyle(color: Colors.red),
    ),
    actions: [submitButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
