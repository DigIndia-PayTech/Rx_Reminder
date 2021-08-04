//
// import 'package:Medicine_Remainder/scanner/fadeAnimation.dart';
// import 'package:flutter/material.dart';
//
// class AddUser extends StatefulWidget {
//   // const AddUser({Key? key}) : super(key: key);
//
//   @override
//   _AddUserState createState() => _AddUserState();
// }
//
// class _AddUserState extends State<AddUser> {
//   String dropdownValue;
//
//   @override
//   Widget build(BuildContext context) {
//     // double width=MediaQuery.of(context).size.width;
//     // double height=MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//               gradient: LinearGradient( begin: Alignment.topRight,
//                   end: Alignment.bottomRight, colors: [
//                 Color(0xff6133DB),
//                 // Color(0xff6133DB),
//                 Color(0xffAEA5ED),
//                 // Color(0xffAEA5ED),
//                 Color(0xff976FEB),
//                 //  Color(0xffAEA5ED),
//                 Color(0xffA791ED),
//                 Color(0xffAEA5ED),
//                 Color(0xffAEA5ED),
//                 //
//                 // Color(0xffAEA5ED),
//                 Color(0xffBCCEEF),
//                 Color(0xff81A1C7),
//                 Color(0xff688BB1)
//           ])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 60,
//               ),
//               FadeAnimation(
//                   1,
//                   Text(
//                     "Add User",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Mate_SC',
//                         fontSize: 40),
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//               FadeAnimation(
//                   1.3,
//                   Text(
//                     "  Sign Up",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Mate_SC',
//                         fontSize: 20),
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(40),
//                             bottomRight: Radius.circular(40),
//                             topLeft: Radius.circular(40),
//                             topRight: Radius.circular(40))),
//                     // color: Colors.white,
//                     // height: 350,
//                     width: 350,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(22, 28, 15, 15),
//                           child: TextFormField(
//                             maxLines: 1,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                                 hintText: 'User Name',
//                                 icon: Icon(
//                                   Icons.person,
//                                   size: 30,
//                                   color: Colors.purple,
//                                 )),
//                             validator: (value) =>
//                                 value.isEmpty ? 'Email can\'t be empty' : null,
//                             // onSaved: (value) => _email = value.trim(),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(22, 10, 15, 15),
//                           child: new TextFormField(
//                             maxLines: 1,
//                             keyboardType: TextInputType.emailAddress,
//                             autofocus: false,
//                             decoration: new InputDecoration(
//                                 hintText: 'Mobile',
//                                 icon: new Icon(
//                                   Icons.phone,
//                                   size: 30,
//                                   color: Colors.purple,
//                                 )),
//                             validator: (value) =>
//                                 value.isEmpty ? 'Email can\'t be empty' : null,
//                             // onSaved: (value) => _email = value.trim(),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(22, 10, 15, 15),
//                           child: new TextFormField(
//                             maxLines: 1,
//                             keyboardType: TextInputType.emailAddress,
//                             autofocus: false,
//                             decoration: new InputDecoration(
//                                 hintText: 'Email',
//                                 icon: new Icon(
//                                   Icons.mail_outline,
//                                   size: 30,
//                                   color: Colors.purple,
//                                 )),
//                             validator: (value) =>
//                                 value.isEmpty ? 'Email can\'t be empty' : null,
//                             // onSaved: (value) => _email = value.trim(),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(22, 10, 15, 15),
//                           child: new TextFormField(
//                             maxLines: 1,
//                             keyboardType: TextInputType.emailAddress,
//                             autofocus: false,
//                             decoration: new InputDecoration(
//                                 hintText: 'Age',
//                                 icon: new Icon(
//                                   Icons.calendar_today_outlined,
//                                   size: 30,
//                                   color: Colors.purple,
//                                 )),
//                             validator: (value) =>
//                                 value.isEmpty ? 'Email can\'t be empty' : null,
//                             // onSaved: (value) => _email = value.trim(),
//                           ),
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.fromLTRB(22, 5, 15, 45),
//                             child: Stack(
//                                 children: ([
//                               Icon(
//                                 Icons.accessibility_new_rounded,
//                                 size: 30,
//                                 color: Colors.purple,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(left: 40),
//                                 child: new DropdownButtonFormField(
//                                   isExpanded: false,
//                                   value: dropdownValue,
//                                   // icon: Icon(Icons.arrow_downward),
//                                   // iconSize: 24,
//                                   elevation: 16,
//                                   style: TextStyle(color: Colors.deepPurple),
//
//                                   onChanged: (String newValue) {
//                                     setState(() {
//                                       dropdownValue = newValue;
//                                     });
//                                   },
//                                   hint: Text(
//                                     'Select gender',
//                                     style: TextStyle(fontSize: 17),
//                                   ),
//                                   items: <String>[
//                                     'Female',
//                                     'Male',
//                                     'Other',
//                                   ].map<DropdownMenuItem<String>>(
//                                       (String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ]))),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 470,
//                     // color: Colors.green,
//                     alignment: Alignment.bottomCenter,
//                     child: InkWell(
//                       onTap: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => AddManually()));
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20.0, vertical: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 width: 3.0),
//                             color: Colors.pink),
//                         child: Text(
//                           'Submit',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontFamily: 'Mate_SC'),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
