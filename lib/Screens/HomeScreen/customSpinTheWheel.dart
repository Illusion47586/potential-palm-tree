import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSpinTheWheel extends StatefulWidget {
  final BuildContext context;
  final SpinWheelBloc bloc;
  CustomSpinTheWheel({this.context, this.bloc});
  @override
  _CustomSpinTheWheelState createState() => _CustomSpinTheWheelState();
}

class _CustomSpinTheWheelState extends State<CustomSpinTheWheel>
    with SingleTickerProviderStateMixin {
  Animation<double> angle;
  int globalRandomNumber;
  AnimationController animationController;

  // Coupon added SuccessFully.
  // You have already availed the offer.

  final successSnackBar = SnackBar(
    content:
        Text("Coupon awarded successfully", style: TextStyle(fontSize: 40.sp)),
    backgroundColor: Colors.black,
    duration: Duration(milliseconds: 700),
  );
  final disabledSnackBar = SnackBar(
    content: Text("You have already availed the offer.",
        style: TextStyle(fontSize: 40.sp)),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    angle = Tween<double>(
      begin: 10 * pi,
      end: 20 * pi + randomNumberGenerator() * (pi / 3),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    ));
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.bloc.spinEventsController.sink.add(DisableUserWheel());
        fortuneCoupon(globalRandomNumber);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.w)),
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Congratulations !!',
                      style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.22,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Text(
                          'You have won',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5),
                        Text(
                          displayReward(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 38.sp,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(child: SizedBox(height: 0)),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            widget.bloc.spinEventsController.sink
                                .add(CheckIsSpinEnabled());
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'DISMISS',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.w)),
                            width: double.infinity,
                            height:
                                MediaQuery.of(context).size.height * 0.2 * 0.28,
                          ),
                        )
                      ],
                    ),
                  ));
            });
      }
    });
  }

  String displayReward() {
    if (globalRandomNumber == 0) {
      return 'On Purchase of Rs 5000 get Rs 1000 off';
    } else if (globalRandomNumber == 1) {
      return '200 Coins in your wallet';
    } else if (globalRandomNumber == 2) {
      return '2 Coupons of Rs 100 Each';
    } else if (globalRandomNumber == 3) {
      return 'On Purchase of Rs 3500 get Rs 500 off';
    } else if (globalRandomNumber == 4) {
      return 'Buy 3 pair of lenses get 1 pair of lenses free';
    } else {
      return '4 coupons of Rs 50 each';
    }
  }

  double randomNumberGenerator() {
    Random random = new Random();
    int randomNumber = random.nextInt(6);
    // print((randomNumber + 1).toString());
    // fortuneCoupon(randomNumber + 1);
    globalRandomNumber = randomNumber + 1;
    return double.parse((randomNumber + 1).toString());
  }

  fortuneCoupon(int fortuneNumber) {
    print("FORTUNECOUPPONCALLED");
    widget.bloc.spinEventsController.sink
        .add(GenerateCoupon(fortuneScore: fortuneNumber));
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.spinEventsController.sink.add(CheckIsSpinEnabled());
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        // height: MediaQuery.of(context).size.height * 0.8,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: angle != null ? angle.value : 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/HomeScreen/bigSpinning.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, -MediaQuery.of(context).size.height * 0.046),
                child: InkWell(
                  onTap: () {
                    // animationController.forward();
                  },
                  child: Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: Image.asset(
                      'assets/HomeScreen/pointer.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                // offset: Offset(-MediaQuery.of(context).size.width * 0.01, 0),
                offset: Offset(0, 0),
                child: InkWell(
                  onTap: () {
                    animationController.forward();
                  },
                  child: Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.18,
                    child: Image.asset(
                      'assets/HomeScreen/spinCenterRevised.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// =============================================================================
// =============================================================================
// BLOC CODE
// =============================================================================
//==============================================================================

abstract class SpinWheelEvents {}

class GenerateCoupon extends SpinWheelEvents {
  final int fortuneScore;
  GenerateCoupon({this.fortuneScore});
}

class CheckIsSpinEnabled extends SpinWheelEvents {}

class DisableUserWheel extends SpinWheelEvents {}

class SpinWheelBloc {
  final spinEventsController = StreamController<SpinWheelEvents>.broadcast();
  final isSpinEnabledController = StreamController<bool>.broadcast();

  SpinWheelBloc() {
    spinEventsController.stream.listen(_mapEventsToState);
  }

  void _mapEventsToState(event) {
    if (event is GenerateCoupon) {
      generateCoupon(event.fortuneScore);
    }
    if (event is CheckIsSpinEnabled) {
      checkEnabled();
    }
    if (event is DisableUserWheel) {
      disableWheel();
    }
  }

  generateCoupon(int score) async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/user/$phoneNumber/${score + 1}/fortuneWheel';
    try {
      var response = await https.get(url);
      var awardedResponse = json.decode(response.body)["status"];
      print(awardedResponse.toString());
    } catch (err) {
      print(err);
    }
  }

  Future<bool> checkEnabled() async {
    var phoneNumber = await verifyCurrentUser();
    if (phoneNumber == "") {
      isSpinEnabledController.sink.add(false);
      return false;
    } else {
      String url =
          'https://www.skycosmeticlenses.com/api/general/$phoneNumber/checkSpinEnabled';
      try {
        var response = await https.get(url);
        bool isEnabled = json.decode(response.body)["isSpinEnabled"];
        isSpinEnabledController.sink.add(isEnabled);
        return isEnabled;
      } catch (err) {
        print(err);
        isSpinEnabledController.sink.add(true);
        return false;
      }
    }
  }

  disableWheel() async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/user/$phoneNumber/disableWheel';
    try {
      var response = await https.get(url);
      bool isEnabled = json.decode(response.body)["isSpinEnabled"];
    } catch (err) {
      print(err);
    }
  }

  void dispose() {
    spinEventsController.close();
    isSpinEnabledController.close();
  }
}
