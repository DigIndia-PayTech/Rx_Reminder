import 'dart:collection';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pageStatus = 'Ongoing';
  var selectedIndex;

  @override
  void initState() {
    super.initState();
    void initState() {
      // TODO: implement initState
      super.initState();
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _selectedDate = DateTime.now().add(Duration(days: 5));

  //
  // @override
  // void initState() {
  //   super.initState();
  //   // initNotifies();
  //   // setData();
  //   _daysList = _days.getCurrentDays();
  // }

  // final CalendarDayModel _days = CalendarDayModel();
  // List<CalendarDayModel> _daysList;
  int _lastChooseDay = 0;
  final CalendarWeekController _controller = CalendarWeekController();

  Widget skipped(
      {String title,
      String count,
      String timeData,
      String reminderStatus,
      String pillType}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 120,
      decoration: new BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color(0x19000000),
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        children: [
          Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Container(
                // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 40,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: reminderStatus=='Skipped'?
                    Color(0xffffeaf0):Color(0xfff1f6fe)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 5, 5, 0),
                      child: Text(timeData,
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            color: Color(0xff343434),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        width: 6,
                        height: 6,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xff343434))),
                    Container(
                        height: 16,
                        width: 30,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(count,
                            style: TextStyle(
                              fontFamily: 'Oxygen',
                              color: Color(0xff343434),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ))),
                    Container(
                        margin: EdgeInsets.fromLTRB(85, 5, 5, 0),
                        child: new Text(reminderStatus,
                            style: TextStyle(
                              fontFamily: 'Oxygen',
                              color: reminderStatus=='Skipped'?
                              Color(0xffff0000): Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ))),
                    Container(
                        width: 16,
                        height: 16,
                        decoration: new BoxDecoration(),
                        child: reminderStatus == 'Skipped'
                            ? Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.alarm_on_rounded,
                                color: Colors.green,
                              ))
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rectangle 88
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffe7e7e7)),
                child: Image.asset(
                  'assets/images/matre.png',
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(title,
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Oxygen",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.left),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text("Type:",
                              style: const TextStyle(
                                  color: const Color(0xff9c9b9f),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Oxygen",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          height: 16,
                          width: 30,
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                              color: Color(0xffe7e7e7),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.fromLTRB(2, 10, 0, 0),
                          child: Text(pillType,
                              style: const TextStyle(
                                  color: const Color(0xff9c9b9f),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Oxygen",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget completed() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 120,
      decoration: new BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color(0x19000000),
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          Stack(children: [
            Container(
              // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 40,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Color(0xfff1f6fe)),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 5, 0),
                    child: Text("8:30 AM",
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          color: Color(0xff343434),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                      width: 6,
                      height: 6,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xff343434))),
                  Container(
                      height: 16,
                      width: 30,
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: Text("1 pill",
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            color: Color(0xff343434),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                  Container(
                      margin: EdgeInsets.fromLTRB(85, 5, 5, 0),
                      child: new Text("Completed",
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: new BoxDecoration(),
                    child: Icon(
                      Icons.alarm_on_rounded,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rectangle 88
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffe7e7e7),
                ),
                child: Image.asset(
                  'assets/images/matre.png',
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text("Acetaminophen extra strength",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Oxygen",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.left),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text("Type:",
                              style: const TextStyle(
                                  color: const Color(0xff9c9b9f),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Oxygen",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          height: 16,
                          width: 30,
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                              color: Color(0xffe7e7e7),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.fromLTRB(2, 10, 0, 0),
                          child: Text(" Pill",
                              style: const TextStyle(
                                  color: const Color(0xff9c9b9f),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Oxygen",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget upcmg() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 120,
      decoration: new BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color(0x19000000),
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          Stack(
            children: [
              Container(
                // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 40,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Color(0xff2c98f0)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 5, 5, 0),
                      child: Text("8:30 AM",
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        width: 6,
                        height: 6,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        )),
                    Container(
                        height: 16,
                        width: 30,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text("1 pill",
                            style: TextStyle(
                              fontFamily: 'Oxygen',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ))),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rectangle 88
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffe8f1fe),
                ),
                child: Image.asset(
                  'assets/images/matre.png',
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text("Acetaminophen extra strength",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Oxygen",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.left),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text("Type:",
                              style: const TextStyle(
                                  color: const Color(0xff9c9b9f),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Oxygen",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                        ),
                        Container(
                          height: 16,
                          width: 30,
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                              color: Color(0xffe7e7e7),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.fromLTRB(2, 10, 0, 0),
                          child: Text(" Pill",
                              style: const TextStyle(
                                  color: const Color(0xff9c9b9f),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Oxygen",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color blue = Color(0xFF2c98f0);
    // Color blue = Color(0xFF2c98f0);
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
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: blue,
      //   leading:  IconButton(
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => OnBoarding()));
      //       },
      //       icon: Icon(
      //         Icons.keyboard_arrow_left_sharp,
      //         size: 40,
      //       )),
      //   title: // Title
      //       Text("November",
      //           style: const TextStyle(
      //               color: const Color(0xffffffff),
      //               fontWeight: FontWeight.w700,
      //               fontFamily: "Oxygen",
      //               fontStyle: FontStyle.normal,
      //               fontSize: 20.0),
      //           textAlign: TextAlign.center),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
              child: CalendarWeek(
                todayDateStyle: TextStyle(
                  color: Colors.white,
                ),
                controller: _controller,
                height: 150,
                dayOfWeekStyle: TextStyle(
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
                dateBackgroundColor: Colors.white,
                dateStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                showMonth: true,
                monthStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                minDate: DateTime.now().add(
                  Duration(days: -365),
                ),
                maxDate: DateTime.now().add(
                  Duration(days: 365),
                ),
                onDatePressed: (DateTime datetime) {
                  // Do something
                  setState(() {});
                },
                onDateLongPressed: (DateTime datetime) {
                  // Do something
                },
                onWeekChanged: () {
                  // Do something
                },
                decorations: [
                  DecorationItem(
                      decorationAlignment: FractionalOffset.bottomRight,
                      date: DateTime.now(),
                      decoration: Icon(
                        Icons.today,
                        color: Colors.blue,
                      )),
                  DecorationItem(
                      date: DateTime.now().add(Duration(days: 3)),
                      decoration: Text(
                        'Holiday',
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              )),
          // Container(
          //   child: Center(
          //     child: Text(
          //       '${_controller.selectedDate.day}/${_controller.selectedDate.month}/${_controller.selectedDate.year}',
          //       style: TextStyle(fontSize: 30),
          //     ),
          //   ),
          // ),

          // TableCalendar(
          //
          //   firstDay: kFirstDay,
          //   lastDay: kLastDay,
          //   focusedDay: _focusedDay,
          //   calendarFormat: _calendarFormat,
          //   selectedDayPredicate: (day) {
          //     // Use `selectedDayPredicate` to determine which day is currently selected.
          //     // If this returns true, then `day` will be marked as selected.
          //
          //     // Using `isSameDay` is recommended to disregard
          //     // the time-part of compared DateTime objects.
          //     return isSameDay(_selectedDay, day);
          //   },
          //   onDaySelected: (selectedDay, focusedDay) {
          //     if (!isSameDay(_selectedDay, selectedDay)) {
          //       // Call `setState()` when updating the selected day
          //       setState(() {
          //         _selectedDay = selectedDay;
          //         _focusedDay = focusedDay;
          //       });
          //     }
          //   },
          //   // onFormatChanged: (format) {
          //   //   if (_calendarFormat != format) {
          //   //     // Call `setState()` when updating calendar format
          //   //     setState(() {
          //   //       _calendarFormat = format;
          //   //     });
          //   //   }
          //   // },
          //   onPageChanged: (focusedDay) {
          //     // No need to call `setState()` here
          //     _focusedDay = focusedDay;
          //   },
          // ),
          // CalendarTimeline(
          //   initialDate: DateTime(2020, 4, 20),
          //   firstDate: DateTime(2019, 1, 15),
          //   lastDate: DateTime(2020, 11, 20),
          //   onDateSelected: (date) => print(date),
          //   leftMargin: 20,
          //   monthColor: Colors.blueGrey,
          //   dayColor: Colors.teal[200],
          //   activeDayColor: Colors.white,
          //   activeBackgroundDayColor: Colors.redAccent[100],
          //   dotsColor: Color(0xFF333A47),
          //   selectableDayPredicate: (date) => date.day != 23,
          //   locale: 'en_ISO',
          // ),
          // SizedBox(height: 50,),
          // CalendarTimeline(
          //   showYears: true,
          //   initialDate: _selectedDate,
          //   firstDate: DateTime.now(),
          //   lastDate: DateTime.now().add(Duration(days: 365)),
          //   onDateSelected: (date) {
          //     setState(() {
          //       _selectedDate = date;
          //
          //     });
          //   },
          //   leftMargin: 20,
          //   monthColor: Colors.white70,
          //   dayColor: Colors.white,
          //   dayNameColor: Color(0xFF333A47),
          //   activeDayColor: Colors.blue,
          //   activeBackgroundDayColor: Colors.white,
          //   dotsColor: Color(0xFF333A47),
          //   // selectableDayPredicate: (date) => date.day != 23,
          //   locale: 'en',
          // ),

          // Container(
          //   margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
          //   // padding: EdgeInsets.symmetric(horizontal: 5.0),
          //   child: Calendar(chooseDay,_daysList),
          // ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text("Morning",
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    color: Color(0xff9c9b9f),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ))),
                          // ListView.builder(
                          //   itemCount: 3,
                          //   itemBuilder: (context, index) {
                          //     return pillCards();
                          //   },
                          // ),
                            //---skipcards----
                          // Expanded(
                          //   child: viewModel.isBusy
                          //       ? Center(
                          //     child: CircularProgressIndicator(),
                          //   )
                          //       : ListView.builder(
                          //     itemCount:3,
                          //     viewModel.selectedPillList.length,
                          //     itemBuilder: (context, index) {
                          //       return skipped(
                          //           title: viewModel
                          //               .selectedPillList[index]
                          //               .rxTitle,
                          //           pillType: viewModel
                          //               .selectedPillList[index]
                          //               .type,
                          //           count: viewModel
                          //               .selectedPillList[index].whenInDay[0].count,
                          //
                          //           timeData: viewModel
                          //               .selectedPillList[index].
                          //           whenInDay[0].time,
                          //           reminderStatus: viewModel
                          //               .selectedPillList[index]
                          //               .reminderStatus);
                          //     },
                          //   ),
                          // ),
                          completed(),
                          completed(),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text("Upcoming",
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    color: Color(0xff9c9b9f),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ))),
                          upcmg(),
                          upcmg(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );});
  }
// void chooseDay(CalendarDayModel clickedDay){
//   setState(() {
//     _lastChooseDay = _daysList.indexOf(clickedDay);
//     _daysList.forEach((day) => day.isChecked = false );
//     CalendarDayModel chooseDay = _daysList[_daysList.indexOf(clickedDay)];
//     chooseDay.isChecked = true;
//     // dailyPills.clear();
//     // allListOfPills.forEach((pill) {
//     //   DateTime pillDate = DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
//     //   if(chooseDay.dayNumber == pillDate.day && chooseDay.month == pillDate.month && chooseDay.year == pillDate.year){
//     //     dailyPills.add(pill);
//     //   }
//   });
//   // dailyPills.sort((pill1,pill2) => pill1.time.compareTo(pill2.time));
//   // });
// }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(2020, 10, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    DateTime.now(): [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
