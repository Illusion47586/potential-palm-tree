import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Checkout/blocs/checkoutBloc.dart';
import 'package:skyLenses/Screens/CustomerDetails/custDetails.dart';
import 'package:skyLenses/Screens/PostCheckout/cashOrder.dart';
import 'package:skyLenses/Screens/PostCheckout/postCheckoutBloc.dart';
import './payNow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCheckout extends StatefulWidget {
  final CheckoutBloc checkoutBloc;
  final bool cash;
  final bool prepaid;
  PostCheckout({this.checkoutBloc, this.cash, this.prepaid});
  @override
  _PostCheckoutState createState() => _PostCheckoutState();
}

class _PostCheckoutState extends State<PostCheckout> {
  final postCheckoutbloc = PostCheckoutBloc();

  @override
  void initState() {
    super.initState();
    postCheckoutbloc.postCheckoutEventsController.sink
        .add(DisplayAddresses(bloc: postCheckoutbloc));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(items:[]),
      backgroundColor: Color(0xffF0F0F0),
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20.w, left: 15.w),
                  child: Text("Select a delivery address",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50.sp))),
              StreamBuilder(
                  initialData: [Container()],
                  stream: postCheckoutbloc.displayAddressesController.stream
                      .asBroadcastStream(),
                  builder: (context, snapshot) {
                    if (snapshot.data.length == 0) {
                      return Container(
                          margin: EdgeInsets.only(top: 15, left: 15),
                          child: Text('Place your first order...',
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500)));
                    } else {
                      return Column(children: snapshot.data);
                    }
                  }),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CustomerDetails()));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 22.w,
                  ),
                  padding: EdgeInsets.only(
                    top: 30.w,
                    bottom: 30.w,
                    left: 20.w,
                    right: 20.w,
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add a new delivery address",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 40.sp,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 50.w),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                margin: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 20.w, top: 40.w),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.w)),
                  color: Colors.black,
                  onPressed: () {
                    if (widget.cash) {
                      cashOrder(widget.checkoutBloc, postCheckoutbloc,
                          widget.cash, widget.prepaid, context);
                    } else {
                      payNow(widget.checkoutBloc, postCheckoutbloc, widget.cash,
                          widget.prepaid, context);
                    }
                  },
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 45.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    postCheckoutbloc.dispose();
  }
}
