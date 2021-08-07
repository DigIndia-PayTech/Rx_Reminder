import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/log_Pages/signIn.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';

class SignUp extends StatefulWidget {
  Pill pill;


  SignUp({this.pill});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool userpasswrd = false;

  bool userconf = false;

  bool last = false;
  var validText = '';

  // final bool isValid ;
  bool today = false;
  bool isvalid = false;

  String initialCountry = 'NG';
  // PhoneNumber number = PhoneNumber(isoCode: 'NG');
  var pp;

  @override
  void initState() {
    userpasswrd = false;
    userconf = false;
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
    double sWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => AddManuallyViewModel(),
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
                        height: 179,
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Signup",
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
                              child: Text("To continue further",
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
                            height: MediaQuery.of(context).size.height + 280,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 10, 5, 0),
                                        padding: EdgeInsets.all(5),
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
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
                                        margin:
                                            EdgeInsets.fromLTRB(5, 10, 5, 0),
                                        padding: EdgeInsets.all(5),
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
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
                                        margin:
                                            EdgeInsets.fromLTRB(5, 10, 20, 0),
                                        padding: EdgeInsets.all(5),
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
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
                                        margin:
                                            EdgeInsets.fromLTRB(40, 40, 0, 0),
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
                                        margin:
                                            EdgeInsets.fromLTRB(5, 40, 0, 0),
                                        width: 69,
                                        height: 1,
                                        decoration: new BoxDecoration(
                                            color: Color(0xff9c9b9f))),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("First Name",
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
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    controller: viewModel.username,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Last Name",
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
                                    keyboardType: TextInputType.name,
                                    maxLines: 1,
                                    controller: viewModel.lastname,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Phone",
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
                                  child: IntlPhoneField(
                                    autoValidate: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    // maxLength: 10,
                                    // maxLines: 1,
                                    controller: viewModel.phone,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: "",
                                    ),
                                    onChanged: (phn) {
                                      print(phn.completeNumber);
                                      // viewModel.phone.text = phn.completeNumber;
                                      print(viewModel.phone.text);
                                       pp = phn.completeNumber;
                                      print(pp);
                                      // viewModel.phone.text = pp;
                                    },
                                    onCountryChanged: (phn) {
                                      print('Country code changed to: ' + phn.countryCode);
                                    },
                                  ),

                                ),



                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("E-Mail",
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
                                  child: TextFormField(
                                    // validator: (value) {
                                    //   if (value.isEmpty ||
                                    //       !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    //           .hasMatch(value)) {
                                    //     return 'Enter a valid email!';
                                    //   }
                                    //   return null;
                                    // },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    maxLines: 1,
                                    controller: viewModel.email,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Age",
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
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    maxLength: 2,
                                    controller: viewModel.age,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none),
                                  ),
                                ),
                                // IntlPhoneField(
                                //   decoration: InputDecoration(
                                //     labelText: 'Phone Number',
                                //     border: OutlineInputBorder(
                                //       borderSide: BorderSide(),
                                //     ),
                                //   ),
                                //
                                // ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("City",
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
                                    keyboardType: TextInputType.streetAddress,
                                    maxLines: 1,
                                    controller: viewModel.city,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
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
                                    // maxLength: 6,
                                    textInputAction: TextInputAction.next,
                                    obscureText: !userpasswrd,
                                    maxLines: 1,
                                    controller: viewModel.password,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          userpasswrd
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            userpasswrd = !userpasswrd;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //     alignment: Alignment.centerRight,
                                //     margin: EdgeInsets.only(top:5),
                                //     width:MediaQuery.of(context).size.width,
                                //     child: Visibility(
                                //         visible:true,
                                //
                                //         child: Text('$validText', style: TextStyle(color: Colors.white),))
                                // ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Confirm Password",
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
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    validator: (validator) {
                                      if (validator.isEmpty) return 'Empty';
                                      if (validator != viewModel.password.text)
                                        return 'The passwords do not match';
                                      return null;
                                    },
                                    obscureText: !userconf,
                                    maxLines: 1,
                                    controller: viewModel.confPassword,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      errorStyle: TextStyle(
                                        height: 0,
                                      ),
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          userconf
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            userconf = !userconf;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                //   alignment: Alignment.centerLeft,
                                //   child: Text("Gender",
                                //       style: TextStyle(
                                //         fontFamily: 'Oxygen',
                                //         color: Color(0xff4b5567),
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.w700,
                                //         fontStyle: FontStyle.normal,
                                //         letterSpacing: -0.408,
                                //       )),
                                // ),
                                // Row(
                                //   children: [
                                //     Column(
                                //       children: [
                                //         InkWell(
                                //           onTap: () {
                                //             setState(() {
                                //               last = !last;
                                //               today = false;
                                //               viewModel.gender = "Male";
                                //             });
                                //           },
                                //           child: Container(
                                //             decoration: BoxDecoration(
                                //                 border: Border.all(
                                //                     color: Colors.black12),
                                //                 color: last
                                //                     ? Color(0xff2c98f0)
                                //                     : Color(0xffffffff),
                                //                 borderRadius:
                                //                     BorderRadius.circular(10)),
                                //             height: 50,
                                //             width: 50,
                                //             margin:
                                //                 EdgeInsets.fromLTRB(20, 10, 0, 0),
                                //             child: Icon(
                                //               Icons.male_outlined,
                                //               size: 35,
                                //             ),
                                //             // color: Colors.blue,
                                //           ),
                                //         ),
                                //         Container(
                                //             margin:
                                //                 EdgeInsets.fromLTRB(20, 5, 0, 0),
                                //             child: Text("Male",
                                //                 style: TextStyle(
                                //                   fontFamily: 'Oxygen',
                                //                   color: Color(0xff9c9b9f),
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w700,
                                //                   fontStyle: FontStyle.normal,
                                //                   letterSpacing: -0.408,
                                //                 ))),
                                //       ],
                                //     ),
                                //     Column(
                                //       children: [
                                //         InkWell(
                                //           onTap: () {
                                //             setState(() {
                                //               today = !today;
                                //               last = false;
                                //               viewModel.gender = "Female";
                                //             });
                                //           },
                                //           child: Container(
                                //             decoration: BoxDecoration(
                                //                 border: Border.all(
                                //                     color: Colors.black12),
                                //                 color: today
                                //                     ? Color(0xff2c98f0)
                                //                     : Color(0xffffffff),
                                //                 borderRadius:
                                //                     BorderRadius.circular(10)),
                                //             height: 50,
                                //             width: 50,
                                //             margin:
                                //                 EdgeInsets.fromLTRB(40, 10, 0, 0),
                                //             child: Icon(
                                //               Icons.female_outlined,
                                //               size: 35,
                                //             ),
                                //           ),
                                //         ),
                                //         Container(
                                //             margin:
                                //                 EdgeInsets.fromLTRB(40, 5, 0, 0),
                                //             child: Text("Female",
                                //                 style: TextStyle(
                                //                   fontFamily: 'Oxygen',
                                //                   color: Color(0xff9c9b9f),
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w700,
                                //                   fontStyle: FontStyle.normal,
                                //                   letterSpacing: -0.408,
                                //                 ))),
                                //       ],
                                //     )
                                //   ],
                                // ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: InkWell(
                                    onTap: () {
                                      viewModel.phone.text = pp;
                                      print(viewModel.phone.text);
                                      if (viewModel.username.text.toString() ==
                                          '') {
                                        showAlertDialogName(context, viewModel);
                                      } else if (viewModel.phone.text
                                              .toString() ==
                                          '') {
                                        showAlertDialogMob(context, viewModel);
                                      } else if (viewModel.email.text
                                              .toString() ==
                                          '') {
                                        showAlertDialogEmail(
                                            context, viewModel);
                                      } else if (viewModel.age.text
                                              .toString() ==
                                          '') {
                                        showAlertDialogAge(context, viewModel);
                                      } else if (viewModel.city.text
                                              .toString() ==
                                          '') {
                                        showAlertDialogCity(context, viewModel);
                                      } else if (viewModel.password.text
                                              .toString() ==
                                          '') {
                                        showAlertDialogPass(context, viewModel);
                                      } else if (viewModel
                                              .password.text.length<
                                          6) {
                                        return Fluttertoast.showToast(
                                            msg:
                                                "Password must contain atleast 6 characters",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                      // else if (viewModel.phone.text.length !=
                                      //     10) {
                                      //   return Fluttertoast.showToast(
                                      //       msg:
                                      //           "Mobile Number must be 10 digits",
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.CENTER,
                                      //       timeInSecForIosWeb: 2,
                                      //       backgroundColor: Colors.red,
                                      //       textColor: Colors.white,
                                      //       fontSize: 16.0);
                                      //
                                      //   // viewModel.^(?:[+0]9)?[0-9]{10}$(
                                      //   //     context, widget.pill);
                                      //   // _form.currentState.validate();
                                      // }
                                      else if (viewModel.confPassword.text != viewModel.password.text) {
                                        return Fluttertoast.showToast(
                                            msg:
                                            "Password and Confirm Password does not Match..!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                        // viewModel.^(?:[+0]9)?[0-9]{10}$(
                                        //     context, widget.pill);
                                        // _form.currentState.validate();
                                      }
                                      else {
                                        // final isValid = _formKey.currentState.validate();
                                        isvalid = EmailValidator.validate(
                                            viewModel.email.text);
                                        if (isvalid) {
                                          viewModel.signUpPost(
                                              context, widget.pill);
                                          //     context, widget.pill);
                                        } else {
                                          return Fluttertoast.showToast(
                                              msg: "Please Enter a valid Email",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                        // viewModel.signUpPost(
                                        //     context, widget.pill);
                                        // _form.currentState.validate();
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
                                        padding: EdgeInsets.all(12),
                                        alignment: Alignment.center,
                                        child: Text("SignUp",
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
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignIn(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            // margin: EdgeInsets.fromLTRB(
                                            //     70, 10, 0, 10),
                                            child: Text('Existing User?')),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          // padding: EdgeInsets.all(6),
                                          // alignment: Alignment.center,
                                          child: Text("SignIn",
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
                                SizedBox(
                                  height: 10,
                                )
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

showAlertDialogName(BuildContext context, AddManuallyViewModel viewModel) {
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
      "Name Empty..!!",
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

showAlertDialogMob(BuildContext context, AddManuallyViewModel viewModel) {
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
      "Mobile Empty..!!",
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

showAlertDialogEmail(BuildContext context, AddManuallyViewModel viewModel) {
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
      "E-mail Empty..!!!",
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

showAlertDialogAge(BuildContext context, AddManuallyViewModel viewModel) {
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
      "Age Empty..!!!",
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

showAlertDialogCity(BuildContext context, AddManuallyViewModel viewModel) {
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
      "City Empty..!!!",
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

showAlertDialogGender(BuildContext context, AddManuallyViewModel viewModel) {
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
      "Select Gender..!!!",
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

showAlertDialogPass(BuildContext context, AddManuallyViewModel viewModel) {
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
      "Please set password..!!",
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

showAlertDialogConfPass(BuildContext context, AddManuallyViewModel viewModel) {
  // set up the buttons

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
