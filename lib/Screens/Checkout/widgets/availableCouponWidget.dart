import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableCouponsCard extends StatelessWidget {
  final Map<dynamic, dynamic> couponCardDetails;
  final TextEditingController promoController;

  final Function applyPromoFunction;
  AvailableCouponsCard(
      {this.couponCardDetails, this.promoController, this.applyPromoFunction});

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
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: Colors.white,
                border: Border.all(width: 1.2.w, color: Colors.black)),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Discount: Rs ${couponCardDetails["value"]}",
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.w500)),
                  SizedBox(height: 10.w),
                  Text(
                    "Validity: ${createDateObject().day} ${createmonth(createDateObject().month)} ${createDateObject().year}",
                    style: TextStyle(fontSize: 38.sp),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    "${couponCardDetails["timesUsabale"]} Left",
                    style: TextStyle(fontSize: 38.sp),
                  ),
                ]),
                Container(
                  width: 200.w,
                  height: 0.06.hp,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.w)),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                        applyPromoFunction(
                            couponCardDetails["couponCode"].toString());
                      },
                      child: FittedBox(
                        child: Text(
                          'Apply',
                          style:
                              TextStyle(color: Colors.white, fontSize: 34.sp),
                        ),
                      )),
                )
              ],
            ),
          )
        : Container();
  }
}
