import 'package:Medicine_Remainder/profilePage.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:medical_app/constants.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  bool morning = false;
  Color selectColor = Colors.black;
  double _height;
  double _width;
  bool _timeVisible1 = false;
  bool _dateVisible = false;
  bool _timeVisible2 = false;
  bool _timeVisible3 = false;
  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  var chosenvalue;
  List<String> list = ['Every Day', 'Alternate Days', 'Manually Set Date'];
  bool afternoon = false;

  // TimeOfDay selectedTime = TimeOfDay.now();
  bool night = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 26,
          ),
        ),
        title: Row(
          children: [
            Text(
              'Add Reminder',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Mate_SC',
                fontSize: 32,
              ),
            ),
            SizedBox(width: 20,),
            IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Medicine name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF073738),
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.medical_services_rounded,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter medicine name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Reminding Days',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 15, top: 5),
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    //gives the width of the dropdown button
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF073738),
                          blurRadius: 10,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items

                    child: DropdownButtonHideUnderline(
                      // to hide the default underline of the dropdown button
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.white,
                        ),
                        // icon color of the dropdown button
                        items: list.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              '\t\t\t\t$value',
                              textAlign: TextAlign.center,
                              style: TextStyle(

                                fontSize: 20,

                                color: Colors.purple,
                              ),
                            ),
                          );
                        }).toList(),

                        hint: Text(
                          '\t\t\t\t Select Days',
                          style:
                              TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        // setting hint
                        onChanged: (String value) {
                          setState(() {
                            chosenvalue = value;

                            if ( chosenvalue =='Manually Set Date')
                              {
                                _dateVisible = true;
                              }
                            selectColor = Colors.white;
                             // saving the selected value
                          });
                        },
                        value: chosenvalue,

                        // displaying the selected value
                      ),
                    )),
              ),
              SizedBox(height: 15),
              Visibility(
                visible: _dateVisible,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 120,),
                        Icon(Icons.calendar_today_outlined,color: Colors.purple, ),
                        SizedBox(width: 10,),
                        Text(
                          'Set Date:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF073738),
                          blurRadius: 10,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setDate = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      decoration: InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'When to take?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _timeVisible1 = true;
                        morning = !morning;
                      });
                    },
                    child: TimeCard(
                      icon: Icons.wb_sunny,
                      time: 'Morning',
                      isSelected: morning,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        afternoon = !afternoon;
                        _timeVisible2= true;
                      });
                    },
                    child: TimeCard(
                      icon: Icons.wb_sunny_outlined,
                      time: 'Afternoon',
                      isSelected: afternoon,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _timeVisible3=true;
                        night = !night;
                      });
                    },
                    child: TimeCard(
                      icon: Icons.nightlight_round,
                      time: 'Night',
                      isSelected: night,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Visibility(
                    visible: _timeVisible1,
                    child: Column(
                      children: [
                        // Icon(Icons.wb_sunny),
                        Text(
                          'Set Time 1:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.30,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF073738),
                                  blurRadius: 10,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              onSaved: (String val) {
                                _setTime = val;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              decoration: InputDecoration(
                                  hintText: 'Hrs:Mins',
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding: EdgeInsets.all(3)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              SizedBox(width: 5,),

              Visibility(
                visible: _timeVisible2,
                child: Column(
                  children: [
                    // Icon(Icons.wb_sunny_outlined),
                    Text(
                      'Set Time 2:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF073738),
                              blurRadius: 10,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                          decoration: InputDecoration(
                              hintText: 'Hrs:Mins',
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(3)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),SizedBox(width: 5,),
              Visibility(
                visible: _timeVisible3,
                child: Column(
                  children: [
                    // Icon(Icons.nightlight_round),
                    Text(
                      'Set Time 3:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.30,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF073738),
                              blurRadius: 10,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                          decoration: InputDecoration(
                              hintText: 'Hrs:Mins',
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              // labelText: 'Time',
                              contentPadding: EdgeInsets.all(3)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Additional notes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF073738),
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Additional notes...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlatButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                  color: Colors.black,
                  // color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Colors.orange,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Set Reminder',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Yes", style: TextStyle(fontSize: 22, color: Colors.green),),
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => FamilyMembers()));
      },
    );
    Widget continueButton = FlatButton(
      child: Text("No", style: TextStyle(fontSize: 22, color: Colors.red),),
      onPressed: () {
        // getImage(imageSource);
        Navigator.pop(context);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("DO YOU WANT TO KEEP YOUR FAMILY MEMBERS AWARE..?"),

      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return alert;
      },
    );
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({
    Key key,
    this.icon,
    this.time,
    this.isSelected,
  }) : super(key: key);
  final IconData icon;
  final String time;
  final bool isSelected;
  final bool timeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      margin: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple   : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF073738),
            blurRadius: 10,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.orange : Colors.black,
            size: 40,
          ),
          SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.black,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

}
