import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';
import 'package:http/http.dart' as https;

String globalProductPrice;
String globalSolutionPrice60;
String globalSolutionPrice120;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToHome() async {
    // GETTING PRODUCT PRICE
    String url =
        'https://www.skycosmeticlenses.com/api/product/MERMAID/getPrice';
    try {
      var response = await https.get(url);
      String fetchedPrice = json.decode(response.body)["price"].toString();
      globalProductPrice = fetchedPrice;
    } catch (err) {}
    // GETTING PRODUCT PRICE
    String solutionUrl =
        'https://www.skycosmeticlenses.com/api/product/SOLUTION/getPrice';
    try {
      var response = await https.get(solutionUrl);
      String fetchedPrice2 = json.decode(response.body)["price"].toString();
      globalSolutionPrice60 = fetchedPrice2;
    } catch (err) {}

    // GETTING PRODUCT PRICE
    // String solution2Url =
    //     'https://www.skycosmeticlenses.com/api/product/MERMAID/getPrice';
    // try {
    //   var response = await https.get(url);
    //   String fetchedPrice = json.decode(response.body)["price"].toString();
    //   globalProductPrice = fetchedPrice;
    // } catch (err) {
    //   print(err);
    // }

    Timer(Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    "assets/SplashScreen/skyLogo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset(
                    "assets/SplashScreen/boxCover.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
