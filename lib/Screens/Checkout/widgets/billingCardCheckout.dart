import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Checkout/blocs/checkoutBloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingCardCheckout extends StatefulWidget {
  final CheckoutBloc bloc;
  BillingCardCheckout({this.bloc});
  @override
  _BillingCardCheckoutState createState() => _BillingCardCheckoutState();
}

class _BillingCardCheckoutState extends State<BillingCardCheckout> {
  @override
  void initState() {
    super.initState();
    widget.bloc.checkoutEventsController.sink.add(DisplayAmount());
    widget.bloc.checkoutEventsController.sink.add(DisplayFinalAmount());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "Billing",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // TOTAL AMOUNT ROW
              // Total amount Streambuilder
              StreamBuilder(
                  stream:
                      widget.bloc.amountController.stream.asBroadcastStream(),
                  initialData: 0,
                  builder: (context, totalAmount) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Cart Amount',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\u20B9 ' + totalAmount.data.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              // GST ROW
              // FINAL TO PAY
              StreamBuilder(
                  stream:
                      widget.bloc.discountController.stream.asBroadcastStream(),
                  initialData: 0,
                  builder: (context, discountSnapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Discount',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '- \u20B9 ' + discountSnapshot.data.toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                thickness: 1.h,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20.h,
              ),
              StreamBuilder<Object>(
                  stream: widget.bloc.finalAmountController.stream
                      .asBroadcastStream(),
                  initialData: 0,
                  builder: (context, finalSnapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '\u20B9 ' + finalSnapshot.data.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
