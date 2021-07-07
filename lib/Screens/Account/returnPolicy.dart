import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReturnPolicy extends StatefulWidget {
  ReturnPolicy({Key key}) : super(key: key);

  @override
  _ReturnPolicyState createState() => _ReturnPolicyState();
}

class _ReturnPolicyState extends State<ReturnPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            Text(
              "Return policy",
              style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.026,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                'There is a non return policy on all the products purchased, however, if you have been sent an incorrect or any damaged goods, you must get in touch with us via email within 7 days of purchase. Our email address is: ',
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15, top: 2),
              child: Text(
                'skycosmeticlenses@gmail.com',
                style: TextStyle(fontSize: 39.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.026,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                'Please use the subject line INCORRECT LENSES/DAMAGED and include your order number. We may ask for evidence for damaged products received. Products must be returned unused in its original packaging. We do not cover any return shipping charges.',
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.026,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                'PLEASE NOTE: Lenses cannot be exchanged if you decide you have changed your mind, therefore, please make your decision carefully before placing an order.',
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.026,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                'ORDER CANCELLATION: If you decide to cancel your order, we will consider it however, this is not guaranteed. Our aim is to dispatch orders as quickly as possible and therefore cannot cancel orders once they have been dispatched.',
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.026,
            ),
          ],
        ),
      ),
    );
  }
}
