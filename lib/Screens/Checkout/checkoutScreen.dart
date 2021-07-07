import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Checkout/blocs/checkoutBloc.dart';
import 'package:skyLenses/Screens/Checkout/widgets/billingCardCheckout.dart';
import 'package:skyLenses/Screens/Checkout/widgets/promoCard.dart';
import 'package:skyLenses/Screens/PostCheckout/postCheckout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  List<dynamic> buyNowQuantity;
  final bool isBuyNow;
  final List<Map<String, dynamic>> productInfo;
  final List<dynamic> buyNowPower;
  CheckoutScreen(
      {this.isBuyNow = false,
      this.productInfo,
      this.buyNowPower,
      this.buyNowQuantity});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutBloc bloc;
  bool isPrepaidSelected = true;
  bool isCashSelected = false;

  final noDiscoutonCashSnackbar = SnackBar(
    content: Text("Discounts not applicable on COD",
        style: TextStyle(fontSize: 40.sp)),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );

  final minOrderSnackbar = SnackBar(
    content: Text("Minimum Order is Rs 500", style: TextStyle(fontSize: 40.sp)),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 700),
  );

  @override
  void initState() {
    super.initState();
    bloc = CheckoutBloc(
        buyNowQuantity: widget.buyNowQuantity,
        buyNowPower: widget.buyNowPower,
        isBuyNow: widget.isBuyNow,
        productInfo: widget.productInfo);
    bloc.checkoutEventsController.sink.add(DisplayCheckoutProducts());
  }

  removeDiscountsUI() async {
    int beforeDiscountPrice = await bloc.displayFinalAmount();
    bloc.finalAmountController.sink.add(beforeDiscountPrice);
    bloc.discountController.sink.add(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Builder(builder: (context) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<Object>(
                    initialData: [Container()],
                    stream: bloc.displayCheckoutProductsController.stream
                        .asBroadcastStream(),
                    builder: (context, productCardData) {
                      return Column(
                        children: productCardData.data,
                      );
                    }),
                BillingCardCheckout(bloc: bloc),
                PromoCard(bloc: bloc),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(15.w),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    elevation: 4,
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      //Column COnsisting of everything
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Mode of Payment",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 18.w,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.068,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20.w)),
                              color: isPrepaidSelected
                                  ? Colors.black
                                  : Colors.white,
                              onPressed: () {
                                isPrepaidSelected = true;
                                isCashSelected = false;
                                setState(() {});
                              },
                              child: FittedBox(
                                child: Text(
                                  'Prepaid',
                                  style: TextStyle(
                                    color: isPrepaidSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.w),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.068,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(20.w)),
                              color:
                                  isCashSelected ? Colors.black : Colors.white,
                              onPressed: () {
                                isCashSelected = true;
                                isPrepaidSelected = false;
                                setState(() {});
                              },
                              child: FittedBox(
                                child: Text(
                                  'Cash On Delivery',
                                  style: TextStyle(
                                    color: isCashSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.w),
                          Text(
                            'No coupon discounts are applicable on cash on delivery orders',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 35.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  margin: EdgeInsets.only(
                      left: 25.w, right: 25.w, bottom: 30.w, top: 15.w),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.w)),
                    color: Colors.black,
                    onPressed: () async {
                      int promoResponse = bloc.applyPromoResponse != null
                          ? bloc.applyPromoResponse["status"]
                          : null;
                      int walletPointsResponse =
                          bloc.applyWalletPointsResponse != null
                              ? bloc.applyWalletPointsResponse["status"]
                              : null;
                      if ((promoResponse == 200 ||
                          walletPointsResponse == 200)) {
                        if (await bloc.displayAmount() < 500) {
                          Scaffold.of(context).showSnackBar(minOrderSnackbar);
                        } else {
                          if (!isCashSelected) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PostCheckout(
                                          checkoutBloc: bloc,
                                          cash: isCashSelected,
                                          prepaid: isPrepaidSelected,
                                        )));
                          } else {
                            // Scaffold.of(context)
                            //     .showSnackBar(noDiscoutonCashSnackbar);

                            // CHANGES TO BE Done

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.w)),
                                      title: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          'Attention !!',
                                          style: TextStyle(
                                              fontSize: 45.sp,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Discounts are not applicable on COD orders.Do you want to continue without discounts ?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 38.sp,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                            Expanded(
                                                child: SizedBox(height: 0)),
                                            InkWell(
                                              onTap: () {
                                                // Navigator.of(context).pop();
                                                removeDiscountsUI();
                                                bloc.applyWalletPointsResponse =
                                                    null;
                                                bloc.applyPromoController.sink
                                                    .add(null);
                                                bloc.applyPromoResponse = null;
                                                bloc.applyWalletPointsController
                                                    .sink
                                                    .add(null);
                                                Navigator.of(context).pop();
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (BuildContext
                                                //             context) =>
                                                //         PostCheckout(
                                                //       checkoutBloc: bloc,
                                                //       cash: isCashSelected,
                                                //       prepaid:
                                                //           isPrepaidSelected,
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    'Proceed',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 34.sp,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.w)),
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2 *
                                                    0.28,
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                });

                            // SHOW SNACK BAR
                          }
                        }
                      } else {
                        if (await bloc.displayAmount() < 500) {
                          Scaffold.of(context).showSnackBar(minOrderSnackbar);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => PostCheckout(
                                checkoutBloc: bloc,
                                cash: isCashSelected,
                                prepaid: isPrepaidSelected,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 40.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // bloc.dispose();
  }
}
