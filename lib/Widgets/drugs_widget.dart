import 'package:flutter/material.dart';
import 'details_screen_widgets.dart';

class DrugsWidget extends StatelessWidget {
  const DrugsWidget({
    Key key,
    @required this.height,
    @required this.width,
    @required this.name,
    @required this.manufacturer,
    @required this.saltComposition,
    @required this.storage,
    @required this.introduction,
    @required this.benefitsHeader,
    @required this.benefitsTextHeader,
    @required this.benefitsText,
    @required this.sideEffectsHeader,
    @required this.sideEffectsValues,
    @required this.howToUse,
    @required this.howToUseHeader,
    @required this.howItWorks,
    @required this.howItWorksHeader,
    @required this.safetyAdviceText,
    @required this.safetyAdviceLabel,
    @required this.safetyAdviceDesc,
    @required this.forgetToTake,
    @required this.forgetToTakeHeader,
  }) : super(key: key);

  final double height;
  final double width;
  final String name;
  final String manufacturer;
  final String saltComposition;
  final String storage;
  final String introduction;
  final String benefitsHeader;
  final List<String> benefitsTextHeader;
  final List<String> benefitsText;
  final String sideEffectsHeader;
  final List<String> sideEffectsValues;
  final String howToUse;
  final String howToUseHeader;
  final String howItWorks;
  final String howItWorksHeader;
  final List<String> safetyAdviceText;
  final List<String> safetyAdviceLabel;
  final List<String> safetyAdviceDesc;
  final String forgetToTake;
  final String forgetToTakeHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
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
            radius: Radius.circular(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GeneralDetailsList(
                    manufacturer: manufacturer,
                    saltComposition: saltComposition,
                    storage: storage,
                    height: height,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      HeadAndTextCard(
                        height: height,
                        content: introduction,
                        heading: 'INTRODUCTION',
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      BenefitsWidget(
                        name: name,
                        height: height,
                        header: benefitsHeader,
                        textHeader: benefitsTextHeader,
                        text: benefitsText,
                        width: width,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      SideEffectsWidget(
                        height: height,
                        // text: sideEffectsText,
                        header: sideEffectsHeader,
                        values: sideEffectsValues,
                        width: width,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      HeadAndTextCard(
                        height: height,
                        content: howToUse,
                        heading: howToUseHeader.toUpperCase(),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      HeadAndTextCard(
                        height: height,
                        content: howItWorks,
                        heading: howItWorksHeader.toUpperCase(),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          child: Column(
                            children: [
                              Heading20Bold(
                                heading: 'SAFETY ADVICES',
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              SafetyAdviceListWidget(
                                text: safetyAdviceText,
                                height: height,
                                label: safetyAdviceLabel,
                                description: safetyAdviceDesc,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      HeadAndTextCard(
                        height: height,
                        content: forgetToTake,
                        heading: forgetToTakeHeader.toUpperCase(),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
