import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Checkout/blocs/checkoutBloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCard extends StatefulWidget {
  final CheckoutBloc bloc;
  PromoCard({this.bloc});
  @override
  _PromoCardState createState() => _PromoCardState();
}

class _PromoCardState extends State<PromoCard> {
  final TextEditingController promoController = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    widget.bloc.checkoutEventsController.sink.add(DisplayWalletPoints());
    widget.bloc.checkoutEventsController.sink.add(DisplayAvailableCoupons());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Coupon Code?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 40.sp,
                    ),
                  ),
                  StreamBuilder<Object>(
                    initialData: [Container()],
                    stream: widget.bloc.availableCouponsController.stream
                        .asBroadcastStream(),
                    builder: (context, availableCoupons) {
                      return Container(
                        height: 0.044.hp,
                        child: RaisedButton(
                          padding: EdgeInsets.only(
                              left: 14.w, right: 13.w, top: 5.w, bottom: 5.w),
                          child: FittedBox(
                            child: Text(
                              'Available Coupons',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 38.sp,
                              ),
                            ),
                          ),
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.black, width: 1),
                          ),
                          onPressed: () async {
                            widget.bloc.checkoutEventsController.sink
                                .add(DisplayAvailableCoupons(
                              promoController: promoController,
                            ));
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Column(children: availableCoupons.data),
                                        SizedBox(height: 25.h),
                                      ],
                                    ),
                                  ));
                                });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              //  Container Consisiting of 1st Row
              StreamBuilder(
                  stream: widget.bloc.applyPromoController.stream
                      .asBroadcastStream(),
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 45.w),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                  ),
                                  controller: promoController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    alignLabelWithHint: true,
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10.h),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    hintText: "Coupon code",
                                    hintStyle: TextStyle(
                                      fontSize: 38.sp,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 2,
                                ),
                              ),
                              Container(
                                width: 230.w,
                                height: 0.044.hp,
                                child: RaisedButton(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 5.w,
                                        bottom: 5.w),
                                    child: FittedBox(
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 40.sp,
                                        ),
                                      ),
                                    ),
                                    color: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                    onPressed: () async {
                                      if (promoController.text != "") {
                                        widget
                                            .bloc.checkoutEventsController.sink
                                            .add(ApplyPromoCode(
                                                promoCode:
                                                    promoController.text));
                                      } else {
                                        // widget
                                        //     .bloc.checkoutEventsController.sink
                                        //     .add(ApplyPromoCode(
                                        //         promoCode: "no"));
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                        snapshot.data != null
                            ? snapshot.data == "Discount Applied Successfully"
                                ? Container(
                                    margin: EdgeInsets.only(top: 25.w),
                                    child: Text(snapshot.data,
                                        style: TextStyle(
                                          fontSize: 34.sp,
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.w500,
                                        )))
                                : Container(
                                    margin: EdgeInsets.only(top: 25.w),
                                    child: Text(snapshot.data,
                                        style: TextStyle(
                                          fontSize: 34.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        )))
                            : Container(),
                      ],
                    );
                  }),
              // Container consisiting of 2nd row
              StreamBuilder(
                  initialData: 0,
                  stream: widget.bloc.displayWalletPointsController.stream
                      .asBroadcastStream(),
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<Object>(
                          stream: widget.bloc.applyWalletPointsController.stream
                              .asBroadcastStream(),
                          builder: (context, redeemSnapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        'Coins (${snapshot.data} available)', 
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 40.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 0.044.hp,
                                      width: 230.w,
                                      child: RaisedButton(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 5.w,
                                              bottom: 5.w),
                                          child: FittedBox(
                                            child: Text(
                                              'Redeem',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 38.sp,
                                              ),
                                            ),
                                          ),
                                          color: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                          onPressed: () {
                                            widget.bloc.checkoutEventsController
                                                .sink
                                                .add(ApplyWalletPoints());
                                          }),
                                    ),
                                  ],
                                ),
                                redeemSnapshot.data != null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            bottom: 13.w, top: 13.w),
                                        child: Text(redeemSnapshot.data,
                                            style: TextStyle(
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.w500,
                                              fontSize: 34.sp,
                                            )),
                                      )
                                    : Container()
                              ],
                            );
                          }),
                    );
                  }),
              // CONTAINER OF 2nd Row Ended.
              SizedBox(
                height: 30.w,
              ),
              Text(
                'Minimum Order amount should be greater than Rs 1000 to apply discounts.',
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
    );
  }
}
