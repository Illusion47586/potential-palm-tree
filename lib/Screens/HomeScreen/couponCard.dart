import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponsCard extends StatelessWidget {
  final Map<dynamic, dynamic> couponCardDetails;
  CouponsCard({this.couponCardDetails});

  createmonth(int month) {
    List<String> monthList = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    for (int i = 0; i < monthList.length; i++) {
      return monthList[month];
    }
  }

  DateTime createDateObject() {
    return DateTime.parse(couponCardDetails["validTill"]);
  }

  @override
  Widget build(BuildContext context) {
    return couponCardDetails["isVisible"]
        ? Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff016064),
                border: Border.all(
                  width: 1.2,
                  color: Color(0xff016064),
                )),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Discount: Rs ${couponCardDetails["value"]}",
                      style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  SizedBox(height: 7),
                  Text(
                    "Validity: ${createDateObject().day} ${createmonth(createDateObject().month)} ${createDateObject().year}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "Min Order: ${couponCardDetails["validAbove"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                    ),
                  ),
                ]),
              ],
            ),
          )
        : Container();
  }
}
