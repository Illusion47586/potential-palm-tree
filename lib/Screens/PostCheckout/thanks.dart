import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThanksScreen extends StatefulWidget {
  ThanksScreen({Key key}) : super(key: key);

  @override
  _ThanksScreenState createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child:
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 45.sp)),
          backgroundColor: Color(0xff4BB543),
          brightness: Brightness.dark,
          title: Text('THANK YOU',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.sp,
              )),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff4BB543),
              child: Center(
                child: Container(
                  width: 0.4.wp,
                  height: 0.4.wp,
                  child: Center(
                    child: Image.asset(
                      'assets/Cart/smile.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 20.w,
          ),
          Text('Your Order has Been Placed!',
              style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 30.w),
          Container(
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 20.w, top: 30.w),
            child: Text(
              'Congratulations !\n You have won 200 coins in your wallet',
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0000CD)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.w),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 20.w, top: 30.w),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.w)),
              color: Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text(
                'Continue Shopping',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 40.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.w),
          Text('Happy Shopping!!',
              style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w400)),
        ]));
  }
}
