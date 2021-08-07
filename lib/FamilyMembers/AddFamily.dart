
import 'package:Medicine_Remainder/Core/Models/familyModel.dart';
import 'package:Medicine_Remainder/Core/Models/pillListModel.dart';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/listPages/Profile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';

class AddFamily extends StatefulWidget {
  Pill pill;

  AddFamily({this.pill});

  @override
  _AddFamilyState createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  void _showMessage() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
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
              );
            }));
  }

  bool male = false;
  bool female = false;
  Pill pill;

  final scaffoldState = GlobalKey<ScaffoldState>();

  void addMember(AddManuallyViewModel viewModel, BuildContext context) {
    FamilyMember familyMember = FamilyMember();
    TextEditingController famMember = TextEditingController();
    TextEditingController famPhone = TextEditingController();
    var mob;
    var gen;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 20),
                      alignment: Alignment.center,
                      child: Text("Add Member",
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
                      margin: EdgeInsets.fromLTRB(22, 40, 0, 0),
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
                      margin: EdgeInsets.fromLTRB(22, 10, 22, 0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        controller: famMember,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(22, 10, 0, 0),
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
                      margin: EdgeInsets.fromLTRB(22, 10, 22, 0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10)),
                      child: IntlPhoneField(
                        textInputAction: TextInputAction.next,
                        autoValidate: false,
                        // maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: famPhone,
                        // maxLength: 10,
                        decoration: InputDecoration(
                            border: InputBorder.none, counterText: ""),
                        onChanged: (phn) {
                          print(phn.completeNumber);
                          // viewModel.phone.text = phn.completeNumber;
                          // print(viewModel.phone.text);
                          mob = phn.completeNumber;
                          print(mob);
                          // viewModel.phone.text = pp;
                        },
                        onCountryChanged: (phn) {
                          print('Country code changed to: ' + phn.countryCode);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(22, 10, 0, 0),
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
                                  gen = "Male";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: gen == "Male"
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
                                  gen = "Female";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    color: gen == "Female"
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: InkWell(
                        onTap: () {
                          famPhone.text = mob;
                          print(famPhone);
                          familyMember.membername=famMember.text;
                          familyMember.memberPhone=famPhone.text;
                          familyMember.memberGender = gen;
                          _editMsg(viewModel,familyMember);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => SignUp()));
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
                            child: Text("Add Member",
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
                );
              },
            ));
  }

  void editMember(
      AddManuallyViewModel viewModel, int index, BuildContext context) {
    TextEditingController famname = TextEditingController();
    TextEditingController famPhn = TextEditingController();
    TextEditingController fammsg = TextEditingController();
    var pp;

    famname.text = viewModel.membersList[index].membername;
    famPhn.text = viewModel.membersList[index].memberPhone;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return ListView(
            shrinkWrap: true,
            children: [ Container(
              //height: MediaQuery.of(context).size.height * 0.55,
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
                  Container(
                    margin: EdgeInsets.fromLTRB(150, 20, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text("Edit Member",
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
                    margin: EdgeInsets.fromLTRB(22, 20, 0, 0),
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
                    margin: EdgeInsets.fromLTRB(22, 10, 22, 0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      controller: famname,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(22, 10, 0, 0),
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
                    margin: EdgeInsets.fromLTRB(22, 10, 22, 0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)),
                    child: IntlPhoneField(
                      autoValidate: false,
                      textInputAction: TextInputAction.next,
                      // maxLines: 1,
                      keyboardType: TextInputType.number,
                      controller: famPhn,
                      // maxLength: 10,
                      decoration: InputDecoration(
                          border: InputBorder.none, counterText: ""),
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
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(22, 10, 0, 0),
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
                  //               viewModel.gen = "Male";
                  //             });
                  //           },
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(color: Colors.black12),
                  //                 color: viewModel.gen == "Male"
                  //                     ? Color(0xff2c98f0)
                  //                     : Color(0xffffffff),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             height: 50,
                  //             width: 50,
                  //             margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  //             child: Icon(
                  //               Icons.male_outlined,
                  //               size: 35,
                  //             ),
                  //             // color: Colors.blue,
                  //           ),
                  //         ),
                  //         Container(
                  //             margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
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
                  //               gen = "Female";
                  //             });
                  //           },
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(color: Colors.black12),
                  //                 color: gen == "Female"
                  //                     ? Color(0xff2c98f0)
                  //                     : Color(0xffffffff),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             height: 50,
                  //             width: 50,
                  //             margin: EdgeInsets.fromLTRB(40, 10, 0, 0),
                  //             child: Icon(
                  //               Icons.female_outlined,
                  //               size: 35,
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //             margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
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
                  // Spacer(),
                  //Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom==0?20:150,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: InkWell(

                      onTap: () {
                       famPhn.text= pp;
                        print(famPhn.text);
                        viewModel.editFamily(context,famname.text,famPhn.text,index);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => SignUp()));
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
                  // Spacer(),
                ],
              ),
            ),]
          );
        },
      ),
    );
  }

  void _editMsg(AddManuallyViewModel viewModel,FamilyMember familyMember) {
    TextEditingController famMsg = TextEditingController();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (ctx) => Container(
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
                // Container(
                //     alignment: Alignment.topRight,
                //     margin: EdgeInsets.fromLTRB(80, 20, 0, 0),
                //     child: new Text("Edit",
                //         style: TextStyle(
                //           fontFamily: 'Oxygen',
                //           color: Color(0xff4b5567),
                //           fontSize: 14,
                //           fontWeight: FontWeight.w700,
                //           fontStyle: FontStyle.normal,
                //           letterSpacing: -0.408,
                //         )))
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
                controller: famMsg,
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: InkWell(
                onTap: () async {
                  familyMember.memberMsg=famMsg.text;
                  viewModel.familyPost(context, pill,familyMember);

                  // await viewModel.familyList();

                  // showAlertDialog(context, viewModel);
                  // await Future<String>.delayed(const Duration(seconds: 2));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AddFamily(pill: pill)));
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyPills()));
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
      onModelReady: (viewModel) {
        viewModel.familyList();
        pill = widget.pill ?? Pill();
      },
      disposeViewModel: false,
      viewModelBuilder: () => AddManuallyViewModel(),
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              key: scaffoldState,
              backgroundColor: Color(0xff2c98f0),
              appBar: AppBar(
                backgroundColor: Color(0xff2c98f0),
                toolbarHeight: 90,
                leading: IconButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      size: 40,
                    )),
                elevation: 0.0,
                title: Text(
                  'Add Family',
                  // widget.pill == null ? 'Add Family' : 'Select member',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              floatingActionButton:
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Container(
                          margin: EdgeInsets.fromLTRB(
                              0, 0, 20, widget.pill != null ? 80 : 20),
                          child: FloatingActionButton(
                            child: Icon(
                              Icons.add,
                              size: 35,
                            ),
                            // label: Text(
                            //    '' ,
                            //   style: TextStyle(fontSize: 17),
                            // ),
                            onPressed: () {
                              addMember(viewModel, context);
                              // if (widget.pill == null) {
                              //
                              // }
                              // else {
                              //   viewModel.membersList.forEach(
                              //     (element) {
                              //       if (element.selected) {
                              //         widget.pill.familyMembers.add(FamilyList());
                              //         widget.pill.familyMembers.last.name =
                              //             element.membername;
                              //         widget.pill.familyMembers.last.mobile =
                              //             element.memberPhone;
                              //       }
                              //     },
                              //   );
                              //   viewModel.setReminderPost(widget.pill);
                              //   _showMessage();// Navigator.push(
                              //   //   context,
                              //   //   MaterialPageRoute(
                              //   //     builder: (context) =>
                              //   //         RemainderPage(pill: widget.pill),
                              //   //   ),
                              //   // );
                              // }
                            },
                          ),
                        )
                      : Container(),
              body: viewModel.isBusy
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : viewModel.membersList.length != 0
                      ? Container(
                          // padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Color(0xfffafafa),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Text('hhh'),
                              SizedBox(height: 20),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: viewModel.membersList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            // color: Colors.red,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                20, 0, 0, 0),
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            new BoxDecoration(
                                                                color: Color(
                                                                    0xfffE8E8E8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                        alignment:
                                                            Alignment.center,
                                                        child: !viewModel
                                                                .membersList[
                                                                    index]
                                                                .selected
                                                            ? Text(
                                                                '${viewModel.membersList[index].membername.substring(0, 1)}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Icon(Icons.done,
                                                                color: Colors
                                                                    .blueGrey),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                    0, 0),
                                                            child: Text(
                                                                viewModel
                                                                    .membersList[
                                                                        index]
                                                                    .membername,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Oxygen',
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  letterSpacing:
                                                                      -0.408,
                                                                )),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                      '${viewModel.membersList[index].memberPhone},',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Oxygen',
                                                                        color: Color(
                                                                            0xff9c9b9f),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        letterSpacing:
                                                                            -0.408,
                                                                      ))),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                      '${viewModel.membersList[index].memberGender}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Oxygen',
                                                                        color: Color(
                                                                            0xff9c9b9f),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        letterSpacing:
                                                                            -0.408,
                                                                      ))),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuButton(
                                                  onSelected: (result) {
                                                    if (result == 'Edit') {
                                                      editMember(viewModel,
                                                          index, context);
                                                    } else if (result ==
                                                        'Delete') {
                                                      viewModel.deleteFamily(index);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                  itemBuilder: (BuildContext
                                                          context) =>
                                                      <PopupMenuEntry<dynamic>>[
                                                    PopupMenuItem<dynamic>(
                                                      value: 'Edit',
                                                      child: Text('Edit'),
                                                    ),
                                                    PopupMenuItem<dynamic>(
                                                      value: 'Delete',
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      );
                                    }),
                              ),
                              // widget.pill != null
                              //     ? Padding(
                              //         padding:
                              //             EdgeInsets.fromLTRB(40, 0, 40, 20),
                              //         child: Container(
                              //           height: 50,
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                   color: Colors.black12),
                              //               color: Color(0xff2c98f0),
                              //               borderRadius:
                              //                   BorderRadius.circular(10)),
                              //           child: InkWell(
                              //             onTap: () {
                              //               viewModel.membersList.forEach(
                              //                 (element) {
                              //                   if (element.selected) {
                              //                     widget.pill.familyMembers
                              //                         .add(FamilyList());
                              //                     widget.pill.familyMembers.last
                              //                             .name =
                              //                         element.membername;
                              //                     widget.pill.familyMembers.last
                              //                             .mobile =
                              //                         element.memberPhone;
                              //                   }
                              //                 },
                              //               );
                              //               viewModel
                              //                   .setReminderPost(widget.pill);
                              //               _showMessage(); //
                              //             },
                              //             child: Container(
                              //               padding: EdgeInsets.all(12),
                              //               alignment: Alignment.center,
                              //               child: Text("Continue",
                              //                   textAlign: TextAlign.center,
                              //                   style: TextStyle(
                              //                     fontFamily: 'Poppins',
                              //                     color: Color(0xffffffff),
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.w500,
                              //                     fontStyle: FontStyle.normal,
                              //                   )),
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //     : Container()
                            ],
                          ),
                        )
                      : Container(
                          // padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Color(0xfffafafa),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("Add Family Members",
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        color: Color(0xff9c9b9f),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: -0.408,
                                      ))),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    'assets/images/addfam.png',
                                    height: 90,
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  width: MediaQuery.of(context).size.width,
                                  child: new Text(
                                      "Remind your loved ones about taking\n\t\t\t \t\t\t\t\t "
                                      " \t\t\t\t\t\t       \t\tmedication",
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
                        )),
        );
      },
    );
  }
}

showAlertDialog(BuildContext context, AddManuallyViewModel viewModel,
    {Pill pill}) {
  // set up the buttons

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
      // Navigator.pop(context);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => AddFamily(pill: pill)));
    },
    btnOkText: 'Okay',
    // btnOkIcon: Icons.app_registration_rounded,
  )..show();

  // show the dialog
}
