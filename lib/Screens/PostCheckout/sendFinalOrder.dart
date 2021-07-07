import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

sendFinalOrder(
    dynamic selectedAddress,
    List<dynamic> productsList,
    int originalFinalAmount,
    dynamic applyPromoResponse,
    dynamic applyWalletPointsResponse,
    String paymentMethod,
    String paymentId) async {
  int finalTotalPrice = 0;
  bool isDiscountApplied = false;
  bool isCoinsApplied = false;
  int discountValue = 0;
  String couponCode;
// ============================================================================
  if ((applyWalletPointsResponse == null) && (applyPromoResponse == null)) {
    finalTotalPrice = originalFinalAmount;
    couponCode = "null";
  } else if ((applyWalletPointsResponse == null) &&
      (applyPromoResponse != null)) {
    if (applyPromoResponse["isApplied"] == "yes") {
      isDiscountApplied = true;
      discountValue = applyPromoResponse["discountValue"];
      finalTotalPrice = applyPromoResponse["finalAmount"];
      couponCode = applyPromoResponse["couponCode"];
    }
    if (applyPromoResponse["isApplied"] == "no") {
      isDiscountApplied = false;
      discountValue = applyPromoResponse["discountValue"];
      finalTotalPrice = applyPromoResponse["finalAmount"];
      couponCode = "empty";
    }
  } else if ((applyWalletPointsResponse != null) &&
      (applyPromoResponse == null)) {
    if (applyWalletPointsResponse["isApplied"] == "yes") {
      isDiscountApplied = true;
      isCoinsApplied = true;
      discountValue = applyWalletPointsResponse["discountValue"];
      finalTotalPrice = applyWalletPointsResponse["finalAmount"];
      couponCode = discountValue.toString();
    }
    if (applyWalletPointsResponse["isApplied"] == "no") {
      isDiscountApplied = false;
      isCoinsApplied = false;
      discountValue = applyWalletPointsResponse["discountValue"];
      finalTotalPrice = applyWalletPointsResponse["finalAmount"];
      couponCode = discountValue.toString();
    }
  }
  // ===========================================================================
  var phoneNumber = await verifyCurrentUser();
  print("THIS IS SEND FINAL ORDER");

  print('"amount": ${finalTotalPrice.toString()}');
  print('"Original Final Amount": ${originalFinalAmount.toString()}');

  String url =
      'https://www.skycosmeticlenses.com/api/orders/newOrder/$phoneNumber';
  var response = await https.post(
    url,
    body: {
      "paymentMethod": paymentMethod,
      "originalFinalAmount": originalFinalAmount.toString(),
      "amount": finalTotalPrice.toString(),
      "isDiscountApplied": isDiscountApplied.toString(),
      "couponCode": couponCode,
      "customer": jsonEncode(selectedAddress),
      "products": jsonEncode(productsList),
      "isCoinsApplied": isCoinsApplied.toString(),
      "paymentId": paymentId,
    },
  );
  var status = json.decode(response.body)["status"];
  print(status);
}
