import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  PickedFile _pickedFile;
  TextEditingController _resultCtrl = TextEditingController();

  @override
  Widget build(BuildContext c) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                _onRecogniseTap();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Icon(Icons.remove_red_eye),
              ),
            )
          ],
          title: Text("text recognition app", style: TextStyle(color: Colors.white),),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                //child: _buildDropDown(c)
                child: _buildLabel(c)
            ),

            Padding(
              padding: EdgeInsets.all(4),
              child: _buildImage(c),
            ),

            Padding(
              padding: EdgeInsets.all(8),
              child: _buildResultArea(c),
            ),

          ],
        )
    );
  }

  /// Build the label for opening the photo album.
  Widget _buildLabel(BuildContext c) {
    return InkWell(
      onTap: () {
        _onAlbumLabelTap(c);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(
          children: [
            Text("pick a photo from photo-album  "),
            Icon(Icons.camera),
          ],
        ),
      ),
    );
  }

  /// Build the image preview.
  ///
  /// Displayed image depends on the value of [_filePicked].
  Widget _buildImage(BuildContext c) {
    return _pickedFile!=null?
    Image.file(File(_pickedFile.path),
      width: 400,
      fit: BoxFit.contain,
    ):Container(height: 10,);
  }
  /// Build the text-area for displaying recognised results. This widget is read-only.
  Widget _buildResultArea(BuildContext c) {
    return TextField(
      controller: _resultCtrl,
      decoration: InputDecoration(
          hintText: "Recognised results would be displayed here..."
      ),
      minLines: 10,
      maxLines: 1000,
      enabled: false,
    );
  }
  /// Perform text-recognition and updates the content of the text-area.
  Future<void> _onRecogniseTap() async {
    String _result = await SimpleOcrPlugin.performOCR(_pickedFile.path);
    setState(() {
      _resultCtrl.text = _result;
    });
  }

  /// Display photo album for picking.
  Future<void> _onAlbumLabelTap(BuildContext c) async {
    _pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {});
  }
}