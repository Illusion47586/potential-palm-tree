import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReferAFriend extends StatefulWidget {
  @override
  _ReferAFriendState createState() => _ReferAFriendState();
}

class _ReferAFriendState extends State<ReferAFriend> {


  Future<String> getReferralCode() async {
    return await verifyCurrentUser();
  } 

  @override
  Widget build(BuildContext context) {
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
        child: FittedBox(
          child: Container(
            margin: EdgeInsets.only(left: 17.w, right: 17.w),
            width: 1.wp,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Text('Love Sky Lenses ? Let your friends know',
                    style:
                        TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.w),
                  child: Text(
                    'Share Sky lenses app to gift your friends an awesome experience and shop exclusive cosmetic lenses.',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.w),
                  child: Text(
                    'Share your referral code with anyone and get coupons worth Rs 300.',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ),
                Container(
                    width: 100.wp,
                    margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.w),
                    child: Text(
                      'Your Referral Code',
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.w500),
                    )),
                FutureBuilder(
                  future: getReferralCode(),
                  initialData: "",
                  builder: (context, snapshot) {
                    return Container(
                      width: 100.wp,
                      margin:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                      child: Text(
                        snapshot.data,
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    );
                  },
                ),
                Container(
                  width: 100.wp,
                  height: 0.4.hp,
                  margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                  child: Image.asset(
                    'assets/share.png',
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
