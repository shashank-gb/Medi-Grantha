import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_granta/Widgets/home_screen_widgets.dart';
import 'package:medi_granta/screens/main_screen.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

final List imgList = [Colors.red, Colors.grey, Colors.blue];

class HomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  ImageSource _imageSource;
  PickedFile pickedFile;
  List<String> items = ['Panplus', 'Combiflam'];
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff28388f),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 4, left: 4, right: 4),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Brand(
                          text: 'Medi-',
                        ),
                        Brand(
                          text: 'Grantha',
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Carousel(),
                    SizedBox(height: 2),
                    // MaterialInputWidget(), // Search bar
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfffbfbfb),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      offset: Offset(0, -8),
                      color: Colors.black.withOpacity(.4),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _image != null
                            ? _getImage(ImageSource.gallery)
                            : Container(),
                        onDoubleTap: () => _image != null
                            ? _getImage(ImageSource.camera)
                            : Container(),
                        onLongPress: () => _image != null
                            ? _cropImage(pickedFile.path)
                            : Container(),
                        child: Container(
                          width: double.infinity,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Color(0xff28388f),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(0, 4),
                                color: Color.fromRGBO(0, 0, 0, .4),
                              )
                            ],
                          ),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    File(_image.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                        ),
                      ), // Captured Image Container
                      Visibility(
                        visible: _image != null ? true : false,
                        child: GestureDetector(
                          onTap: () {
                            // getTextFromImage().then(
                            //   (value) => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ProcessingScreen(value),
                            //     ),
                            //   ),
                            // );
                            Navigator.pushNamed(context, MainScreen.id);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xff28388f),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 8),
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(.4)),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _imageSource = ImageSource.camera;
                              _getImage(_imageSource);
                            },
                            child: Container(
                              width: 11,
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffff1717),
                                    Color(0xffff1717),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffd71313),
                                    offset: Offset(5, 5.0),
                                    blurRadius: 12.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    bottomLeft: Radius.circular(50)),
                                color: Color(0xffef1515),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 3.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 1.0),
                          GestureDetector(
                            onTap: () {
                              _imageSource = ImageSource.gallery;
                              _getImage(_imageSource);
                            },
                            child: Container(
                              width: 11,
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffb0b0b0),
                                    Color(0xffd8d8d8),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffb0b0b0),
                                    offset: Offset(5, 5.0),
                                    blurRadius: 12.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                                color: Color(0xffc4c4c4),
                              ),
                              child: Icon(
                                Icons.collections_outlined,
                                size: 3.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> imageList = imgList
      .map((item) => Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: item,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 8),
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))
      .toList();

  void _getImage(ImageSource imgSrc) async {
    pickedFile = await ImagePicker()
        .getImage(source: imgSrc, preferredCameraDevice: CameraDevice.rear);
    if (pickedFile != null) _cropImage(pickedFile.path);
  }

  Future _cropImage(String imgPath) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: imgPath,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Color(0xff28388f),
        statusBarColor: Color(0xff28388f),
        activeControlsWidgetColor: Color(0xff28388f),
        cropGridRowCount: 0,
        cropGridColumnCount: 0,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.ratio3x2,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(title: 'Crop Image'),
    );
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  Future<Map<String, dynamic>> getTextFromImage(String path) async {
    print('I am here');
    Map<String, dynamic> res = {};
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    List<TextBlock> blocks = recognisedText.blocks;
    List<String> medNames = [];
    List<double> eachBlockSize = [];
    for (TextBlock block in recognisedText.blocks) {
      eachBlockSize
          .add(block.rect.bottomRight.distance - block.rect.topLeft.distance);
    }
    double maxBlockSize =
        eachBlockSize.reduce((curr, next) => curr > next ? curr : next);
    for (TextBlock block in recognisedText.blocks) {
      double blockSize =
          block.rect.bottomRight.distance - block.rect.topLeft.distance;
      print(blockSize);
      if (blockSize == maxBlockSize) {
        for (TextLine lines in block.lines) {
          for (TextElement ele in lines.elements) {
            print(ele.text);
            medNames.add(ele.text);
          }
        }
      }
    }

    List<String> word;
    blocks.forEach((element) {
      word = element.text.trim().split(' ');
      word.forEach((name) {
        if (name.contains(new RegExp(r"^[A-Za-z0-9]+$"))) {
          int numberCount = 0;

          List<String> eachLetter = name.split(new RegExp(r'[0-9]'));
          eachLetter.forEach((letter) {
            if (letter.isEmpty) numberCount++;
          });

          if (numberCount <= 4) medNames.add(name);
        }
      });
    });

    if (medNames.isEmpty) {
      res['preferredMedName'] = '';
      res['medNameList'] = word;
      print(word);
      return res;
    } else {
      var distinctMedNames = medNames.toSet().toList();
      print(distinctMedNames);
      res['preferredMedName'] = distinctMedNames.elementAt(0);
      res['medNameList'] = distinctMedNames;
      return res;
    }
  }
}
