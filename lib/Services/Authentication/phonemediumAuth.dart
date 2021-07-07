import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String globalVerificationId = '';
final FirebaseAuth _auth = FirebaseAuth.instance;
verifyPhoneNumber(BuildContext context, String phone) async {
  String phoneNumber = "+91" + phone;

  await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 20),
      verificationCompleted: (authCredential) =>
          _verificationComplete(authCredential, context),
      verificationFailed: (authException) =>
          _verificationFailed(authException, context),
      codeAutoRetrievalTimeout: (verificationId) =>
          _codeAutoRetrievalTimeout(verificationId),
      // called when the SMS code is sent
      codeSent: (verificationId, [code]) =>
          _smsCodeSent(verificationId, [code]));
}

/// will get an AuthCredential object that will help with logging into Firebase.
_verificationComplete(AuthCredential authCredential, BuildContext context) {
      HomePage.currentIndex = 0;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
    // REGISTERING NEW USE
    // ===================
    registerNewUser();
    // ====================
    print("AUTH SUCCESSFUL");
  });
}

_smsCodeSent(
  String verificationId,
  List<int> code,
) {
  // set the verification code so that we can use it to log the user in
  String _smsVerificationCode = verificationId;
  globalVerificationId = verificationId;
}

_verificationFailed(AuthException authException, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(authException.message.toString(),
        style: TextStyle(fontSize: 40.sp)),
    backgroundColor: Colors.red,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

_codeAutoRetrievalTimeout(String verificationId) {
  // set the verification code so that we can use it to log the user in
  String _smsVerificationCode = verificationId;
}

// VERIFICATIN OF SMS CODE
void signInWithPhoneNumber(String smsCode, context) async {
  AuthCredential _authCredential = PhoneAuthProvider.getCredential(
      verificationId: globalVerificationId, smsCode: smsCode);
  _auth
      .signInWithCredential(_authCredential)
      .then((AuthResult authResult) async {
    HomePage.currentIndex = 0;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    print("AUTH SUCCESSFUL");
    // REGISTERING NEW USE
    // ===================
    registerNewUser();
    // ====================
    print(authResult);
  }).catchError((error) {
    final snackBar = SnackBar(
      content: Text("Incorrect OTP", style: TextStyle(fontSize: 40.sp)),
      backgroundColor: Colors.red,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  });
}
