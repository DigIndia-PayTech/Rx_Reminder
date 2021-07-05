import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/OnBoardingScreens/onboardingModel.dart';
import 'package:Medicine_Remainder/landingPage/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<ExplanationData> data = [
  ExplanationData(
      // description:
      // "Labore do ex cillum fugiat anim nulla pariatur est. Elit laboris eiusmod ex occaecat do ea officia esse culpa.",
      // title: "A Day at the Park",
      localImageSrc: "assets/images/scr1.jpeg",
      backgroundColor: Colors.white),
  ExplanationData(
      // description:
      // "Sit ullamco anim deserunt aliquip mollit id. Occaecat labore laboris magna reprehenderit sint in sunt ea.",
      // title: "Playing Fetch",
      localImageSrc: "assets/images/scr2.jpeg",
      backgroundColor: Colors.white),
  ExplanationData(
      // description:
      // "Eiusmod aliqua laboris duis eiusmod ea ea commodo dolore. Ullamco nulla nostrud et officia.",
      // title: "Relaxing Walk",
      localImageSrc: "assets/images/scr3.jpeg",
      backgroundColor: Colors.white),
];

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> /*with ChangeNotifier*/ {
  final _controller = PageController();

  int _currentIndex = 0;

  // OpenPainter _painter = OpenPainter(3, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.grey,
          child: SafeArea(
              child: Container(
            padding: EdgeInsets.all(10),
            color: data[_currentIndex].backgroundColor,
            alignment: Alignment.center,
            child: Column(children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: PageView(
                                scrollDirection: Axis.horizontal,
                                controller: _controller,
                                onPageChanged: (value) {
                                  // _painter.changeIndex(value);
                                  setState(() {
                                    _currentIndex = value;
                                  });
                                  // notifyListeners();
                                },
                                children: data
                                    .map((e) => ExplanationPage(data: e))
                                    .toList())),
                        flex: 6),
                    Expanded(
                        // flex: 3,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(data.length,
                                  (index) => createCircle(index: index)),
                            )),
                        _currentIndex == data.length - 1
                            ? InkWell(
                                onTap: () async {
                                  SharedPreferences sp =
                                      await SharedPreferences.getInstance();
                                  sp.setBool('OnBoarding', true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LandingPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    // padding: EdgeInsets.all(5),
                                    width: 320,
                                    height: 40,
                                    child: Text("Get Started",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xffffffff),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                    decoration: new BoxDecoration(
                                        color: Color(0xff0066ff),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )
                            : Container()
                      ],
                    ))
                  ],
                ),
              )
            ]),
          ))),
    );
  }

  createCircle({int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 4),
        height: 9,
        width: _currentIndex == index ? 30 : 10,
        decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
            borderRadius: BorderRadius.circular(5)));
  }
}
