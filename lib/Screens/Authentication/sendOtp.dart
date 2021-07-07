import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyLenses/Screens/Authentication/OtpVerify.dart';
import 'package:skyLenses/Services/Authentication/phonemediumAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'We will send you an ',
                            style: TextStyle(
                                color: Colors.black, fontSize: 40.sp)),
                        TextSpan(
                            text: 'One Time Password ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp)),
                        TextSpan(
                            text: 'on this mobile number',
                            style: TextStyle(
                                color: Colors.black, fontSize: 40.sp)),
                      ]),
                    ),
                  ),
                  Container(
                    height: 80.w,
                    constraints: BoxConstraints(maxWidth: 0.8.wp),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 25.w),
                    child: CupertinoTextField(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.w))),
                      controller: phoneController,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      style: TextStyle(fontSize: 30.sp, color: Colors.black),
                      placeholder: 'eg. 9871511555',
                      placeholderStyle: TextStyle(
                          fontSize: 30.sp,
                          color: CupertinoColors.placeholderText),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: BoxConstraints(maxWidth: 0.8.wp),
                    child: RaisedButton(
                      onPressed: () {
                        if (phoneController.text != "" &&
                            phoneController.text.length == 10) {
                          verifyPhoneNumber(context, phoneController.text);
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Otp(
                                email: "",
                              ),
                            ),
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: Text("Please Enter a valid Phone Number",
                                style: TextStyle(fontSize: 40.sp)),
                            backgroundColor: Colors.red,
                            duration: Duration(milliseconds: 800),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          // SHOW SNACK BAR
                          // PLEASE ENTER A Valid Number
                        }
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(35.w))),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.w, horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.sp,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 40.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
