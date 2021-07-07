import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyLenses/LocalData/solutionProductList.dart';
import 'package:skyLenses/LocalData/solutionVolumeList.dart';
import 'package:skyLenses/Screens/Checkout/checkoutScreen.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';
import 'package:skyLenses/Screens/ShowProduct/BLocs/showBloc.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/Screens/SplashScreen.dart';

class ShowSolution extends StatefulWidget {
  @override
  _ShowSolutionState createState() => _ShowSolutionState();
}

class _ShowSolutionState extends State<ShowSolution> {
  bool isVolumeCollapsed = true;
  bool isDescriptionCollapsed = false;
  bool isDirectionsCollapsed = false;
  bool isInStock;
  String selectedVolume;
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
    content: Text("Please select Volume",
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
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
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
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Color(0xff0F2A06))),
          title: FittedBox(
            child: Text("Sky Solution",
                style: TextStyle(
                  color: Color(0xff0F2A06),
                  fontSize: 50.sp,
                )),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffF2F2F2),
          elevation: 0,
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
                  color: Color(0xffF2F2F2),
                  child: Image.asset(
                    'assets/product_final/solution/solution.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // CONTAINER CONSISITING OF PRODUCT NAME
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Sky Solution",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 58.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // CONTAINER CONSISISTING OF PRICE
                selectedVolume == "60 ml"
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          selectedVolume == "60 ml"
                              ? (globalSolutionPrice60 != null
                                  ? ("₹" + globalSolutionPrice60)
                                  : ("₹" + "99"))
                              : "",
                          style: TextStyle(
                            color: Color(0xff0F2A06),
                            fontSize: 48.sp,
                          ),
                        ),
                      )
                    : Container(),
                // CONTAINER CONTAINING STOCK MESSAGE
                StreamBuilder(
                    initialData: "",
                    stream: bloc.solutionStockMessageController.stream
                        .asBroadcastStream(),
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
                        child: Text(
                          stockMessage.data == "Out of Stock"
                              ? "Coming Soon"
                              : stockMessage.data,
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: stockMessage.data == "Out of Stock"
                                ? Colors.red
                                : Colors.green[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                InkWell(
                  onTap: () {
                    isVolumeCollapsed = !isVolumeCollapsed;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            selectedVolume == null
                                ? "Volume"
                                : selectedVolume.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: !isVolumeCollapsed
                                ? Icon(Icons.keyboard_arrow_up,
                                    color: Colors.white)
                                : Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white))
                      ],
                    ),
                  ),
                ),
                !isVolumeCollapsed
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(2, (index) {
                              return InkWell(
                                onTap: () {
                                  selectedVolume = volumeList[index];
                                  // print(selectedVolume);
                                  // CHECKING FOR AVAILABLE QUANTITY
                                  bloc.showProductEventController
                                      .add(StockMessageSolution(
                                    volume: selectedVolume,
                                  ));
                                  // ============================================

                                  isVolumeCollapsed = !isVolumeCollapsed;
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
                                      child: Text(volumeList[index].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40.sp,
                                          ))),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    : Container(),
                // CONTAINER OF ROW HAVEING 2 BUTTONS
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Color(0xffF4F8F8),
                            border: Border.all(color: Color(0xff0F2A06))),
                        child: RaisedButton(
                          padding: EdgeInsets.all(0),
                          color: Color(0xffF4F8F8),
                          elevation: 0,
                          onPressed: () async {
                            setState(() {});
                            if (selectedVolume != null) {
                              if ((isInStock != null) && (isInStock != false)) {
                                if (await verifyCurrentUser() == "") {
                                  Scaffold.of(context)
                                      .showSnackBar(loginErrorSnackBar);
                                } else {
                                  bloc.showProductEventController.sink
                                      .add(AddSolutionToCart(
                                    selectedVolume: selectedVolume,
                                  ));
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
                                color: Color(0xff0F2A06),
                                fontSize: 38.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Color(0xff0F2A06))),
                          child: RaisedButton(
                              padding: EdgeInsets.all(0),
                              color: Colors.grey,
                              elevation: 0,
                              onPressed: () async {
                                setState(() {});
                                if (selectedVolume != null) {
                                  if (isInStock != null &&
                                      (isInStock != false)) {
                                    if (await verifyCurrentUser() == "") {
                                      Scaffold.of(context)
                                          .showSnackBar(loginErrorSnackBar);
                                    } else {
                                      int selectedIntVolume;
                                      Map<String, dynamic> productInfo;
                                      if (selectedVolume == "60 ml") {
                                        productInfo = solutionList[0];
                                        selectedIntVolume = 60;
                                      } else {
                                        productInfo = solutionList[1];
                                        selectedIntVolume = 120;
                                      }
                                      productInfo["selectedPower"] =
                                          selectedIntVolume;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CheckoutScreen(
                                            buyNowQuantity: [1],
                                            buyNowPower: [
                                              double.parse(
                                                  selectedIntVolume.toString())
                                            ],
                                            isBuyNow: true,
                                            productInfo: [productInfo],
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
                  margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Text(
                    'Especially Formalised for colour as well as non colour lenses.',
                    style: TextStyle(color: Color(0xff0F2A06), fontSize: 35.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                // CONTAINER OF  HEADING CONTENTS(PRODUCT DESCRIPTION)
                InkWell(
                  onTap: () {
                    isDescriptionCollapsed = !isDescriptionCollapsed;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Product Description",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.keyboard_arrow_down,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                // CONTAINER OF ACTUAL PRODUCTS INSIDE PACK
                !isDescriptionCollapsed
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CONTENTS',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(height: 5),
                            Text('SODIUM CHLORIDE',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 3,
                            ),
                            Text('DISODIUM EDTA',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 3),
                            Text('NON IONIC SURFACTANT',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 3),
                            Text('POLYHEXAMETHYLENE BIGUANIDE',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 3),
                            Text("in buffered media.",
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 13),
                            Text('BENEFITS:',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(height: 5),
                            Text('- RINSES',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('- CLEANS',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('- DISINFECTS',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('- REMOVES LIPIDS AND PROTEIN',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('- LUBRICATING QUALITIES',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('- SOAKING',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('- PROTECTS COLOUR OF THE LENS',
                                style: TextStyle(
                                    fontSize: 38.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                          ],
                        ),
                      )
                    : Container(),
                // CONTAINER OF PRODUCT SAFETY HEADINGH
                InkWell(
                  onTap: () {
                    isDirectionsCollapsed = !isDirectionsCollapsed;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Directions to Use",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.keyboard_arrow_down,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                // CONTAINER CONSISTING OF ACTUAL SAFETY CONTENT
                !isDirectionsCollapsed
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('-Wash your hands with soap.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text('-Take the lens and place it on your palm.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text(
                                '-Pour 3-4 drops of sky cosmetic lenses solution on the lens and gently clean the lens using your finger.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text('-Rinse the lens thoroughly with solution.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            Text('-DO NOT USE WATER TO RINSE THE LENS.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(height: 4),
                            Text(
                                '-Soak the lenses in each lens case using few drops of solution for a minimum of 4 hours to disinfect the lens.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text(
                                '-Take the lens from the case, rinse with sky cosmetic lenses solution before wearing.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 20),
                            Text('PRECAUTIONS',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(height: 5),
                            Text('-Do not use directly in the eyes.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 5),
                            Text(
                                '-To avoid contamination do not touch the bottle nozzle.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 5),
                            Text(
                              '-keep the bottle always capped.',
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5),
                            Text(
                                '-Discard remaining solution after 90 days of opening the bottle.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 5),
                            Text(
                                '-Best when used within 24 months from the date of manufacture.',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10),
                          ],
                        ),
                      )
                    : Container(
                        child: SizedBox(height: 30),
                      ),
              ],
            ),
          );
        }));
  }
}
