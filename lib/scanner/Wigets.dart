import 'package:flutter/material.dart';

iconCard(context, widget, text,margin) {
  return Container(
    height: MediaQuery.of(context).size.width / 2 - 30,
    width: MediaQuery.of(context).size.width / 2 - 30,
    margin: margin,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 5)
        ]),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widget!=null?widget:Container(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    ),
  );
}
