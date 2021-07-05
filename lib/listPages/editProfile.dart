import 'dart:io';

import 'package:Medicine_Remainder/Core/Models/profileModel.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/listPages/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:stacked/stacked.dart';

class editprofile extends StatefulWidget {
  EditProfile editProfile;
  editprofile({this.editProfile});

  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  bool userpasswrd = false;
  bool last = false;
  var validText = '';
  bool today = false;
  Color _colorContainer = Color(0xffffffff);
  Color _colorContainer1 = Color(0xffffffff);

  var _image;

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.red,
          size: 20,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    userpasswrd = false;
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => AddManuallyViewModel(),
      // onModelReady: (viewModel) => viewModel.initialise(widget.extractText),

      builder: (context, viewModel, child) {
        viewModel.editUsername.text = widget.editProfile.name;
        viewModel.editUserphone.text = widget.editProfile.mobile_no;
        viewModel.editUseremail.text = widget.editProfile.email;
        viewModel.editUsergender = widget.editProfile.gender;
        viewModel.editUsercity.text = widget.editProfile.city;
        viewModel.editUserpassword.text = widget.editProfile.password;
        viewModel.editUserage.text = widget.editProfile.age;
        return Scaffold(
          key: _form,
          backgroundColor: Color(0xff2c98f0),
          appBar: AppBar(
            backgroundColor: Color(0xff2c98f0),
            toolbarHeight: 70,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_sharp,
                  size: 40,
                )),
            elevation: 0.0,
            title: Text(
              'Edit Profile',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 30),
            // width: 360,
            // height: 155,
            decoration: BoxDecoration(
              color: Color(0xfffafafa),
              borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height + 160,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color(0xfffE5E5E5),
                                    shape: BoxShape.circle,

                                  ),
                                  child: ClipRRect(
                                     borderRadius: BorderRadius.circular(70),
                                    child: _image != null
                                        ? Image.file(
                                            File(
                                              _image.path,
                                            ),
                                      fit: BoxFit.cover,

                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 140,
                                          ),
                                  ))
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 25.0,
                                    child: InkWell(
                                      onTap: () {
                                        getImage(
                                          ImgSource.Both,
                                        );
                                      },
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ]),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Container(
                    //         margin: EdgeInsets.fromLTRB(40, 40, 0, 0),
                    //         width: 69,
                    //         height: 1,
                    //         decoration: new BoxDecoration(
                    //             color: Color(0xff9c9b9f))),
                    //
                    //     Container(
                    //         margin: EdgeInsets.fromLTRB(5, 40, 0, 0),
                    //         width: 69,
                    //         height: 1,
                    //         decoration: new BoxDecoration(
                    //             color: Color(0xff9c9b9f))),
                    //   ],
                    // ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text("Name",
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
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        controller: viewModel.editUsername,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
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
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        maxLines: 1,
                        controller: viewModel.editUserphone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
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
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: viewModel.editUseremail,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
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
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: viewModel.editUserage,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
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
                        keyboardType: TextInputType.streetAddress,
                        maxLines: 1,
                        controller: viewModel.editUsercity,
                        decoration: InputDecoration(border: InputBorder.none),
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
                        obscureText: !userpasswrd,
                        maxLines: 1,
                        controller: viewModel.editUserpassword,
                        decoration: InputDecoration(
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
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text("Gender",
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
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  viewModel.editUsergender= "Male";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color:  viewModel.editUsergender== 'Male'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                child: Icon(
                                  Icons.male_outlined,
                                  size: 35,
                                ),
                                // color: Colors.blue,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                child: Text("Male",
                                    style: TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Color(0xff9c9b9f),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.408,
                                    ))),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  viewModel.editUsergender = "Female";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: viewModel.editUsergender== 'Female'
                                        ? Color(0xff2c98f0)
                                        : Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.fromLTRB(40, 10, 0, 0),
                                child: Icon(
                                  Icons.female_outlined,
                                  size: 35,
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                                child: Text("Female",
                                    style: TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Color(0xff9c9b9f),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.408,
                                    ))),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: InkWell(
                        onTap: () {
                          if (viewModel.editUsername.text.toString() ==
                              '') {
                            showAlertDialogName(context, viewModel);
                          } else if (viewModel.editUserphone.text
                              .toString() ==
                              '') {
                            showAlertDialogMob(context, viewModel);
                          } else if (viewModel.editUseremail.text
                              .toString() ==
                              '') {
                            showAlertDialogEmail(context, viewModel);
                          } else if (viewModel.editUserage.text.toString() ==
                              '') {
                            showAlertDialogAge(context, viewModel);
                          } else if (viewModel.editUsergender == '') {
                            showAlertDialogGender(context, viewModel);
                          } else if (viewModel.editUsercity.text.toString() ==
                              '') {
                            showAlertDialogCity(context, viewModel);
                          } else if (viewModel.editUserpassword.text
                              .toString() ==
                              '') {
                            showAlertDialogPass(context, viewModel);
                          } else {
                          viewModel.updateProfile();
                          // _form.currentState.validate();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                          }
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
                            child: Text("Update",
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
      "Phone Number Empty..!!",
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
      "Password Empty..!!",
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

// showAlertDialogConfPass(BuildContext context, AddManuallyViewModel viewModel) {
//   // set up the buttons
//
//   Widget submitButton = FlatButton(
//     child: Text(
//       "Ok",
//       style: TextStyle(color: Colors.red, fontSize: 20),
//     ),
//     onPressed: () {
//       // viewModel.setReminderPost();
//       // getImage(imageSource);
//       Navigator.pop(context);
//       // _showMessage();
//     },
//   );
//
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("AlertDialog"),
//     content: Text(
//       "Password Empty..!!!",
//       style: TextStyle(color: Colors.red),
//     ),
//     actions: [submitButton],
//   );
//
//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }