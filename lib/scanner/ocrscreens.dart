// import 'dart:html';
import 'dart:io';
import 'package:Medicine_Remainder/landingPage/addManuallyViewModel.dart';
import 'package:Medicine_Remainder/scanner/fadeAnimation.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<File> attachmentList = [];
  bool _scanning = false;
  bool _debugLocked = false;
  String _extractText = '\n \n Your Extracted text appears here \n \n';
  File _pickedImage;
  File croppedFile;
  final picker = ImagePicker();

  Future<int> deleteFile() async {
    try {
      final file = croppedFile;
      await file.delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }
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

  getImage(imageSource,viewModel) async {
    print("Getting Image");
    final _pickedImage = await picker.getImage(source: imageSource);
    File temp = File(_pickedImage.path);
    setState(() {
      _scanning = true;


    });
    cropImage(temp,viewModel);
  }

  cropImage(File pickedImage,viewModel) async {
    print("Cropping Image");
    croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
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
    extractText(croppedFile,viewModel);
    return croppedFile;
  }

  extractText(file,viewModel) async {
    print("Extracting Text");
    _extractText = await TesseractOcr.extractText(file.path);

    print('gyuuu');

    setState(() {
      _scanning = false;
      print("End");
      if(_extractText != null){
      setText(viewModel);}
      else{
        showAlertDialog(BuildContext context) {

          // set up the buttons
          Widget cancelButton = FlatButton(
            child: Text("Cancel"),
            onPressed:  () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = FlatButton(
            child: Text("Scan Again"),
            onPressed:  () {
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

    print(_extractText);
    return _extractText;

  }
  setText(viewModel) async{
    viewModel.text=_extractText.toString();
    SharedPreferences.setMockInitialValues({});
    SharedPreferences sp = await SharedPreferences.getInstance();
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => AddManually()));
    print('herrruuuuu');
    sp.setString('_extractText', _extractText.toString());
  }
TextEditingController yuu = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        builder: (context,viewModel,child){
      return Scaffold(
        body: Container(
          width: double.infinity,
          //   height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff6133DB),
                    // Color(0xff6133DB),
                    Color(0xffAEA5ED),
                    // Color(0xffAEA5ED),
                    Color(0xff976FEB),
                    //  Color(0xffAEA5ED),
                    Color(0xffA791ED),
                    Color(0xffAEA5ED),
                    Color(0xffAEA5ED),
                    //
                    // Color(0xffAEA5ED),
                    Color(0xffBCCEEF),
                    Color(0xff81A1C7),
                    Color(0xff688BB1)
                  ])),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),

              FadeAnimation(
                  1.3,
                  Text(
                    "Add Rx Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mate_SC',
                        fontSize: 35),
                  )),
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/tablet.jpeg'),
              InkWell(
                onTap: () async {
                  getImage(ImageSource.camera,viewModel);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: 260,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child:
                  _scanning ? SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? Colors.purpleAccent : Colors.white,
                        ),
                      );
                    },
                  ):
                    Text(
                      'SCAN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.purple[400],
                          fontFamily: 'Mate_SC'),
                    )),
              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  getImage(ImageSource.gallery,viewModel);
                },
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        width: 260,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child:
                            _scanning? SpinKitFadingCircle(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: index.isEven ? Colors.purpleAccent : Colors.white,
                                  ),
                                );
                              },
                            ):

                        Text(
                          'GALLERY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.purple[400],
                              fontFamily: 'Mate_SC'),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AddManually()));
                },
                child: Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(5),
                    width: 260,
                    height: 70,
                    margin: EdgeInsets.only(left: 47, right: 47),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ADD MANUALLY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.purple[400],
                          fontFamily: 'Mate_SC'),
                    )
                ),
              ),

              // Container(child:
              // _extractText != null?
              //
              //
              //     Text(_extractText): Container()


              // ),
              // (_pickedImage == null) && (croppedFile == null)
              //     ? Container()
              //     : croppedFile != null
              //     ? Container(
              //
              // )
              //     : Container(
              //   // height: 300,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black),
              //     color: Colors.grey[300],
              //   ),
              //   child: Icon(
              //     Icons.image,
              //     size: 100,
              //   ),
              // ),

            ],),


        ),
      );
    }, viewModelBuilder: ()=>AddManuallyViewModel());
  }
}
