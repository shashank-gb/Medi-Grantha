import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'details_screen_widgets.dart';

class OtcWidget extends StatelessWidget {
  const OtcWidget({
    Key key,
    @required this.height,
    @required this.width,
    @required this.name,
    @required this.manufacturer,
    @required this.allInfo,
  }) : super(key: key);

  final double height;
  final double width;
  final String name;
  final String manufacturer;
  final Map<String, dynamic> allInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          height: height / 2.6,
          width: width,
          medicine: name,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Expanded(
          child: Scrollbar(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GeneralDetailsWidget(
                    title: 'Manufacturer',
                    content: manufacturer,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Heading20Bold(
                            heading: allInfo['header'],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Html(
                            data: makeProperBrTag(allInfo['displayText']),
                            style: {
                              "li, body": Style(
                                lineHeight: LineHeight(1.3),
                              ),
                            },
                          ),
                          // Text(allInfo['displayText']),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

String makeProperBrTag(String content) {
  content = content.replaceAll("&nbsp;", "");
  return content.replaceAll(RegExp(r'(<br />)+'), "<br><br>");
}
