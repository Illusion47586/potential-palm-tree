import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:skyLenses/Screens/HowTOUse.dart';
import 'package:skyLenses/Screens/ProductList/productList.dart';
import 'package:skyLenses/Screens/ShowProduct/showSolution.dart';
import 'package:skyLenses/Theme/Colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryTagline;
  final String imgUrl;
  final Color color1;
  final Color color2;
  final String alignment;

  CategoryCard({
    this.categoryName,
    this.categoryTagline,
    this.imgUrl,
    this.color1 = const Color(0xffD8E0F5),
    this.color2 = const Color(0xff1F1A38),
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1344), allowFontScaling: false);
    return alignment == "right"
        ? InkWell(
            onTap: () {
              if (categoryName == "Sky Solution") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ShowSolution()));
              } else if (categoryName == "How to Use ?") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HowToUse()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductList(categoryName: categoryName)));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  Positioned(
                    right: 0,
                    child: Diagonal(
                      clipHeight: 0,
                      axis: Axis.vertical,
                      position: DiagonalPosition.BOTTOM_LEFT,
                      child: Container(
                        color: color2,
                        width: 1.wp,
                        height: 0.3.hp,
                      ),
                    ),
                  ),
                  Diagonal(
                    clipHeight: 210.h,
                    axis: Axis.vertical,
                    position: DiagonalPosition.BOTTOM_RIGHT,
                    child: Container(
                      color: color1,
                      width: 570.w,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  Positioned(
                    right: 8.w,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.32,
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75.h,
                    left: 40.w,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              categoryName,
                              style: TextStyle(color: color2, fontSize: 53.sp),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: 310.w,
                            child: Text(
                              categoryTagline,
                              style: TextStyle(color: color2, fontSize: 29.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.038,
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: RaisedButton(
                              elevation: 10,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80)),
                              color: color2,
                              onPressed: () {
                                if (categoryName == "Sky Solution") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ShowSolution()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProductList(
                                                  categoryName: categoryName)));
                                }
                              },
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    'Explore',
                                    style: TextStyle(
                                        color: white, fontSize: 29.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        // FOR ALIGNMENT LEFT ONWARD HERE
        : InkWell(
            onTap: () {
              if (categoryName == "How to Use ?") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HowToUse()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductList(categoryName: categoryName)));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    child: Diagonal(
                      clipHeight: 0,
                      axis: Axis.vertical,
                      position: DiagonalPosition.BOTTOM_LEFT,
                      child: Container(
                        color: color2,
                        width: 1.wp,
                        height: 0.3.hp,
                      ),
                    ),
                  ),
                  Diagonal(
                    clipHeight: 210.w,
                    axis: Axis.vertical,
                    position: DiagonalPosition.TOP_RIGHT,
                    child: Container(
                      color: color1,
                      width: 0.55.wp,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  Positioned(
                    top: categoryName != "How to Use ?" ? 0 : 100.w,
                    left: categoryName != "How to Use ?" ? 0.03.wp : 115.w,
                    child: Container(
                      height: categoryName != "How to Use ?" ? 0.33.hp : 200.h,
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75.h,
                    right: 40.w,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              categoryName,
                              style: TextStyle(color: color1, fontSize: 53.sp),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: 310.w,
                            child: Text(
                              categoryTagline,
                              style: TextStyle(color: color1, fontSize: 29.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.038,
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: RaisedButton(
                              elevation: 10,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80)),
                              color: color1,
                              onPressed: () {
                                if (categoryName == "How to Use ?") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HowToUse()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProductList(
                                                  categoryName: categoryName)));
                                }
                              },
                              child: Text(
                                'Explore',
                                style: TextStyle(color: white, fontSize: 29.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
