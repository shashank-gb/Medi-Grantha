import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_granta/colors.dart';
import 'package:medi_granta/screens/details_screen.dart';
import 'package:medi_granta/screens/processing_screen.dart';

final List imgList = ['images/carousel.png'];

class Brand extends StatelessWidget {
  const Brand({
    @required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        letterSpacing: 1,
        fontFamily: GoogleFonts.sourceSansPro().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          items: imgList
              .map(
                (item) => Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: tertiaryColor.withOpacity(0.5),
                  child: Image.asset(item, fit: BoxFit.fill, width: 1000),
                ),
              )
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            height: 150.0,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Transform.translate(
          offset: Offset(0, -10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 6,
                height: 6,
                margin: EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? secondaryColor
                      : primaryColor.withOpacity(.5),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class MaterialInputWidget extends StatefulWidget {
  MaterialInputWidget(this.focusNode);
  final FocusNode focusNode;
  @override
  _MaterialInputWidgetState createState() => _MaterialInputWidgetState();
}

class _MaterialInputWidgetState extends State<MaterialInputWidget> {
  final TextEditingController materialInputWidget = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(50.0),
      shadowColor: Colors.black.withOpacity(.4),
      child: TextField(
        controller: materialInputWidget,
        cursorColor: Colors.black54,
        focusNode: widget.focusNode,
        onSubmitted: (searchText) => getDetails(searchText),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          hintText: ' Search for Medicines...',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: tertiaryColor.withOpacity(0.8),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: tertiaryColor.withOpacity(0.8),
              width: 1.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 20.0,
          ),
          suffixIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: tertiaryColor.withOpacity(0.8),
                width: 1.5,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: secondaryColor,
              child: IconButton(
                onPressed: () => getDetails(materialInputWidget.text),
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getDetails(String searchText) {
    print('I am called');
    if (searchText.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => DetailsScreen(searchText.trim())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tablet name never be empty!!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.only(
            bottom: 60.0,
            left: 40.0,
            right: 40.0,
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          elevation: 10.0,
          backgroundColor: Colors.black.withOpacity(.8),
        ),
      );
    }
  }
}

List<Widget> imageList = imgList
    .map(
      (item) => Container(
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
      ),
    )
    .toList();
