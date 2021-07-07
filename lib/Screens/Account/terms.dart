import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditions extends StatefulWidget {
  TermsConditions({Key key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Terms And Conditions",
            style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.034,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Text(
              'PLEASE NOTE: You must read and agree to all our terms and conditions before placing an order. We will not be accountable for any infections or any problems to your eyes that are caused especially if you have misused the product. Lens infections can take place. If any infections or damages are caused, Sky cosmetic lenses will not be responsible for. It is important that you take full care of the lens as it is very important. You must be 18 or above to purchase lenses from us. If you have any questions you’d like to ask, don’t hesitate to contact us on our email id ',
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
        ],
      ),
    );
  }
}
