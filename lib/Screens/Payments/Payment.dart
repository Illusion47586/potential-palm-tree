import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:skyLenses/Screens/PostCheckout/failure.dart';
import 'package:skyLenses/Screens/PostCheckout/sendFinalOrder.dart';
import 'package:skyLenses/Screens/PostCheckout/thanks.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

class Payment extends StatefulWidget {
  final dynamic selectedAddress;
  final List<dynamic> productsList;
  final int originalFinalAmount;
  final dynamic applyPromoResponse;
  final dynamic applyWalletPointsResponse;
  final int amount;
  final String mode;

  Payment({
    this.amount,
    this.applyPromoResponse,
    this.applyWalletPointsResponse,
    this.originalFinalAmount,
    this.productsList,
    this.selectedAddress,
    this.mode,
  });
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
