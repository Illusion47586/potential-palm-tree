import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyLenses/LocalData/powerList.dart';
import 'package:skyLenses/Screens/Checkout/checkoutScreen.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';
import 'package:skyLenses/Screens/ShowProduct/BLocs/showBloc.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/Screens/ShowProduct/enlargeImage.dart';

class ShowProduct extends StatefulWidget {
  final Map<String, dynamic> productInfo;
  ShowProduct({this.productInfo});
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  bool isPowerCollapsed = true;
  bool isDetailsCollapsed = false;
  bool isSafetyCollapsed = false;
  bool isInStock;
  double selectedPower;
  final loginErrorSnackBar = SnackBar(
    content: Text("Please sign in/sign up your account",
        style: TextStyle(
          fontSize: 35.sp,
        )),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );
  final successSnackBar = SnackBar(
    content: Text("Product Added to Cart",
        style: TextStyle(
          fontSize: 35.sp,
        )),
    backgroundColor: Colors.green,
    duration: Duration(milliseconds: 700),
  );
  final selectPowerSnackBar = SnackBar(
    content: Text("Please select a Power",
        style: TextStyle(
          fontSize: 35.sp,
        )),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );
  final cannotAddToCartSnackBar = SnackBar(
    content: Text("Cannot Add To Cart",
        style: TextStyle(
          fontSize: 35.sp,
        )),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );
  final cannotBuyNowSnackBar = SnackBar(
    content: Text("Out of Stock",
        style: TextStyle(
          fontSize: 35.sp,
        )),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );
  final bloc = ShowProductBloc();

