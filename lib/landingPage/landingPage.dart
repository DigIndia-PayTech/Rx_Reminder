import 'dart:convert';
import 'dart:io';
import 'package:Medicine_Remainder/MainPage.dart';
import 'package:Medicine_Remainder/landingPage/addManual.dart';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/listPages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:learning_input_image/learning_input_image.dart';
// import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  // const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<File> attachmentList = [];

  // https://cr.digindiapaytech.in/
  bool _scanning = false;
  bool _debugLocked = false;
  String _extractText = '\n \n Your Extracted text appears here \n \n';
  String finalText;
  File _pickedImage;
  File croppedFile;
  final picker = ImagePicker();
  // Future<void> _startRecognition(InputImage image) async {
  //   TextRecognitionState state = Provider.of(context, listen: false);
  //
  //   if (state.isNotProcessing) {
  //     state.startProcessing();
  //     state.image = image;
  //     state.data = await _textRecognition?.process(image);
  //     state.stopProcessing();
  //   }
  // }
  Future<int> deleteFile() async {
    try {
      final file = croppedFile;
      await file.delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }
  // TextRecognition _textRecognition = TextRecognition();
  imageEmpty() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Rx Scan'),
            content: Text('No image was selected...'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  clearImage() {
    setState(() {
      croppedFile = null;
    });
  }

  @override
  void initState() {
    super.initState();

    getuserId();
  }

  var userId;

  getuserId() async {
    SharedPreferences sp;
    sp = await SharedPreferences.getInstance();
    userId = sp.getInt('UserID').toString();
  }

  getImage(imageSource, viewModel) async {
    print("Getting Image");
    final _pickedImage = await picker.getImage(source: imageSource);
    File temp = File(_pickedImage.path);
    setState(() {
      _scanning = true;
    });
    cropImage(temp, viewModel);
  }

  cropImage(File pickedImage, AddManuallyViewModel viewModel) async {
    print("Cropping Image");
    croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    extractText(croppedFile, viewModel);
    viewModel.croppedFile = croppedFile;
    return croppedFile;
  }

  extractText(file, viewModel) async {
    print("Extracting Text");
    _extractText = await SimpleOcrPlugin.performOCR(file.path);
    var data = json.decode(_extractText);
   finalText = data['text'];
    print('extracted text is : $finalText');
    print('gyuuu');
    setState(() {
      _scanning = false;
      print("End");
      if (finalText != null) {
        setText(viewModel);
      } else {
        showAlertDialog(BuildContext context) {
          // set up the buttons
          Widget cancelButton = FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = FlatButton(
            child: Text("Scan Again"),
            onPressed: () {
              // getImage(imageSource);
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("AlertDialog"),
            content: Text("Could Not Extract Text...!"),
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
    });

    print(finalText);
    return finalText;
  }

  setText(AddManuallyViewModel viewModel) async {
    viewModel.text = finalText.toString();
    SharedPreferences.setMockInitialValues({});
    SharedPreferences sp = await SharedPreferences.getInstance();
    viewModel.setBusy(false);

    showAlertDialog(context);
    // Future.delayed(Duration(seconds: 10), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => AddManual(extractText: temp),
    //     ),
    //   );
    // });

    print('herrruuuuu');
    sp.setString('_extractText', finalText.toString());
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.green, fontSize: 20),
      ),
      onPressed: () {
        String temp = '';
        for (int i = 0; i < finalText.length; i++) {
          if (finalText[i] != '\n') {
            temp = temp + finalText[i];
          }
        }
        finalText = temp;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddManual(extractText: temp ?? '')));
      },
    );

    Widget submitButton = FlatButton(
      child: Text(
        "Retake",
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
      onPressed: () {
        croppedFile = null;
        //getImage(imageSource);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RX TITLE : ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Expanded(
            child: Text(
              finalText,
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          )
        ],
      ),
      actions: [cancelButton, submitButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextEditingController yuu = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AddManuallyViewModel>.reactive(
        disposeViewModel: false,
        onModelReady: (viewModel) {
          viewModel.sharedPreferences();

          //viewModel.getUser();
        },
        builder: (context, viewModel, child) {
          return WillPopScope(
            onWillPop: () async {
              if (userId != null)
                return Future.value(true);
              else {
                SystemNavigator.pop();
                return Future.value(false);
              }
            },
            child: Scaffold(
                backgroundColor: Color(0xff2c98f0),
                appBar: AppBar(
                  toolbarHeight: 70,
                  automaticallyImplyLeading: false,
                  leading: userId == null
                      ? IconButton(
                          onPressed: () {
                            //userId != null?
                            SystemNavigator.pop(); //:
                            // Navigator.push(
                            //   // Navigator.of(context).pop();
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MainPage()));
                          },
                          icon: Icon(Icons.close))
                      : null,
                  backgroundColor: Color(0xff2c98f0),
                  elevation: 0.0,
                  title: Text(
                    'Scan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Container(
                  margin: EdgeInsets.only(top: 15),
                  // width: 360,
                  // height: 155,
                  decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: sWidth,
                          height: sWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(41, 41, 41, 41),
                                height: sWidth - 82,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.blue, width: 1.5),
                                ),
                                alignment: Alignment.center,
                                child: Container(),
                              ),
                              Container(
                                height: sWidth - (82 + 53 + 53),
                                width: sWidth,
                                color: Colors.white,
                              ),
                              Container(
                                width: sWidth - (82 + 53 + 53),
                                height: sWidth,
                                color: Colors.white,
                              ),
                              viewModel.isBusy
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      margin: EdgeInsets.all(41),
                                      padding: EdgeInsets.all(20),
                                      width: sWidth - 82,
                                      height: sWidth - 82,
                                      child: viewModel.croppedFile == null
                                          ? Image.asset(
                                              'assets/images/med.jpeg',
                                              fit: BoxFit.contain)
                                          : Image.file(viewModel.croppedFile),
                                    )
                            ],
                          ),
                        ),
                        Container(
                            // color: Colors.green,
                            height: 185,
                            // alignment: Alignment.bottomLeft,
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.all(35),
                                      child: FloatingActionButton(
                                        elevation: 0.0,
                                        onPressed: () {
                                          viewModel.setBusy(true);
                                          getImage(ImageSource.gallery, viewModel);
                                              },
                                       child: Icon(
                                          Icons.add_photo_alternate,
                                          color: Color(0xff0066ff),
                                        ),
                                        backgroundColor: Color(0xffe8f1ff),
                                      )),
                                    SizedBox(
                                      height: 90.0,
                                      width: 100.0,
                                      child: FittedBox(
                                        child: FloatingActionButton(
                                          child: Icon(
                                              Icons.document_scanner_outlined),
                                          onPressed: () {
                                            viewModel.setBusy(true);
                                            getImage(
                                                ImageSource.camera, viewModel);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.all(35),
                                      child: FloatingActionButton(
                                        elevation: 0.0,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddManual(),
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.add,
                                            color: Color(0xff0066ff)),
                                        backgroundColor: Color(0xffe8f1ff),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: Text(
                                          'Gallery',
                                        )),
                                    // Text(''),

                                    Container(
                                        margin: EdgeInsets.only(left: 130),
                                        child: Text(
                                          'Add Manually',
                                          textAlign: TextAlign.center,
                                        ))
                                  ],
                                ),
                              ],
                            )),
                      ]),
                )),
          );
        },
        viewModelBuilder: () => AddManuallyViewModel());
  }
}
// class TextRecognitionState extends ChangeNotifier {
//   InputImage _image;
//   RecognizedText _data;
//   bool _isProcessing = false;
//
//   InputImage get image => _image;
//   RecognizedText get data => _data;
//   String get text => _data.text;
//   bool get isNotProcessing => !_isProcessing;
//   bool get isNotEmpty => _data != null && text.isNotEmpty;
//
//   void startProcessing() {
//     _isProcessing = true;
//     notifyListeners();
//   }
//
//   void stopProcessing() {
//     _isProcessing = false;
//     notifyListeners();
//   }
//
//   set image(InputImage image) {
//     _image = image;
//     notifyListeners();
//   }
//
//   set data(RecognizedText data) {
//     _data = data;
//     notifyListeners();
//   }
// }