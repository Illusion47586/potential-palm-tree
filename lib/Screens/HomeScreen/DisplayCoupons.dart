import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/HomeScreen/couponCard.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayCoupons extends StatefulWidget {
  @override
  _DisplayCouponsState createState() => _DisplayCouponsState();
}

class _DisplayCouponsState extends State<DisplayCoupons> {
  final bloc = CouponBloc();

  @override
  void initState() {
    super.initState();
    bloc.couponEventsController.sink.add(DisplayCouponsEvent());
    bloc.couponEventsController.sink.add(DisplayCoins());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 40.sp)),
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.065,
              child: Image.asset(
                "assets/SplashScreen/skyLogo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: StreamBuilder<Object>(
          stream: bloc.displayCouponController.stream.asBroadcastStream(),
          initialData: [Container()],
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Container(
                width: 1.wp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text('Wallet',
                        style: TextStyle(
                            fontSize: 50.sp, fontWeight: FontWeight.w800)),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff0A1172),
                        border: Border.all(
                          width: 1.2,
                          color: Color(0xff0A1172),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      height: 300.h,
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200.w,
                                child: Image.asset(
                                  'assets/coin.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              StreamBuilder<Object>(
                                  initialData: 10,
                                  stream: bloc.displayCoinsController.stream
                                      .asBroadcastStream(),
                                  builder: (context, snapshot) {
                                    return Text('${snapshot.data} Coins',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 50.sp,
                                            fontWeight: FontWeight.w800));
                                  }),
                            ]),
                      ),
                    ),
                    Column(children: snapshot.data),
                    SizedBox(height: 20),
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
    bloc.dispose();
  }
}

// =============================================================================
// =============================================================================
// BLOC CODE
// =============================================================================
//==============================================================================
abstract class CouponEvents {}

class DisplayCouponsEvent extends CouponEvents {}

class DisplayCoins extends CouponEvents {}

class CouponBloc {
  final couponEventsController = StreamController<CouponEvents>.broadcast();
  final displayCouponController =
      StreamController<List<CouponsCard>>.broadcast();
  final displayCoinsController = StreamController<int>.broadcast();

  CouponBloc() {
    couponEventsController.stream.listen(_mapEventsToState);
  }

  void _mapEventsToState(event) {
    if (event is DisplayCouponsEvent) {
      displayCoupons();
    }
    if (event is DisplayCoins) {
      displayCoins();
    }
  }

  displayCoupons() async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/availableCoupons/$phoneNumber';
    var response = await https.get(url);
    var responseObject = json.decode(response.body)["coupons"];

    // List<CouponsCard> couponCardList =
    //     List.generate(responseObject.length, (index) {
    //   for (int i = 0; i < 100; i++) {
    //     print("HII");
    //     return CouponsCard(
    //       couponCardDetails: responseObject[index],
    //     );
    //   }
    // });
    // displayCouponController.sink.add(couponCardList);

    List<CouponsCard> couponCardList = [];
    for (int i = 0; i < responseObject.length; i++) {
      for (int j = 0; j < responseObject[i]["timesUsabale"]; j++) {
        print("HII");
        couponCardList.add(CouponsCard(
          couponCardDetails: responseObject[i],
        ));
      }
    }

    displayCouponController.sink.add(couponCardList);
  }

  void displayCoins() async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/displayCoins/$phoneNumber';
    var response = await https.get(url);
    var responseObject = json.decode(response.body);
    displayCoinsController.sink.add(responseObject["points"]);
  }

  void dispose() {
    couponEventsController.close();
    displayCouponController.close();
    displayCoinsController.close();
  }
}
