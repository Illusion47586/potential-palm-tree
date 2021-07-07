import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Checkout/blocs/checkoutBloc.dart';
import 'package:skyLenses/Screens/PostCheckout/postCheckoutBloc.dart';
import 'package:skyLenses/Screens/PostCheckout/sendFinalOrder.dart';
import 'package:skyLenses/Screens/PostCheckout/thanks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

cashOrder(CheckoutBloc checkoutBloc, PostCheckoutBloc postCheckoutbloc,
    bool cash, bool prepaid, BuildContext context) async {
  print("THIS IS A CASH ORDER");

  if (postCheckoutbloc.selectedAddress == null) {
    // SHOW SNACK BAR
    final selectAddressSnackbar = SnackBar(
      content:
          Text("Select a Delivery Address", style: TextStyle(fontSize: 40.sp)),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 700),
    );
    Scaffold.of(context).showSnackBar(selectAddressSnackbar);
    // SNACK BAR OVER
  } else {
    Navigator.of(context).pop();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => ThanksScreen()));
    // DATA COLLECTION AT ONE PLACE
    //==========================================================================
    var selectedAddress = postCheckoutbloc.selectedAddress;
    List<dynamic> productsList = await checkoutBloc.displayCheckoutProducts();
    int originalFinalAmount = await checkoutBloc.displayFinalAmount();
    dynamic applyPromoResponse = checkoutBloc.applyPromoResponse;
    dynamic applyWalletPointsResponse = checkoutBloc.applyWalletPointsResponse;
    //==========================================================================
    sendFinalOrder(selectedAddress, productsList, originalFinalAmount,
        applyPromoResponse, applyWalletPointsResponse, "CASH", "null");
    //==========================================================================
  }
}
