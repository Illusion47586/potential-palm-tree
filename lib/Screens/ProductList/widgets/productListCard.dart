import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/ShowProduct/showProduct.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListCard extends StatelessWidget {
  final Map<String, dynamic> productInfo;
  ProductListCard({this.productInfo});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
    return productInfo["alignment"] == "left"
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ShowProduct(productInfo: productInfo)));
            },
            child: Card(
              elevation: 10,
              margin: EdgeInsets.only(
                  left: 25.w, right: 25.w, bottom: 10.w, top: 20.w),
              child: Container(
                color: productInfo["color"],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.22,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        // width: 220.w,
                        height: MediaQuery.of(context).size.height * 0.22,
                        // color: Colors.black,
                        child: Image.asset(
                          productInfo["imgUrl"],
                          fit: BoxFit.cover,
                        )),
                    // Expanded(
                    //   child: SizedBox(
                    //     width: 0,
                    //   ), 
                    // ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            width: 800.w,
                            child: Text(
                              productInfo["productName"],
                              style: TextStyle(
                                  fontSize: 60.sp,
                                  color: productInfo["textColor"]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 0),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.040,
                            width: MediaQuery.of(context).size.width * 0.28,
                            margin: EdgeInsets.only(
                              top: 20,
                            ),
                            child: RaisedButton(
                              elevation: 10,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80)),
                              color: productInfo["textColor"],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ShowProduct(
                                                productInfo: productInfo)));
                              },
                              child: Text(
                                'Explore',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 29.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        // ALIGNMENT RIGHT ONWARDS
        : InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ShowProduct(productInfo: productInfo)));
            },
            child: Card(
              elevation: 10,
              margin: EdgeInsets.only(
                  left: 25.w, right: 25.w, bottom: 10.w, top: 20.w),
              child: Container(
                color: productInfo["color"],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.22,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width:
                              MediaQuery.of(context).size.width * 0.64 - 80.w,
                          child: Text(
                            productInfo["productName"],
                            style: TextStyle(
                                fontSize: 60.sp,
                                color: productInfo["textColor"]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.040,
                          width: MediaQuery.of(context).size.width * 0.28,
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          child: RaisedButton(
                            elevation: 10,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80)),
                            color: productInfo["textColor"],
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ShowProduct(
                                              productInfo: productInfo)));
                            },
                            child: Text(
                              'Explore',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 29.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          // width: 270.w,
                          height: MediaQuery.of(context).size.height * 0.22,
                          // color: Colors.black,
                          child: Image.asset(
                            productInfo["imgUrl"],
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
