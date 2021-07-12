import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GetAndCropImage {
  Future<String> getImage(PickedFile pickedFile, File _image,
      {ImageSource imgSrc = ImageSource.gallery}) async {
    pickedFile = await ImagePicker()
        .getImage(source: imgSrc, preferredCameraDevice: CameraDevice.rear);
    if (pickedFile != null) {
      return cropImage(pickedFile.path, _image);
    }
  }

  Future<String> cropImage(String imgPath, File _image) async {
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
      _image = croppedFile;
    }
    return _image.path;
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
