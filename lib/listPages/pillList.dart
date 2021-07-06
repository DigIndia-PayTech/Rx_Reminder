import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/landingPage/landingPage.dart';
import 'package:Medicine_Remainder/landingPage/notificationManager.dart';
import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:telephony/telephony.dart';

class MyPills extends StatefulWidget {
  @override
  _MyPillsState createState() => _MyPillsState();
}

class _MyPillsState extends State<MyPills> {
  String pageStatus = 'Ongoing';
  var selectedIndex;

  Widget pillCards(
      {String title, String endDate, String timeData, String rxStatus}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 0)
        ],
        color: Color(0xffffffff),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rectangle 88
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color(0xffe8f1fe),
            ),
            child: Image.asset(
              'assets/images/pillList.png',
              color: Colors.blue,
              height: 10,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            child: Text(title ?? "",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Oxygen",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                        onSelected: (result) {
                          if (result == 'Edit') {
                            // editMember(
                            //     viewModel, index);
                          } else if (result == 'Delete') {
                            // viewModel.deleteLastRow(index);
                          }
                        },
                        itemBuilder: (BuildContext context) =>
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
                  Container(
                    child: // Daily/ 8:00 Am - 12:00 Pm - 9:00Pm
                        Text("Daily: ${timeData ?? ''} ",
                            style: TextStyle(
                                color: Color(0xff9c9b9f),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Oxygen",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                  ),
                  Container(
                    child: // Daily/ 8:00 Am - 12:00 Pm - 9:00Pm
                        // Until/6-12-2021
                        Text("Until: ${endDate ?? ''}",
                            style: const TextStyle(
                                color: const Color(0xff9c9b9f),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Oxygen",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(rxStatus ?? '',
                        style: TextStyle(
                            color: rxStatus != 'Ongoing'
                                ? Colors.red
                                : Color(0xffb9b8bd),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Oxygen",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        textAlign: TextAlign.left),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget typeCard(String text, bool selected) {
    return Container(
      alignment: Alignment.center,
      width: 95,
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        boxShadow: selected
            ? [
                BoxShadow(
                    color: const Color(0x1a4b58d0),
                    offset: Offset(0, 2),
                    blurRadius: 28,
                    spreadRadius: 0)
              ]
            : [],
        color: selected ? Colors.white : Color(0xfff5f5f5),
      ),
      child: // Ongoing
          Text(text,
              style: TextStyle(
                  color: selected ? Color(0xff2c98f0) : Color(0xff99a2ad),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0),
              textAlign: TextAlign.left),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color blue = Color(0xFF2c98f0);
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
        viewModelBuilder: () => AddManuallyViewModel(),
        disposeViewModel: false,
        onModelReady: (viewModel) {

          viewModel.sharedPreferences();
          //viewModel.getUser();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
              backgroundColor: blue,
              floatingActionButton: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xfff5f5f5),
                ),
                child: FloatingActionButton.extended(
                  icon: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  label: Text(
                    'Add',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LandingPage()));
                  },
                ),
              ),
              appBar: AppBar(
                // leading: IconButton(
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => HomePage()));
                //     },
                //     icon: Icon(
                //       Icons.keyboard_arrow_left_sharp,
                //       size: 40,
                //     )),
                elevation: 0,
                backgroundColor: blue,
                title: // Title
                    Text("Home",
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Oxygen",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        textAlign: TextAlign.center),
              ),
              body: ViewModelBuilder<AddManuallyViewModel>.reactive(
                  onModelReady: (viewModel) {
                    viewModel.rxList('onGoing');
                    pageStatus = 'onGoing';
                  },
                  viewModelBuilder: () => AddManuallyViewModel(),
                  disposeViewModel: false,
                  builder: (context, viewModel, child) {
                    return Column(
                      children: [
                        Container(
                          height: 150 - AppBar().preferredSize.height - 30,
                          child: // Rectangle 90
                              Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0x4dc4c4c4),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  width: 24,
                                  height: 24,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Oxygen",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.0),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 10),
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Oxygen",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfffafafa),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 25, 15, 0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: Color(0xfff5f5f5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          viewModel.updatePillListPageType(
                                              'onGoing');

                                          setState(() {
                                            pageStatus = 'onGoing';
                                          });
                                        },
                                        child: typeCard(
                                            'onGoing',
                                            pageStatus == 'onGoing'
                                                ? true
                                                : false),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          viewModel.updatePillListPageType(
                                              'expiringSoon');

                                          setState(() {
                                            pageStatus = 'Expiring soon';
                                          });
                                        },
                                        child: typeCard(
                                            'Expiring soon',
                                            pageStatus == 'Expiring soon'
                                                ? true
                                                : false),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          viewModel.updatePillListPageType(
                                              'expired');

                                          setState(() {
                                            pageStatus = 'Expired';
                                          });
                                        },
                                        child: typeCard(
                                            'Expired',
                                            pageStatus == 'Expired'
                                                ? true
                                                : false),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: viewModel.isBusy
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          itemCount:
                                              viewModel.selectedPillList.length,
                                          itemBuilder: (context, index) {
                                            return pillCards(
                                                title: viewModel
                                                    .selectedPillList[index]
                                                    .rxTitle,
                                                endDate: viewModel
                                                    .selectedPillList[index]
                                                    .endDate,
                                                timeData: viewModel
                                                    .selectedPillList[index]
                                                    .timeData,
                                                rxStatus: viewModel
                                                    .selectedPillList[index]
                                                    .rxStatus);
                                          },
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }));
        });
  }
}
