import 'dart:io';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'home_screen_widgets.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    @required this.height,
    @required this.width,
    this.medicine,
    this.path,
    this.brand = false,
    this.imgList,
    this.imageList,
    this.focusNode,
  });

  final double height;
  final double width;
  final String medicine;
  final String path;
  final bool brand;
  final List imgList;
  final List<Widget> imageList;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 30.0,
              right: 30.0,
            ),
            child: decideUpperTheme(medicine, brand, width, height, imageList,
                imgList, path, focusNode),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: tertiaryColor.withOpacity(.5),
                offset: Offset(0, 4),
                blurRadius: 4.0,
              )
            ],
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
            ),
          ),
        ),
        Positioned(
          top: 25,
          child: Container(
            child: IconButton(
              onPressed: () => print('click'),
              icon: Icon(
                Icons.menu_rounded,
                size: 30,
              ),
            ),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: tertiaryColor.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            width: width / 5,
            height: height / 6,
          ),
        )
      ],
    );
  }

  Widget decideUpperTheme(
      String medicine,
      bool brand,
      double width,
      double height,
      List<Widget> imageList,
      List imgList,
      String path,
      FocusNode focusNode) {
    if (medicine != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.network(
            'https://dummyimage.com/80x100/ffffff/000000.png&text=sample',
          ),
          SizedBox(
            width: width * 0.05,
          ),
          Expanded(
            child: Text(
              medicine,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
    if (brand != false) {
      return Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Brand(text: 'Medi-'),
          //     Brand(text: 'Grantha'),
          //   ],
          // ),
          // Divider(
          //   thickness: 1,
          //   color: secondaryColor,
          // ),
          // Divider(
          //   thickness: 1,
          //   color: secondaryColor,
          // ),
          Container(
            alignment: Alignment.centerRight,
            height: height / 6,
            child: Image.asset('images/brand.png'),
          ),
          SizedBox(
            width: width,
            height: height / 15,
          ),
          Carousel(),
          SizedBox(height: height / 15),
          MaterialInputWidget(focusNode),
        ],
      );
    }
    return Column(
      children: [
        Container(
          height: height / 4.5,
        ),
        Container(
          height: height / 1.8,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.fill,
            ),
            color: secondaryColor,
            border: Border.all(color: Color(0xff333819), width: 5),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class SideEffectsWidget extends StatelessWidget {
  const SideEffectsWidget({
    @required this.height,
    // this.text,
    @required this.header,
    @required this.values,
    @required this.width,
  });

  final double height;
  // final String text;
  final String header;
  final List<String> values;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 14.0,
        ),
        child: Column(
          children: [
            Heading20Bold(heading: 'SIDE EFFECTS'),
            SizedBox(
              height: height * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PointsText(text: text),
                BoldText(text: header),
                BulletListWidget(
                  points: values,
                  width: width,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralDetailsList extends StatelessWidget {
  const GeneralDetailsList({
    Key key,
    @required this.manufacturer,
    @required this.saltComposition,
    @required this.storage,
    @required this.height,
  }) : super(key: key);

  final String manufacturer;
  final String saltComposition;
  final String storage;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        List<String> titles = ['Manufacturer', 'Salt Composition', 'Storage'];
        List<String> contents = [manufacturer, saltComposition, storage];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GeneralDetailsWidget(
              title: titles[index],
              content: contents[index],
            ),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        );
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}

class BenefitsWidget extends StatelessWidget {
  const BenefitsWidget({
    @required this.height,
    @required this.name,
    @required this.textHeader,
    @required this.text,
    @required this.header,
    @required this.width,
  });

  final String name;
  final double height;
  final List<String> textHeader;
  final String header;
  final List<String> text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 14.0,
        ),
        child: Column(
          children: [
            Heading20Bold(heading: 'BENEFITS'),
            SizedBox(
              height: height * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(text: 'Uses of $name'.toUpperCase()),
                SizedBox(
                  height: height * 0.01,
                ),
                BulletListWidget(
                  points: textHeader,
                  width: width,
                ),
                SizedBox(height: height * 0.01),
                Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: text.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText(text: textHeader[index].toUpperCase()),
                          Text(removeBrTags(text[index])),
                          SizedBox(height: height * 0.01)
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SafetyAdviceListWidget extends StatelessWidget {
  const SafetyAdviceListWidget({
    @required this.text,
    @required this.height,
    @required this.label,
    @required this.description,
  });

  final List<String> text;
  final double height;
  final List<String> label;
  final List<String> description;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: text.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BoldText(
                  text: text[index],
                ),
                SizedBox(
                  width: height * 0.01,
                ),
                LabelWidget(
                  label[index] != null ? label[index] : '',
                ),
              ],
            ),
            Text(
              removeBrTags(description[index]),
            ),
            SizedBox(
              height: height * 0.01,
            )
          ],
        );
      },
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText({
    @required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PointsText extends StatelessWidget {
  const PointsText({
    @required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        height: 1.5,
      ),
    );
  }
}

class BulletListWidget extends StatelessWidget {
  const BulletListWidget({
    @required this.points,
    @required this.width,
  });

  final List<String> points;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: points.length,
      itemBuilder: (context, index) {
        return Container(
          child: Row(
            children: [
              Icon(
                Icons.fiber_manual_record,
                size: 10,
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Expanded(
                child: Text(
                  points[index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GeneralDetailsWidget extends StatelessWidget {
  const GeneralDetailsWidget({
    @required this.title,
    @required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xff798322),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              content,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  LabelWidget(
    this.label,
  );
  final String label;
  @override
  Widget build(BuildContext context) {
    Color color;
    if (label == 'UNSAFE')
      color = unsafe;
    else if (label == 'SAFE')
      color = safe;
    else if (label == 'CAUTION')
      color = caution;
    else if (label == 'SAFE IF PRESCRIBED')
      color = safeIfPrescribed;
    else if (label == 'CONSULT YOUR DOCTOR')
      color = consultYourDoctor;
    else
      color = defaultColor.withOpacity(0);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class HeadAndTextCard extends StatelessWidget {
  HeadAndTextCard({
    @required this.height,
    @required this.content,
    @required this.heading,
  });

  final double height;
  final String content;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        child: Container(
          child: Column(
            children: [
              Heading20Bold(heading: heading, color: Color(0xff798322)),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                removeBrTags(content),
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Heading20Bold extends StatelessWidget {
  const Heading20Bold({
    @required this.heading,
    this.color,
  });

  final String heading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
          fontSize: 20,
          letterSpacing: 1,
          color: color != null ? color : Color(0xff798322),
          fontWeight: FontWeight.bold),
    );
  }
}

String removeBrTags(String htmlEle) {
  return htmlEle.replaceAll(RegExp(r'[<br ?/?><br ?/?>]+[<BR>]+'), "\n");
}
