import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

class RedeemACode extends StatefulWidget {
  RedeemACode({Key key}) : super(key: key);

  @override
  _RedeemACodeState createState() => _RedeemACodeState();
}

class _RedeemACodeState extends State<RedeemACode> {
  final bloc = ReferralBloc();

  @override
  Widget build(BuildContext context) {
    final TextEditingController referralCodeController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.065,
        ),
        child: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 50.sp,
              )),
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.09,
              child: Image.asset(
                "assets/SplashScreen/skyLogo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 17.w, right: 17.w),
          width: 1.wp,
          height: 0.8.hp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text('Redeem A Referral Code',
                  style:
                      TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.w),
                child: Text(
                  'Redeem a referral code and get coupons worth Rs 300.',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 55.w),
                  width: 0.8.wp,
                  height: 150.h,
                  child: TextField(
                    controller: referralCodeController,
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                        20.sp,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.sp)),
                      hintText: 'Enter Referral Code',
                      hintStyle: TextStyle(
                          fontSize: 35.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    keyboardType: TextInputType.number,
                  )),
              InkWell(
                onTap: () {
                  bloc.referralEventsController.sink.add(ApplyReferralCode(
                      referralCode: referralCodeController.text));
                },
                child: Container(
                  width: 0.7.wp,
                  height: 0.06.hp,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50.sp)),
                  child: Center(
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                  stream:
                      bloc.applyReferralController.stream.asBroadcastStream(),
                  initialData: "",
                  builder: (context, snapshot) {
                    return Container(
                        margin: EdgeInsets.only(top: 40.w),
                        child: Text(
                          snapshot.data,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ));
                  }),
              Expanded(child: SizedBox()),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.w),
                child: Text(
                  'NOTE: You can only redeem a referral code only once.',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
abstract class ReferralEvents {}

class ApplyReferralCode extends ReferralEvents {
  final String referralCode;
  ApplyReferralCode({this.referralCode});
}

class ReferralBloc {
  final referralEventsController = StreamController<ReferralEvents>.broadcast();
  final applyReferralController = StreamController<String>.broadcast();

  ReferralBloc() {
    referralEventsController.stream.listen(_mapEventsToState);
  }

  void _mapEventsToState(event) {
    if (event is ApplyReferralCode) {
      applyReferralCode(event.referralCode);
    }
  }

  applyReferralCode(referralCode) async {
    String referralMessage;
    String phone = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/user/$phone/$referralCode/redeemReferral';
    var response = await https.get(url);
    referralMessage = json.decode(response.body)["message"];

    applyReferralController.sink.add(referralMessage);
  }

  void dispose() {
    referralEventsController.close();
    applyReferralController.close();
  }
}
