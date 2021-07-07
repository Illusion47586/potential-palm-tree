import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:skyLenses/Screens/Checkout/blocs/checkoutBloc.dart';
import 'package:skyLenses/Screens/Payments/Payment.dart';
import 'package:skyLenses/Screens/PostCheckout/failure.dart';
import 'package:skyLenses/Screens/PostCheckout/postCheckoutBloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/Screens/PostCheckout/sendFinalOrder.dart';
import 'package:skyLenses/Screens/PostCheckout/thanks.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

payNow(CheckoutBloc checkoutBloc, PostCheckoutBloc postCheckoutbloc, bool cash,
    bool prepaid, BuildContext context) async {
  print("THIS IS A PREPAID ORDER");
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
    // DATA COLLECTION AT ONE PLACE
    //==========================================================================
    var selectedAddress = postCheckoutbloc.selectedAddress;
    List<dynamic> productsList = await checkoutBloc.displayCheckoutProducts();
    int originalFinalAmount = await checkoutBloc.displayFinalAmount();
    dynamic applyPromoResponse = checkoutBloc.applyPromoResponse;
    dynamic applyWalletPointsResponse = checkoutBloc.applyWalletPointsResponse;
//==========================================================================
    int finalTotalPrice = 0;
// ============================================================================
    if ((applyWalletPointsResponse == null) && (applyPromoResponse == null)) {
      finalTotalPrice = originalFinalAmount;
    } else if ((applyWalletPointsResponse == null) &&
        (applyPromoResponse != null)) {
      if (applyPromoResponse["isApplied"] == "yes") {
        finalTotalPrice = applyPromoResponse["finalAmount"];
      }
      if (applyPromoResponse["isApplied"] == "no") {
        finalTotalPrice = applyPromoResponse["finalAmount"];
      }
    } else if ((applyWalletPointsResponse != null) &&
        (applyPromoResponse == null)) {
      if (applyWalletPointsResponse["isApplied"] == "yes") {
        finalTotalPrice = applyWalletPointsResponse["finalAmount"];
      }
      if (applyWalletPointsResponse["isApplied"] == "no") {
        finalTotalPrice = applyWalletPointsResponse["finalAmount"];
      }
    }
    //==========================================================================

    razorpayDirection(
        context,
        selectedAddress,
        productsList,
        originalFinalAmount,
        applyPromoResponse,
        applyWalletPointsResponse,
        finalTotalPrice,
        "PREPAID");
  }
}

razorpayDirection(
  BuildContext context,
  dynamic selectedAddress,
  List<dynamic> productsList,
  int originalFinalAmount,
  dynamic applyPromoResponse,
  dynamic applyWalletPointsResponse,
  int amount,
  String mode,
) {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  razorpay = new Razorpay();

  // Navigator.of(context).pop();

  void openCheckout() async {
    var phoneNumber = await verifyCurrentUser();
    var options = {
      "key": "rzp_live_NSKXgvcfZy37WB",
      "amount": amount * 100,
      "name": "Sky Cosmetic Lenses",
      "description": "Complete your order",
      "prefill": {
        "contact": "$phoneNumber",
        "email": selectedAddress['email'],
      },
      "external": {},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  openCheckout();

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("PAYMENT SUCCES HO GYI");
    // print(response.paymentId);
    sendFinalOrder(
        selectedAddress,
        productsList,
        originalFinalAmount,
        applyPromoResponse,
        applyWalletPointsResponse,
        mode,
        response.paymentId.toString());
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => ThanksScreen()));
    print("Payment success");
    razorpay.clear();
    // Toast.show("Payment success", context);
  }

  void handlerErrorFailure() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => FailureScreen()));
    print("Pament error");
    // Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    // Toast.show("External Wallet", context);
  }

  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
}
