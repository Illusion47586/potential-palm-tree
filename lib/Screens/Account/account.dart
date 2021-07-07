import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Account/privacyPolicy.dart';
import 'package:skyLenses/Screens/Account/redeemACode.dart';
import 'package:skyLenses/Screens/Account/referAFriend.dart';
import 'package:skyLenses/Screens/Account/returnPolicy.dart';
import 'package:skyLenses/Screens/Account/terms.dart';
import 'package:skyLenses/Screens/Authentication/sendOtp.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: verifyCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2,
            ));
          } else {
            if (snapshot.data != "") {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (BuildContext context) =>
                      //                 PostCheckout()));
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(
                      //       top: MediaQuery.of(context).size.height * 0.03,
                      //     ),
                      //     padding: EdgeInsets.only(
                      //       top: 15,
                      //       bottom: 15,
                      //       left: 10,
                      //       right: 10,
                      //     ),
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(color: Colors.white),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           "Shipping Address",
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w500,
                      //             fontSize:
                      //                 MediaQuery.of(context).size.height * 0.03,
                      //           ),
                      //         ),
                      //         Icon(Icons.arrow_forward_ios),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ReturnPolicy()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                            bottom: 15,
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Return Policy",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TermsConditions()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Terms and Conditions",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PrivacyPolicy()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ReferAFriend()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Refer a Friend",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RedeemACode()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Redeem a Referral Code",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          logout();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 10,
                            right: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return LoginPage();
            }
          }
        });
  }
}
