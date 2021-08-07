
import 'package:Medicine_Remainder/FamilyMembers/cal.dart';
import 'package:Medicine_Remainder/FamilyMembers/model.dart';
import 'package:Medicine_Remainder/listPages/Profile.dart';
import 'package:flutter/material.dart';

// import '../../screens/home/calendar_day.dart';

class Calendar extends StatefulWidget {
  final Function chooseDay;
  final List<CalendarDayModel> _daysList;
  Calendar(this.chooseDay,this._daysList);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 0,top: 00, bottom: 40),
                child: Text('November',
                    style: TextStyle(
                      fontFamily: 'Oxygen',
                      color: Color(0xffffffff),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.408,
                    )),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },

                child: Container(
                    alignment: Alignment.topRight,
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.fromLTRB(130, 0, 5, 0),
                    decoration: new BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/wife.png')
                            ,fit: BoxFit.contain
                        ),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...widget._daysList.map((day) => CalendarDay(day, widget.chooseDay))],
          ),
        ],
      ),
    );
  }

}
