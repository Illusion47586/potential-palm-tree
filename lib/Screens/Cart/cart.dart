import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Cart/Blocs/cartBloc.dart';
import 'package:skyLenses/Screens/Checkout/checkoutScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final bloc = CartBloc();

  @override
  void initState() {
    super.initState();
    bloc.cartEventsController.sink.add(DisplayCartItems(bloc: bloc));
    bloc.cartEventsController.sink.add(DisplayTotalCartPrice());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      body: SingleChildScrollView(
        child: StreamBuilder(
            initialData: [Container()],
            stream: bloc.displayCartItemsController.stream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                if (snapshot.data.length != 0) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 40),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Column(
                          children: snapshot.data,
                        ),
                        StreamBuilder<Object>(
                          initialData: 0,
                          stream: bloc.displayTotalCartPriceController.stream
                              .asBroadcastStream(),
                          builder: (context, priceSnapshot) {
                            return priceSnapshot.data != 0
                                ? Container(
                                    height: 0.16.hp,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(30.w),
                                    margin: EdgeInsets.only(
                                        left: 0, right: 0, top: 20.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total',
                                              style: TextStyle(
                                                  fontSize: 40.sp,
                                                  color: Color(0xff6B6A67),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "₹${priceSnapshot.data.toString()}",
                                              style: TextStyle(
                                                  fontSize: 40.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          width: 0.4.wp,
                                          child: RaisedButton(
                                            color: Color(0xffFF4400),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          CheckoutScreen()));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Checkout',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 40.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Icon(Icons.arrow_forward,
                                                    color: Colors.white,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.037),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                : Container();
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/Cart/empty-cart.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.067),
                      Text(
                        'Bag is Empty',
                        style: TextStyle(
                            fontSize: 45.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
