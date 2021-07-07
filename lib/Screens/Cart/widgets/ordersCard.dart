import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/LocalData/HomeScreen/AllProducts.dart';
import 'package:skyLenses/Screens/Checkout/checkoutScreen.dart';

abstract class OrderEvents {}

class CancelOrder extends OrderEvents {
  final String order_id;
  final BuildContext context;
  CancelOrder({this.order_id, this.context});
}

class OrderBloc {
  final orderEventsController = StreamController<OrderEvents>.broadcast();
  final cancelOrderMessageController = StreamController<String>.broadcast();

  OrderBloc() {
    orderEventsController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(OrderEvents event) {
    if (event is CancelOrder) {
      cancelOrder(event.order_id, event.context);
    }
  }

  cancelOrder(String order_id, BuildContext context) async {
    print(order_id);
    String url =
        'https://www.skycosmeticlenses.com/api/orders/cancelOrder/${order_id}';
    var response = await https.post(url);
    var responseBody = json.decode(response.body);
    if (responseBody["status_code"] == 200) {
      cancelOrderMessageController.sink.add(responseBody["message"]);
      print(responseBody["message"]);
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        title: "Attention!",
        message: responseBody["message"],
        duration: Duration(seconds: 3),
        isDismissible: true,
      )..show(context);
    } else {
      cancelOrderMessageController.sink.add(responseBody["message"]);
      print(responseBody["message"]);
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        title: "Attention!",
        message: responseBody["message"],
        duration: Duration(seconds: 3),
        isDismissible: true,
      )..show(context);
    }
  }

  void dispose() {
    orderEventsController.close();
    cancelOrderMessageController.close();
  }
}

// ===============================================================

class OrderCard extends StatefulWidget {
  final Map<dynamic, dynamic> orderDetails;
  OrderCard({this.orderDetails});
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final cancelSnackBar = SnackBar(
    content: Text("orderedCACNEL",
        style: TextStyle(
          fontSize: 35.sp,
        )),
    backgroundColor: Colors.green,
    duration: Duration(milliseconds: 700),
  );

  final bloc = OrderBloc();
  displayItemImage() {
    print("DIAPLSY CALLED");
    for (int i = 0; i < allProductsList.length; i++) {
      if (widget.orderDetails["products"][0]["itemObject"]["productName"] ==
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

  createmonth(String montha, String monthb) {
    int month1 = int.parse(montha);
    int month2 = int.parse(monthb);

    int totalMonth = month1 * 10 + month2 - 1;

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
      return monthList[totalMonth];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13, left: 0, right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.8, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 9, right: 9, top: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 5.w),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              // CONTAINER WITH IMAGE
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: displayItemImage()),
              SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      widget.orderDetails["products"].length == 1
                          ? "${widget.orderDetails["products"][0]["itemObject"]["productName"]}"
                          : "${widget.orderDetails["products"][0]["itemObject"]["productName"]} & ${widget.orderDetails["products"].length - 1} others",
                      style: TextStyle(
                          fontSize: 32.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    "₹${widget.orderDetails["amount"]}",
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        "${widget.orderDetails["status"]}",
                        style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[900]),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "${widget.orderDetails["order_date"][8]}${widget.orderDetails["order_date"][9]} ${createmonth(widget.orderDetails["order_date"][5], widget.orderDetails["order_date"][6])} ${widget.orderDetails["order_date"][0]}${widget.orderDetails["order_date"][1]}${widget.orderDetails["order_date"][2]}${widget.orderDetails["order_date"][3]}",
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              if (widget.orderDetails["status"] == "Ordered") {
                bloc.orderEventsController.sink.add(
                  CancelOrder(
                    order_id: widget.orderDetails['order_id'],
                    context: context,
                  ),
                );
              }
            },
            child: Opacity(
              opacity: widget.orderDetails["status"] == "Ordered" ? 1 : 0.5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(right: 20.w),
                padding: EdgeInsets.all(10.w),
                child: Text(
                  "Cancel",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          // ROW CONSISTING OF BUTTONS
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // ORDER ITEMS LIST
                      List<Map<String, dynamic>> orderInfoList = List.generate(
                          widget.orderDetails["products"].length, (index) {
                        for (int j = 0; j < allProductsList.length; j++) {
                          if (allProductsList[j]["productName"] ==
                              widget.orderDetails["products"][index]
                                  ["itemObject"]["productName"]) {
                            return allProductsList[j];
                          }
                        }
                      });
                      // ORDER ITEMS POWER LIST

                      List<dynamic> buyPowersList = [];
                      buyPowersList = List.generate(
                          widget.orderDetails["products"].length, (index) {
                        return widget.orderDetails["products"][index]
                            ["itemObject"]["power"];
                      });
                      print(buyPowersList);
                      // QUANTITY LIST

                      List<dynamic> buyQuantityList = [];
                      buyQuantityList = List.generate(
                          widget.orderDetails["products"].length, (index) {
                        return widget.orderDetails["products"][index]
                            ["itemObject"]["quantity"];
                      });
                      print(buyQuantityList);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CheckoutScreen(
                            buyNowQuantity: buyQuantityList,
                            buyNowPower: buyPowersList,
                            isBuyNow: true,
                            productInfo: orderInfoList,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width - 20,
                      padding: EdgeInsets.only(),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'Repeat Order',
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
