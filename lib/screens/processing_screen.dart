import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:medi_granta/Widgets/details_screen_widgets.dart';
import 'package:medi_granta/colors.dart';
import 'package:sizer/sizer.dart';
import 'details_screen.dart';

class ProcessingScreen extends StatefulWidget {
  static const String id = 'processing_screen';
  final Map<String, dynamic> medicineNameResults;
  ProcessingScreen(this.medicineNameResults);

  @override
  _ProcessingScreenState createState() => _ProcessingScreenState();
}

final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
_getAllItem() {
  List<Item> lst = _tagStateKey.currentState?.getAllItem;
  if (lst != null)
    lst.where((a) => a.active == true).forEach((a) => print(a.title));
}

final List imgList = [Colors.red, Colors.grey, Colors.blue];
List _items;

class _ProcessingScreenState extends State<ProcessingScreen> {
  TextEditingController _textFormController;
  int _current = 0;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _textFormController = new TextEditingController(
        text: widget.medicineNameResults['preferredMedName']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Map<String, dynamic> res = widget.medicineNameResults;
    List<String> medNameRes = res['medNameList'];
    _items = medNameRes;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor,
        body: Column(
          children: <Widget>[
            TopBar(
              height: height * 0.4,
              width: width,
            ),
            // Container(
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 4.h, left: 4.h, right: 4.h),
            //     child: Column(
            //       children: <Widget>[
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'Medi-',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 letterSpacing: 1,
            //                 fontFamily: GoogleFonts.aclonica().fontFamily,
            //                 fontWeight: FontWeight.w900,
            //                 fontSize: 20.sp,
            //               ),
            //             ),
            //             Text(
            //               'Grantha',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 letterSpacing: 1,
            //                 fontFamily: GoogleFonts.aclonica().fontFamily,
            //                 fontWeight: FontWeight.w900,
            //                 fontSize: 20.sp,
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 2.h),
            //         Column(
            //           children: <Widget>[
            //             CarouselSlider(
            //               items: imageList,
            //               options: CarouselOptions(
            //                   autoPlay: true,
            //                   height: 20.0.h,
            //                   autoPlayAnimationDuration:
            //                       Duration(milliseconds: 800),
            //                   viewportFraction: 1.0,
            //                   enlargeCenterPage: true,
            //                   enableInfiniteScroll: true,
            //                   autoPlayCurve: Curves.fastOutSlowIn,
            //                   onPageChanged: (index, reason) {
            //                     setState(() {
            //                       _current = index;
            //                     });
            //                   }),
            //             ),
            //             Transform.translate(
            //               offset: Offset(0, -4.h),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: imgList.map((url) {
            //                   int index = imgList.indexOf(url);
            //                   return Container(
            //                     width: 0.8.h,
            //                     height: 0.8.h,
            //                     margin: EdgeInsets.symmetric(
            //                       horizontal: .8.h,
            //                     ),
            //                     decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       color: _current == index
            //                           ? Color.fromRGBO(0, 0, 0, 1)
            //                           : Color.fromRGBO(0, 0, 0, .3),
            //                     ),
            //                   );
            //                 }).toList(),
            //               ),
            //             )
            //           ],
            //         ), // Carousel
            //
            //         SizedBox(height: 4.h),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 4.h),
                    Material(
                      elevation: 1.h,
                      borderRadius: BorderRadius.circular(8.0.h),
                      shadowColor: secondaryColor.withOpacity(.5),
                      child: TextFormField(
                        controller: _textFormController,
                        cursorColor: Colors.grey[400],
                        onFieldSubmitted: (searchText) {
                          if (searchText.isNotEmpty) {
                            goToDetailsPage(_textFormController.text.trim());
                          } else
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Tablet name never be empty!!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8.sp),
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
                        },
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Search for Medicines',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: secondaryColor,
                              width: 0.15.h,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: secondaryColor,
                              width: 0.15.h,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _focusNode.unfocus();
                              _focusNode.canRequestFocus = false;
                              WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => _textFormController.clear());
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ), // Search bar
                    SizedBox(height: 2.h),
                    Text(
                      'Related Words : ',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 12.0),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Tags(
                            key: _tagStateKey,
                            spacing: 15.0,
                            itemCount: _items.length,
                            itemBuilder: (int index) {
                              final item = _items[index];
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
                                    _textFormController.text =
                                        _textFormController.text +
                                            " " +
                                            tag.title;
                                  });
                                },
                                removeButton: ItemTagsRemoveButton(
                                  backgroundColor: secondaryColor,
                                  color: Colors.black,
                                  size: 1.5.h,
                                  onRemoved: () {
                                    setState(() {
                                      medNameRes.removeAt(index);
                                    });
                                    return true;
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 50),
                          Row(
                            children: [
                              Spacer(),
                              MaterialButton(
                                padding: EdgeInsets.all(10.0),
                                shape: CircleBorder(),
                                onPressed: () {
                                  goToDetailsPage(
                                      _textFormController.text.trim());
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
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToDetailsPage(String searchedText) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailsScreen(searchedText)));
  }
}

List<Widget> imageList = imgList
    .map((item) => Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Stack(
              children: <Widget>[
                // Image.network(
                //   item,
                //   fit: BoxFit.cover,
                //   width: 1000.0,
                // ),
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
