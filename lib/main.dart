import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_granta/screens/main_screen.dart';
import 'package:medi_granta/screens/process_screen.dart';
import 'screens/home_screen.dart';

void main() {
  // runApp(DevicePreview(builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.merriweather().fontFamily),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
