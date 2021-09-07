import 'package:flutter/material.dart';
import 'package:medi_granta/screens/details_screen.dart';

import '../models/colors.dart';

SnackBar buildSnackBar() {
  return SnackBar(
    content: Text(
      'Tablet name never be empty!!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        8.0,
      ),
    ),
    margin: EdgeInsets.only(
      bottom: 60.0,
      left: 100.0,
      right: 100.0,
    ),
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 1500),
    elevation: 10.0,
    backgroundColor: secondaryColor,
  );
}

class MaterialInputWidget extends StatelessWidget {
  const MaterialInputWidget({
    FocusNode focusNode,
    TextEditingController controller,
  })  : _focusNode = focusNode,
        controller = controller;

  final FocusNode _focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: secondaryColor.withOpacity(.5),
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        cursorColor: Colors.black54,
        onTap: () {
          _focusNode.canRequestFocus = true;
        },
        onFieldSubmitted: (fieldVal) {
          if (fieldVal.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(fieldVal.trim()),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              buildSnackBar(),
            );
          }
        },
        controller: controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          hintStyle: TextStyle(color: Colors.black54),
          hintText: ' Search for Medicines...',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: secondaryColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: secondaryColor,
              width: 1.5,
            ),
          ),
          suffixIcon: IconButton(
            color: secondaryColor,
            splashRadius: 20,
            splashColor: secondaryColor,
            icon: Icon(Icons.close),
            onPressed: () {
              _focusNode.canRequestFocus = false;
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => controller.clear(),
              ); // clear content
            },
          ),
        ),
      ),
    );
  }
}
