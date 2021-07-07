import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skyLenses/LocalData/HomeScreen/AllProducts.dart';
import 'package:skyLenses/Screens/Cart/Blocs/cartBloc.dart';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/ShowProduct/showProduct.dart';
import 'package:skyLenses/Screens/ShowProduct/showSolution.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartInStockCard extends StatefulWidget {
  final Map<String, dynamic> cardDetails;
  CartInStockCard({this.cardDetails});

  @override
  _CartInStockCardState createState() => _CartInStockCardState();
}

class _CartInStockCardState extends State<CartInStockCard> {
  displayItemImage() {
    print("DIAPLSY CALLE");
    for (int i = 0; i < allProductsList.length; i++) {
      if (widget.cardDetails["productName"] ==
          allProductsList[i]["productName"]) {
        print(allProductsList[i]["imgUrl"]);
        return Image.asset(
          allProductsList[i]["imgUrl"],
          fit: BoxFit.cover,
        );
      } else {
        continue;
      }
    }
  }

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return widget.cardDetails["stock"] == "In Stock"
        ? Container(
            padding: EdgeInsets.only(top: 13, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.w),
              border: Border.all(width: 0.8, color: Colors.grey),
            ),
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.9549,
            height: 0.28.hp,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  margin: EdgeInsets.only(left: 10, right: 19),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CONTAINER WITH IMAGE
                        Container(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: displayItemImage(),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.cardDetails["productName"],
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "₹${widget.cardDetails["price"]}",
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                widget.cardDetails["power"] < 30
                                    ? "Power: ${widget.cardDetails["power"]}"
                                    : "Volume: ${widget.cardDetails["power"]} ml",
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                widget.cardDetails["stock"],
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[900]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () async {
                            int quantity = widget.cardDetails["quantity"] - 1;
                            var phoneNumber = await verifyCurrentUser();
                            String url =
                                'https://www.skycosmeticlenses.com/api/cart/updateCartItem/$phoneNumber/${widget.cardDetails["productName"]}/${widget.cardDetails["power"]}/$quantity';
                            await https.get(url).then((value) {
                              widget
                                  .cardDetails["bloc"].cartEventsController.sink
                                  .add(DisplayCartItems(
                                      bloc: widget.cardDetails["bloc"]));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15.w),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(40.w),
                            ),
                            width: MediaQuery.of(context).size.height * 0.040,
                            height: MediaQuery.of(context).size.height * 0.040,
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.cardDetails["quantity"].toString(),
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () async {
                            int quantity = widget.cardDetails["quantity"] + 1;
                            var phoneNumber = await verifyCurrentUser();
                            String url =
                                'https://www.skycosmeticlenses.com/api/cart/updateCartItem/$phoneNumber/${widget.cardDetails["productName"]}/${widget.cardDetails["power"]}/$quantity';
                            await https.get(url).then((value) {
                              widget
                                  .cardDetails["bloc"].cartEventsController.sink
                                  .add(DisplayCartItems(
                                      bloc: widget.cardDetails["bloc"]));
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 15.w),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(40.w),
                              ),
                              width: MediaQuery.of(context).size.height * 0.040,
                              height:
                                  MediaQuery.of(context).size.height * 0.040,
                              child: Center(
                                  child: Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.sp,
                                ),
                              ))),
                        ),
                      ]),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                // ROW CONSISTING OF BUTTONS
                Container(
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.only(bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            for (int k = 0; k < allProductsList.length; k++) {
                              if ((widget.cardDetails["productName"] ==
                                  allProductsList[k]["productName"])) {
                                if (widget.cardDetails["productName"] ==
                                    "SOLUTION") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ShowSolution()));
                                  break;
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ShowProduct(
                                              productInfo: allProductsList[k],
                                            )));
                                break;
                              }
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             ShowProduct()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width:
                                MediaQuery.of(context).size.width * 0.95 * 0.5,
                            padding: EdgeInsets.only(),
                            decoration: BoxDecoration(
                              border:
                                  Border(right: BorderSide(color: Colors.grey)),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      child: Image.asset(
                                          "assets/Cart/pngfuel.com.png",
                                          fit: BoxFit.cover)),
                                  SizedBox(width: 10),
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var phoneNumber = await verifyCurrentUser();
                          String url =
                              'https://www.skycosmeticlenses.com/api/cart/removeCartItem/$phoneNumber/${widget.cardDetails["productName"]}/${widget.cardDetails["power"]}';
                          await https.get(url).then((value) {
                            widget.cardDetails["bloc"].cartEventsController.sink
                                .add(DisplayCartItems(
                                    bloc: widget.cardDetails["bloc"]));
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.95 * 0.5,
                          padding: EdgeInsets.only(),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Center(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      child: Image.asset(
                                          "assets/Cart/removeIcon.png",
                                          fit: BoxFit.cover)),
                                  SizedBox(width: 10),
                                  Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        :
        // OUT OF STOCK CARD
        // ===========================================================================================================
        Container(
            padding: EdgeInsets.only(top: 13, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.w),
              border: Border.all(width: 0.8, color: Colors.grey),
            ),
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.9549,
            height: 350.w,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CONTAINER WITH IMAGE
                        Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Image.asset(
                              'assets/HomeScreen/duskySky/model.png',
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 18.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cardDetails["productName"].toString(),
                              style: TextStyle(
                                  fontSize: 45.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              "₹${widget.cardDetails["price"]}",
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              widget.cardDetails["power"] < 30
                                  ? "Power: ${widget.cardDetails["power"]}"
                                  : "Volume: ${widget.cardDetails["power"]} ml",
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              "Out of Stock",
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red[900]),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Transform.translate(
                          offset: Offset(0, -10),
                          child: InkWell(
                            onTap: () async {
                              var phoneNumber = await verifyCurrentUser();
                              String url =
                                  'https://www.skycosmeticlenses.com/api/cart/removeCartItem/$phoneNumber/${widget.cardDetails["productName"]}/${widget.cardDetails["power"]}';
                              await https.get(url).then((value) {
                                widget.cardDetails["bloc"].cartEventsController
                                    .sink
                                    .add(DisplayCartItems(
                                        bloc: widget.cardDetails["bloc"]));
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Image.asset(
                                'assets/Cart/removeIcon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                // ROW CONSISTING OF BUTTONS
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.w),
                      bottomRight: Radius.circular(25.w)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80.h,
                    // padding: EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: false,
                            isDismissible: true,
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 25.w),
                                    Text(
                                      'We will notify you once it is available',
                                      style: TextStyle(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 55.w, bottom: 5.w),
                                      width: 0.8.wp,
                                      height: 150.h,
                                      child: TextField(
                                        controller: emailController,
                                        cursorColor: Colors.black,
                                        cursorWidth: 2,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                            25.w,
                                          )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.sp)),
                                          hintText: 'Enter Email Address',
                                          hintStyle: TextStyle(
                                              fontSize: 35.sp,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (emailController.text != "") {
                                          var finalObject = {
                                            "power": widget.cardDetails["power"]
                                                .toString(),
                                            "productName": widget
                                                .cardDetails["productName"],
                                            "email": emailController.text,
                                          };
                                          Navigator.of(context).pop();
                                          String url =
                                              'https://www.skycosmeticlenses.com/api/general/notify';
                                          var response = await https.post(url,
                                              body: finalObject);
                                          print(json.decode(response.body));
                                        }

                                        // SEND THE MAIL ADDRESS TO DB
                                        // SUCCES SNACK BAR
                                      },
                                      child: Container(
                                        width: 0.7.wp,
                                        height: 0.06.hp,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(50.sp)),
                                        child: Center(
                                          child: Text(
                                            'Notify Me',
                                            style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: ClipRRect(
                        child: Container(
                          color: Color(0xffE35109),
                          child: Center(
                            child: Text(
                              'Notify Me',
                              style: TextStyle(
                                  fontSize: 35.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
