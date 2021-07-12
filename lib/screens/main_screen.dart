import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_granta/Widgets/details_screen_widgets.dart';
import 'package:medi_granta/Widgets/home_screen_widgets.dart';
import 'package:medi_granta/colors.dart';
import 'package:medi_granta/get_and_crop_image.dart';
import 'package:medi_granta/screens/process_screen.dart';

class MainScreen extends StatefulWidget {
  static const id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File _image;
  ImageSource _imageSource;
  PickedFile pickedFile;
  GetAndCropImage getAndCropImg = GetAndCropImage();
  FocusNode focusNode = FocusNode();
  List recentSearches = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            children: [
              TopBar(
                height: height / 2.6,
                width: width,
                brand: true,
                focusNode: focusNode,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: BoldText(text: 'Recent Searches'),
                      ),
                      recentSearches.isNotEmpty
                          ? RecentList()
                          : ImageContainer(height: height),
                      // buildTabletButtons(context),
                    ],
                  ),
                ),
              ),
              buildTabletButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTabletButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _imageSource = ImageSource.camera;
            getAndCropImg
                .getImage(pickedFile, _image, imgSrc: _imageSource)
                .then((value) {
              if (value != null)
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProcessScreen(value),
                ));
            });
          },
          child: Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              color: Color(0xffef1515),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 25.0,
            ),
          ),
        ),
        SizedBox(width: 3.0),
        GestureDetector(
          onTap: () {
            _imageSource = ImageSource.gallery;
            getAndCropImg
                .getImage(pickedFile, _image, imgSrc: _imageSource)
                .then((value) {
              if (value != null)
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProcessScreen(value),
                ));
            });
          },
          child: Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Color(0xffc4c4c4),
            ),
            child: Icon(
              Icons.collections_outlined,
              size: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height / 4,
            child: Image.asset(
              'images/recent-search.png',
            ),
          ),
          Heading20Bold(heading: 'No Recent Searches'),
        ],
      ),
    );
  }
}

class RecentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Dummy ${index + 1}'),
        );
      },
    );
  }
}
