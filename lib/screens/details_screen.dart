import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:medi_granta/Widgets/details_screen_widgets.dart';
import 'package:medi_granta/Widgets/drugs_widget.dart';
import 'package:medi_granta/Widgets/otc_widget.dart';
import '../Tablet.dart';

class DetailsScreen extends StatefulWidget {
  static const String id = 'details_screen';
  final String medName;
  DetailsScreen(this.medName);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  Future<Tablet> futureData;
  Tablet tablet = new Tablet();
  @override
  void initState() {
    super.initState();
    print(widget.medName);
    futureData = tablet.getDetails(widget.medName);
    futureData.then((value) => print('details: ' + value.type));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffefefe),
        body: FutureBuilder<Tablet>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Something went Wrong');
            }
            if (snapshot.hasData) {
              String type = snapshot.data.type;
              if (type == 'otc') {
                String name = snapshot.data.name;
                String manufacturer = snapshot.data.manufacturer;
                Map<String, dynamic> allInfo = snapshot.data.allInfo;

                return OtcWidget(
                  height: height,
                  width: width,
                  name: name,
                  manufacturer: manufacturer,
                  allInfo: allInfo,
                );
              }
              if (type == 'drugs') {
                //General Details
                String name = snapshot.data.name;
                String manufacturer = snapshot.data.manufacturer;
                String saltComposition = snapshot.data.saltComposition;
                String storage = snapshot.data.storage;

                //Introduction
                String introduction = snapshot.data.introduction;

                //Side Effects
                String sideEffectsText = snapshot.data.sideEffects['text'];
                String sideEffectsHeader =
                    snapshot.data.sideEffects['values']['header'];
                List<String> sideEffectsValues = List<String>.from(
                    snapshot.data.sideEffects['values']['values']);

                //Benefits
                String benefitsHeader = snapshot.data.benefits['header'];
                List<String> benefitsTextHeader = List<String>.from(snapshot
                    .data.benefits['values']
                    .map((m) => m['header'])
                    .toList());
                List<String> benefitsText = List<String>.from(snapshot
                    .data.benefits['values']
                    .map((m) => m['display_text'])
                    .toList());

                //How To Use Medicine
                String howToUseHeader = snapshot.data.howToUse['header'];
                String howToUse = snapshot.data.howToUse['display_text'];

                //How It Works
                String howItWorksHeader = snapshot.data.howItWorks['header'];
                String howItWorks = snapshot.data.howItWorks['display_text'];

                //Safety Advices

                // Map<String, dynamic> to List<dynamic> which contains description, label, displayText
                // to get only values of safety advices Map
                List<dynamic> safetyAdvices =
                    snapshot.data.safetyAdvices['values'];

                // Divide the List based on description, label and displayText
                List<dynamic> safetyAdvDesc =
                    safetyAdvices.map((m) => m['description']).toList();
                List<dynamic> safetyAdvLabel =
                    safetyAdvices.map((m) => m['label']).toList();
                List<dynamic> safetyAdvText =
                    safetyAdvices.map((m) => m['displayText']).toList();

                // Convert them to List<String> to use this in widget build
                List<String> safetyAdviceDesc =
                    List<String>.from(safetyAdvDesc);
                List<String> safetyAdviceLabel =
                    List<String>.from(safetyAdvLabel);
                List<String> safetyAdviceText =
                    List<String>.from(safetyAdvText);

                //Forget To Take
                String forgetToTakeHeader =
                    snapshot.data.forgetToTake['header'];
                String forgetToTake = snapshot.data.forgetToTake['displayText'];

                return DrugsWidget(
                  height: height,
                  width: width,
                  name: name,
                  manufacturer: manufacturer,
                  saltComposition: saltComposition,
                  storage: storage,
                  introduction: introduction,
                  benefitsHeader: benefitsHeader,
                  benefitsTextHeader: benefitsTextHeader,
                  benefitsText: benefitsText,
                  sideEffectsHeader: sideEffectsHeader,
                  sideEffectsValues: sideEffectsValues,
                  howToUse: howToUse,
                  howToUseHeader: howToUseHeader,
                  howItWorks: howItWorks,
                  howItWorksHeader: howItWorksHeader,
                  safetyAdviceText: safetyAdviceText,
                  safetyAdviceLabel: safetyAdviceLabel,
                  safetyAdviceDesc: safetyAdviceDesc,
                  forgetToTake: forgetToTake,
                  forgetToTakeHeader: forgetToTakeHeader,
                );
              }
              if (type == '404') {
                return Scaffold(
                  backgroundColor: Color(0xffa9c729),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          width: width * 0.8,
                          child: Image.asset('images/no-data.png'),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Heading20Bold(heading: 'Data Not Found'),
                      ],
                    ),
                  ),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
