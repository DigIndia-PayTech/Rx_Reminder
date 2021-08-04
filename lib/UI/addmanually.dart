// import 'package:app_intro_food_delivery/AddUser.dart';
// import 'package:app_intro_food_delivery/UI/addManuallyViewModel.dart';
// import 'package:app_intro_food_delivery/login.dart';
// import 'package:app_intro_food_delivery/profilePage.dart';
// import 'package:app_intro_food_delivery/scanner/fadeAnimation.dart';
// import 'package:app_intro_food_delivery/setReminder.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stacked/stacked.dart';
//
// class AddManually extends StatefulWidget {
//   // const addManually({Key? key}) : super(key: key);
//
//   @override
//   _AddManuallyState createState() => _AddManuallyState();
// }
//
// class _AddManuallyState extends State<AddManually> {
//
//  final TextEditingController desc = new TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<AddManuallyViewModel>.reactive(
//       disposeViewModel: false,
//       viewModelBuilder: () => AddManuallyViewModel(),
//       onModelReady: (viewModel) => viewModel.initialise(),
//       builder: (context, viewModel, child) {
//         return Scaffold(
//           body: SafeArea(
//             child: Column(
//               children: [
//                 Stack(children: [
//                   (Container(
//                     height: 190.0,
//                     child: Stack(
//                       children: <Widget>[
//                         Container(
//                           height: MediaQuery.of(context).size.height,
//                           // color: Colors.purple,
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   colors: [
//                                 Colors.purple[900],
//                                 Colors.purple[600],
//                                 Colors.purple[400]
//                               ])),
//                           width: MediaQuery.of(context).size.width,
//                           // height: 140.0,
//                           child: Container(
//                             margin: EdgeInsets.only(left: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 FadeAnimation(
//                                     1,
//                                     Text(
//                                       "Rx Details",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'Mate_SC',
//                                           fontSize: 40),
//                                     )),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 FadeAnimation(
//                                     1.3,
//                                     Text(
//                                       "    Add Manually",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'Mate_SC',
//                                           fontSize: 20),
//                                     )),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 120.0,
//                           left: 0.0,
//                           right: 0.0,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: DecoratedBox(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(1.0),
//                                   border: Border.all(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       width: 1.0),
//                                   color: Colors.white),
//                               child: Row(
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(
//                                       Icons.medical_services_rounded,
//                                       color: Colors.purple,
//                                     ),
//                                     onPressed: () {
//                                       print("your menu action here");
//                                       // _scaffoldKey.currentState.openDrawer();
//                                     },
//                                   ),
//                                   Expanded(
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: "Search",
//                                       ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(
//                                       Icons.search,
//                                       color: Colors.purple,
//                                     ),
//                                     onPressed: () {
//                                       print("your menu action here");
//                                     },
//                                   ),
//
//                                   PopupMenuButton(
//                                     onSelected: (result) {
//                                       if (result == 'Add') {
//                                         setState(() {
//                                           viewModel.addNewList();
//                                         });
//
//                                         // viewModel.addNewMedicine(index);
//                                       }
//                                       else if(result=='Scan'){
//
//                                       }
//                                       else{
//
//
//                                       }
//                                     },
//                                     icon: Icon(
//                                       Icons.add,
//                                       color: Colors.purpleAccent,
//                                       size: 24,
//                                     ),
//                                     itemBuilder: (BuildContext context) =>
//                                     <PopupMenuEntry<dynamic>>[
//                                       PopupMenuItem<dynamic>(
//                                         value: 'Scan',
//                                         child: Text('Scan'),
//                                       ),
//                                       PopupMenuItem<dynamic>(
//                                         value: 'Gallery',
//                                         child: Text('Gallery'),
//                                       ),
//                                       PopupMenuItem<dynamic>(
//                                         value: 'Add',
//                                         child: Text('Add Manually'),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//                 ]),
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: ClampingScrollPhysics(),
//                     itemCount: viewModel.medList.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                         // height: 200,
//                         decoration: BoxDecoration(
//                             // color: Colors.green,
//                             borderRadius: BorderRadius.circular(10),
//                             border:
//                                 Border.all(width: 3, color: Colors.grey[300])),
//                         child: Table(
//                           columnWidths: {
//                             0: FlexColumnWidth(1),
//                             1: FlexColumnWidth(1)
//                           },
//                           border: TableBorder.all(
//                             color: Colors.grey[350],
//                           ),
//                           children:
//                             viewModel.populateRows(index,TableRow(children: [
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 30,
//                                 child: Text('Rx Name',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       color: Color(0xff343333),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       fontStyle: FontStyle.normal,
//                                       letterSpacing: 0,
//                                     )),
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: 30,
//                                 child: Stack(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.center,
//                                       child: Text('Description',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontFamily: 'Montserrat',
//                                             color: Color(0xff343333),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                             letterSpacing: 0,
//                                           )),
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                                       child: Align(
//                                         alignment: Alignment.topRight,
//                                         child: PopupMenuButton(
//                                           onSelected: (result) {
//
//                                           if(result=='Add')
//                                             {
//                                               viewModel.addNewMedicine(index);
//                                             }
//                                             else if(result == 'deleteLastRow'){
//                                               viewModel.deleteLastRow(index);
//                                             }
//                                           },
//                                           icon: Icon(
//                                             Icons.more_vert,
//                                             color: Colors.purpleAccent,
//                                             size: 18,
//                                           ),
//                                           itemBuilder: (BuildContext context) =>
//                                           <PopupMenuEntry<dynamic>>[
//
//                                             PopupMenuItem<dynamic>(
//                                               value: 'Add',
//                                               child: Text('Add'),
//                                             ),
//                                             PopupMenuItem<dynamic>(
//                                               value: 'Delete',
//                                               child: Text('Delete Last Row'),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     // SizedBox(width: 10,),
//                                     Padding(
//
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: InkWell(
//                                               onTap: (){
//                                                 viewModel.removeMedicine(index);
//                                               },
//                                               child: Icon(
//                                                 Icons.delete,
//                                                 color: Colors.black,
//                                                 size: 22,
//                                               ),
//                                             ),
//                                       ),
//                                     ),
//
//
//
//                                   ],
//                                 ),
//                               ),
//                             ]))
//                           ,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ButtonTheme(
//                     minWidth: 200,
//                     height: 50,
//                     child: RaisedButton(
//         shape: new RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(30.0),),
//
//                       color: Colors.purple,
//                         hoverColor: Colors.purpleAccent,
//
//
//
//                         onPressed: (){
//
//           showAlertDialog(context);
//                         },
//                         child:Text('Proceed', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Mate_SC'),)
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//    showAlertDialog(BuildContext context) {
//     // set up the buttons
//     Widget cancelButton = FlatButton(
//       child: Text("Login Again", style: TextStyle(color: Colors.red),),
//       onPressed: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => Login()));
//       },
//     );
//     Widget continueButton = FlatButton(
//       child: Text("Add User", style: TextStyle(color: Colors.red),),
//       onPressed: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => AddUser()));
//
//       },
//     );
//     Widget submitButton = FlatButton(
//       child: Text("proceed >", style: TextStyle(color: Colors.green),),
//       onPressed: () {
//         // getImage(imageSource);
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => Reminder()));
//
//       },
//     );
//
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("AlertDialog"),
//       content: Text("Not an existing user...!"),
//
//       actions: [
//         cancelButton,
//         continueButton,
//         submitButton
//       ],
//     );
//
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//
//         return alert;
//       },
//     );
//   }
//
// }
