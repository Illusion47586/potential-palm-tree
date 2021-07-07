import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skyLenses/Screens/SplashScreen.dart';
import './Theme/Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme().copyWith(
          bodyText2: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          bodyText1: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          headline1: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          button: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          headline2: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          headline3: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          headline5: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          headline4: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          headline6: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          subtitle1: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
          subtitle2: GoogleFonts.nunito(textStyle: textTheme.bodyText1),
        ),
        // bodyText2: TextStyle(fontFamily: 'Avenir')),
        accentColor: white, 
        primaryColor: white,
      ),
    );
  }
}
