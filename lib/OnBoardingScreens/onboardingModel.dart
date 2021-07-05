import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ExplanationData {
  // final String title;
  // final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData({this.localImageSrc, this.backgroundColor});
}

class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  ExplanationPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24, bottom: 16),
      child: Image.asset(data.localImageSrc,
          fit: BoxFit.contain,
          // height: MediaQuery.of(context).size.height * 0.33,
          alignment: Alignment.center),
    );
  }
}
