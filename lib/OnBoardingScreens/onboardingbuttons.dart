import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key key, this.currentIndex, this.dataLength, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: currentIndex == dataLength - 1
        ? [
          // SizedBox(width: 2,),
        Container(
          alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            width: 320,
            height: 46,
            child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            decoration: new BoxDecoration(

                color: Color(0xff0066ff),
                borderRadius: BorderRadius.circular(10)
            )

        ),
        SizedBox(height: 15,)
        ]
            : [
        Container()

      ],
      ),
    );
  }
}