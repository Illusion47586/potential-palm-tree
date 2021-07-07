import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/LocalData/HomeScreen/AllProducts.dart';

class ProductCheckoutCard extends StatefulWidget {
  final String productName;
  final String stock;
  final int quantity;
  final String power;
  final int price;
  ProductCheckoutCard(
      {this.productName, this.stock, this.quantity, this.power, this.price});
  @override
  _ProductCheckoutCardState createState() => _ProductCheckoutCardState();
}

class _ProductCheckoutCardState extends State<ProductCheckoutCard> {
  displayItemImage() {
    for (int i = 0; i < allProductsList.length; i++) {
      if (widget.productName == allProductsList[i]["productName"]) {
        return Image.asset(
          allProductsList[i]["imgUrl"],
          fit: BoxFit.cover,
        );
      } else {
        continue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.power);
    return widget.stock == "In Stock"
        ? Container(
            padding:
                EdgeInsets.only(top: 25.h, left: 0, right: 0, bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w),
              border: Border.all(width: 0.8, color: Colors.grey),
            ),
            margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 19),
                  child: Row(children: [
                    // CONTAINER WITH IMAGE
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: displayItemImage(),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 6),
                        Text(
                          (double.parse(widget.power) < 30)
                              ? "Power: ${widget.power}"
                              : "Volume: ${widget.power} ml",
                          style: TextStyle(
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Quantity: ${widget.quantity}",
                          style: TextStyle(
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () async {},
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Center(
                          child: Text(
                            "₹${widget.price.toString()}",
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.w500,
                              fontSize: 38.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          )
        : Container();
  }
}
