import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:medi_granta/Widgets/details_screen_widgets.dart';
import 'package:medi_granta/Widgets/processing_screen_widgets.dart';
import 'package:medi_granta/models/get_and_crop_image.dart';
import 'package:medi_granta/screens/details_screen.dart';
import '../models/colors.dart';

class ProcessScreen extends StatefulWidget {
  static final String id = 'process_screen';
  ProcessScreen(this.path);
  final String path;

  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final _focusNode = FocusNode();
  TextEditingController _prefMedNameInput = new TextEditingController();
  Map<String, dynamic> medNameRes = {};
  List<String> tags = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TopBar(
                height: height / 2.6,
                width: width,
                path: widget.path,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Transform.translate(
                  offset: Offset(0, -25),
                  child: MaterialButton(
                    height: height * 0.045,
                    minWidth: width / 3,
                    splashColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    color: secondaryColor,
                    child: Text(
                      'Scan',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      callImageToText(widget.path);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      MaterialInputWidget(
                        focusNode: _focusNode,
                        controller: _prefMedNameInput,
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildTags(),
                          SizedBox(height: 50),
                          Row(
                            children: [
                              Spacer(),
                              MaterialButton(
                                padding: EdgeInsets.all(12.0),
                                shape: CircleBorder(),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailsScreen(
                                        _prefMedNameInput.text.trim(),
                                      ),
                                    ),
                                  );
                                },
                                color: secondaryColor,
                                child: InkWell(
                                  splashColor: Colors.grey[400],
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black54,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Tags buildTags() {
    return Tags(
      key: _tagStateKey,
      spacing: 15.0,
      itemCount: tags.length,
      itemBuilder: (int index) {
        final item = tags[index];
        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[400]),
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          activeColor: secondaryColor,
          color: secondaryColor,
          combine: ItemTagsCombine.withTextBefore,
          textStyle: TextStyle(fontSize: 12.0),
          onPressed: (tag) {
            print(tag);
            setState(() {
              _prefMedNameInput.text = _prefMedNameInput.text + " " + tag.title;
            });
          },
          removeButton: ItemTagsRemoveButton(
            backgroundColor: secondaryColor,
            color: Colors.black,
            size: 18,
            onRemoved: () {
              setState(() {
                tags.removeAt(index);
              });
              return true;
            },
          ),
        );
      },
    );
  }

  void callImageToText(String path) {
    GetAndCropImage getTextFromImg = GetAndCropImage();
    getTextFromImg.getTextFromImage(path).then((value) {
      setState(() {
        medNameRes = value;
        tags = medNameRes['medNameList'];
        _prefMedNameInput.text = medNameRes['preferredMedName'];
      });
    });
  }
}
