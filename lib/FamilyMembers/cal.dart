
import 'package:Medicine_Remainder/FamilyMembers/model.dart';
import "package:flutter/material.dart";

class CalendarDay extends StatefulWidget {
  final CalendarDayModel day;
  final Function onDayClick;

  CalendarDay(this.day, this.onDayClick);

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
              color: widget.day.isChecked ? Colors.white : Colors.transparent,
            ),
            child: GestureDetector(
              onTap: () => widget.onDayClick(widget.day),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    widget.day.dayString,
                    style: TextStyle(
                        color: widget.day.isChecked ? Colors.blue : Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                        // color: widget.day.isChecked ? Color(0xffffffff):Colors.blue
                        ),
                    child: CircleAvatar(
                      radius: 0.3,
                      backgroundColor:
                          widget.day.isChecked ? Colors.blue : Colors.white,
                      child: Text(
                        widget.day.dayNumber.toString(),
                        style: TextStyle(
                            color: widget.day.isChecked
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
