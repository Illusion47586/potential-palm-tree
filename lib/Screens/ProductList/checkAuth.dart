import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

verifyCurrentUser() async {
  bool isLoggedIn = false;
  String phoneNumber = "";
  await _auth.currentUser().then((user) {
    if (user != null) {
      print(user.phoneNumber);
      print(user.uid);
      isLoggedIn = true;
      phoneNumber = user.phoneNumber;
      return user.phoneNumber;
    } else {
      isLoggedIn = false;
      print("USER NOT SIGNED IN");
      return "";
    }
  });
  if (isLoggedIn) {
    return phoneNumber;
  } else {
    return "";
  }
}

registerNewUser() async {
  // TO BE INVOKED AT SUCCESS OF OTP VERIFICATION
  //get request('/user/:phoneNumber/new');
  // HANDLING RESPONSE OF WHETHER EXIST OR CREATED.

  var phoneNumber = await verifyCurrentUser();
  try {
    if (phoneNumber != "") {
      String url =
          'https://www.skycosmeticlenses.com/api/user/$phoneNumber/new';
      var response = await https.get(url);
      String userResponse = json.decode(response.body)["status"];
      print(userResponse);
    }
  } catch (err) {
    print(err);
  }
}

logout() async {
  await _auth.signOut().then((value) {
    print("SIGNED OUT SUCCESS");
  });
}