  @override
  void initState() {
    super.initState();
    bloc.showProductEventController.add(GetProductPrice());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.07.hp),
          child: AppBar(
            brightness: Brightness.dark,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 0.035.hp,
              ),
            ),
            title: Text(widget.productInfo["productName"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.sp,
                )),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  HomePage.currentIndex = 2;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
                child: Container(
                  width: 60.w,
                  margin: EdgeInsets.only(right: 10.w, top: 16.w),
                  child: InkWell(
                    onTap: () {
                      HomePage.currentIndex = 2;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()));
                    },
                    child: FaIcon(
                      FontAwesomeIcons.shoppingBag,
                      color: Colors.white,
                      size: 0.035.hp,
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: widget.productInfo["color"],
            elevation: 0,
          ),
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CONTAINER CONSISTNG OF PRODUCT IMAGES
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  color: widget.productInfo["color"],
                  child: Carousel(
                    indicatorBgPadding: 0,
                    dotSize: 3,
                    dotIncreaseSize: 2,
                    // showIndicator: false,
                    images: [
                      for (int i = 0;
                          i < widget.productInfo["productImages"].length;
                          i++)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => EnlargeImage(
                                  imgUrl: widget.productInfo["productImages"]
                                      [i],
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                              widget.productInfo["productImages"][i]),
                        ),
                    ],
                  ),
                ),
                // CONTAINER CONSISITING OF PRODUCT NAME
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    widget.productInfo["productName"],
                    style: TextStyle(
                      color: widget.productInfo["textColor"],
                      fontSize: 58.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // CONTAINER CONSISISTING OF PRICE
                StreamBuilder(
                    initialData: "",
                    stream:
                        bloc.productPriceController.stream.asBroadcastStream(),
                    builder: (context, productPrice) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          '₹' + productPrice.data,
                          style: TextStyle(
                            color: widget.productInfo["textColor"],
                            fontSize: 48.sp,
                          ),
                        ),
                      );
                    }),
                // CONTAINER CONTAINING STOCK MESSAGE
                StreamBuilder<Object>(
                    initialData: "",
                    stream:
                        bloc.stockMessageController.stream.asBroadcastStream(),
                    builder: (context, stockMessage) {
                      if (stockMessage.data == "In Stock") {
                        isInStock = true;
                      } else if (stockMessage.data == "Out of Stock") {
                        isInStock = false;
                      }
                      return Container(
                        margin: stockMessage.data != ""
                            ? EdgeInsets.only(
                                top: 15,
                                bottom: 10,
                              )
                            : EdgeInsets.only(top: 0, bottom: 0),
                        child: Text(stockMessage.data,
                            style: TextStyle(
                              fontSize: 48.sp,
                              color: stockMessage.data == "Out of Stock"
                                  ? Colors.red
                                  : Colors.green[900],
                              fontWeight: FontWeight.bold,
                            )),
                      );
                    }),
                // CONTAINER CONSITS OF POWER HEADING DROPDOWN
                InkWell(
                  onTap: () {
                    isPowerCollapsed = !isPowerCollapsed;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    color: widget.productInfo["textColor"],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            selectedPower == null
                                ? "POWER"
                                : selectedPower.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: !isPowerCollapsed
                                ? Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                    size: 0.035.hp,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 0.035.hp,
                                  ))
                      ],
                    ),
                  ),
                ),
                // POWER CONTAING CONTAINER
                !isPowerCollapsed
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(powerList.length, (index) {
                              return InkWell(
                                onTap: () {
                                  selectedPower = powerList[index];
                                  // CHECKING FOR AVAILABLE QUANTITY
                                  bloc.showProductEventController.add(
                                      StockMessage(
                                          selectedPower: selectedPower,
                                          productName: widget
                                              .productInfo["productName"]));
                                  // ============================================

                                  isPowerCollapsed = !isPowerCollapsed;
                                  setState(() {});
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      powerList[index].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    : Container(),
                // CONTAINER OF ROW HAVEING 2 BUTTONS
                Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Color(0xffF4F8F8),
                              border: Border.all(
                                  color: widget.productInfo["textColor"])),
                          child: RaisedButton(
                              padding: EdgeInsets.all(0),
                              color: Color(0xffF4F8F8),
                              elevation: 0,
                              onPressed: () async {
                                setState(() {});
                                if (selectedPower != null) {
                                  if ((isInStock != null) &&
                                      (isInStock != false)) {
                                    if (await verifyCurrentUser() == "") {
                                      Scaffold.of(context)
                                          .showSnackBar(loginErrorSnackBar);
                                    } else {
                                      bloc.showProductEventController.sink.add(
                                          AddToCart(
                                              productInfo: widget.productInfo,
                                              selectedPower: selectedPower));
                                      Scaffold.of(context)
                                          .showSnackBar(successSnackBar);
                                    }
                                  } else {
                                    Scaffold.of(context)
                                        .showSnackBar(cannotBuyNowSnackBar);
                                  }
                                } else {
                                  Scaffold.of(context)
                                      .showSnackBar(selectPowerSnackBar);
                                }
                              },
                              child: Text(
                                'Add To Bag',
                                style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 38.sp,
                                    fontWeight: FontWeight.bold),
                              ))),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: widget.productInfo["textColor"],
                              border: Border.all(
                                  color: widget.productInfo["textColor"])),
                          child: RaisedButton(
                              padding: EdgeInsets.all(0),
                              color: widget.productInfo["textColor"],
                              elevation: 0,
                              onPressed: () async {
                                setState(() {});
                                if (selectedPower != null) {
                                  if (isInStock != null &&
                                      (isInStock != false)) {
                                    if (await verifyCurrentUser() == "") {
                                      Scaffold.of(context)
                                          .showSnackBar(loginErrorSnackBar);
                                    } else {
                                      widget.productInfo["selectedPower"] =
                                          selectedPower;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CheckoutScreen(
                                            buyNowPower: [selectedPower],
                                            buyNowQuantity: [1],
                                            isBuyNow: true,
                                            productInfo: [widget.productInfo],
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    Scaffold.of(context)
                                        .showSnackBar(cannotBuyNowSnackBar);
                                  }
                                } else {
                                  Scaffold.of(context)
                                      .showSnackBar(selectPowerSnackBar);
                                }
                              },
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 38.sp,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ],
                  ),
                ),
                // CONTAINER CONSISTING OF DESCRIPTION
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Text(
                    widget.productInfo["productDescription"],
                    style: TextStyle(
                        color: widget.productInfo["textColor"],
                        fontSize: 35.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                // CONTAINER OF  HEADING CONTENTS(PRODUCT DESCRIPTION)
                InkWell(
                  onTap: () {
                    isDetailsCollapsed = !isDetailsCollapsed;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    color: widget.productInfo["textColor"],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Product Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 38.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.keyboard_arrow_down,
                                size: 0.035.hp, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                // CONTAINER OF ACTUAL PRODUCTS INSIDE PACK
                !isDetailsCollapsed
                    ? Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 15,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'PRODUCT',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "SOFT CONTACT LENSES",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'PACK FORMAT',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "2 VIAL PACK(1 PAIR)",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'POLYMACON',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "62%",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'WATER CONTENT',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "38%",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'DIAMETER',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "14.2 MM",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'BASE CURVE',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "8.6 MM",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'REPLACEMENT CYCLE',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "6-MONTHS",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'STERILIZATION',
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "MOIST HEAT",
                                  style: TextStyle(
                                    color: widget.productInfo["textColor"],
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                !isDetailsCollapsed
                    ? Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          "assets/ShowProduct/MERMAID/productSafety.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                !isDetailsCollapsed
                    ? Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        width: double.infinity,
                        child: Image.asset(
                          "assets/boxes/box1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                !isDetailsCollapsed
                    ? Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        width: double.infinity,
                        child: Image.asset(
                          "assets/boxes/box2.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                // CONTAINER OF PRODUCT SAFETY HEADINGH
                InkWell(
                  onTap: () {
                    isSafetyCollapsed = !isSafetyCollapsed;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    color: widget.productInfo["textColor"],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Important Note",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.keyboard_arrow_down,
                                size: 0.035.hp, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                // CONTAINER CONSISTING OF ACTUAL SAFETY CONTENT
                !isSafetyCollapsed
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 15,
                            left: MediaQuery.of(context).size.width * 0.040,
                            right: 20,
                            bottom: 1),
                        child: Text(
                          '-Please keep the lenses in solution and replace after every use.',
                          style: TextStyle(
                              color: widget.productInfo["textColor"],
                              fontSize: 38.sp),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : Container(),
                !isSafetyCollapsed
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 5,
                            left: MediaQuery.of(context).size.width * 0.040,
                            right: 20,
                            bottom: 1),
                        child: Text(
                          '-Lenses must be soaked overnight before first use.',
                          style: TextStyle(
                              color: widget.productInfo["textColor"],
                              fontSize: 38.sp),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : Container(),
                !isSafetyCollapsed
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 5,
                            left: MediaQuery.of(context).size.width * 0.040,
                            right: 20,
                            bottom: 5),
                        child: Text(
                          '-Lenses may vary in appearence from person to person.',
                          style: TextStyle(
                              color: widget.productInfo["textColor"],
                              fontSize: 38.sp),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        }));
  }
}
