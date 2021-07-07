import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/Checkout/widgets/availableCouponWidget.dart';
import 'package:skyLenses/Screens/Checkout/widgets/productCard.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

abstract class CheckoutEvents {}

class DisplayCheckoutProducts extends CheckoutEvents {}

class DisplayAmount extends CheckoutEvents {}

class DisplayDiscount extends CheckoutEvents {}

class DisplayFinalAmount extends CheckoutEvents {}

class ApplyPromoCode extends CheckoutEvents {
  final String promoCode;
  ApplyPromoCode({this.promoCode});
}

class ApplyWalletPoints extends CheckoutEvents {}

class DisplayWalletPoints extends CheckoutEvents {}

class DisplayAvailableCoupons extends CheckoutEvents {
  final TextEditingController promoController;
  DisplayAvailableCoupons({this.promoController});
}

class CheckoutBloc {
  // RECEIVED VALUES
  final bool isBuyNow;
  final List<Map<String, dynamic>> productInfo;
  final List<dynamic> buyNowPower;
  List<dynamic> buyNowQuantity;

  // =======================================
  var applyPromoResponse;
  var applyWalletPointsResponse;
  // ===========================================
  final checkoutEventsController = StreamController<CheckoutEvents>();
  final amountController = StreamController<int>.broadcast();
  final discountController = StreamController<int>.broadcast();
  final finalAmountController = StreamController<int>.broadcast();
  final displayCheckoutProductsController =
      StreamController<List<ProductCheckoutCard>>.broadcast();
  // PROMOCONTROLLERS
  final applyPromoController = StreamController<String>.broadcast();
  final applyWalletPointsController = StreamController<String>.broadcast();
  final displayWalletPointsController = StreamController<int>.broadcast();
  final availableCouponsController =
      StreamController<List<AvailableCouponsCard>>.broadcast();

  CheckoutBloc(
      {this.productInfo,
      this.isBuyNow = false,
      this.buyNowPower,
      this.buyNowQuantity}) {
    checkoutEventsController.stream.listen(_mapEventsToState);
  }

  _mapEventsToState(event) {
    if (event is DisplayCheckoutProducts) {
      displayCheckoutProducts();
    }
    if (event is DisplayAmount) {
      displayAmount();
    }
    if (event is DisplayDiscount) {
      displayDiscount();
    }
    if (event is DisplayFinalAmount) {
      displayFinalAmount();
    }
    if (event is ApplyPromoCode) {
      applyPromoCode(event.promoCode);
    }
    if (event is DisplayWalletPoints) {
      displayWalletPoints();
    }
    if (event is ApplyWalletPoints) {
      applyWalletPoints();
    }
    if (event is DisplayAvailableCoupons) {
      displayAvailableCoupons(event.promoController);
    }
  }

  Future<List<dynamic>> displayCheckoutProducts() async {
    if (!isBuyNow) {
      List<ProductCheckoutCard> itemsList = [];
      var phoneNumber = await verifyCurrentUser();
      String url =
          'https://www.skycosmeticlenses.com/api/cart/fetchCartItems/$phoneNumber';
      var response = await https.get(url);
      List<dynamic> fetchedItemsList = json.decode(response.body)["items"];
      String status = json.decode(response.body)["status"];
      if (status != "empty") {
        itemsList = fetchedItemsList.map((cartItem) {
          print(cartItem["itemObject"]["power"].runtimeType);
          return ProductCheckoutCard(
            productName: cartItem["itemObject"]["productName"],
            quantity: cartItem["itemObject"]["quantity"],
            power: cartItem["itemObject"]["power"].toString(),
            price: cartItem["itemObject"]["price"],
            stock: cartItem["stock"],
          );
        }).toList();
      } else {
        itemsList = [];
      }
      displayCheckoutProductsController.sink.add(itemsList);
      print(fetchedItemsList);
      return fetchedItemsList;
    } else {
      // IF IT IS BUY NOW
      List<ProductCheckoutCard> itemsList = [];
      List<dynamic> fetchedItemsList = [];

      fetchedItemsList = List.generate(productInfo.length, (index) {
        return {
          "stock": "In Stock",
          "itemObject": {
            "productName": productInfo[index]["productName"],
            "quantity": buyNowQuantity[index],
            "power": buyNowPower[index],
            "price": productInfo[index]["price"],
          }
        };
      });
      itemsList = List.generate(productInfo.length, (indexa) {
        return ProductCheckoutCard(
          productName: productInfo[indexa]["productName"],
          quantity: buyNowQuantity[indexa],
          power: buyNowPower[indexa].toString(),
          price: productInfo[indexa]["price"],
          stock: "In Stock",
        );
      });

      displayCheckoutProductsController.sink.add(itemsList);
      return fetchedItemsList;
    }
  }

  displayAmount() async {
    if (!isBuyNow) {
      var phoneNumber = await verifyCurrentUser();
      String url =
          'https://www.skycosmeticlenses.com/api/cart/fetchCartItems/$phoneNumber';
      var response = await https.get(url);
      int totalCartPrice = json.decode(response.body)["totalPrice"];
      amountController.sink.add(totalCartPrice);
      return totalCartPrice;
    } else {
      int displayAmount = 0;
      for (int i = 0; i < productInfo.length; i++) {
        displayAmount += productInfo[i]["price"] * buyNowQuantity[i];
      }
      amountController.sink.add(displayAmount);
      return displayAmount;
    }
  }

  displayDiscount() {}
  Future<int> displayFinalAmount() async {
    int finalAmount = 0;
    finalAmount += await displayAmount();
    finalAmountController.sink.add(finalAmount);
    return finalAmount;
  }

  applyPromoCode(String promoCode) async {
    var phoneNumber = await verifyCurrentUser();
    int cartAmount = await displayAmount();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/checkCoupon/$phoneNumber/$promoCode/$cartAmount';
    var response = await https.get(url);
    var responseObject = json.decode(response.body);
    // UPDATING UI BILLING CARD
    finalAmountController.sink.add(responseObject["finalAmount"]);
    discountController.sink.add(responseObject["discountValue"]);
    applyPromoController.sink.add(responseObject["message"]);
    applyWalletPointsController.sink.add(null);
    applyWalletPointsResponse = null;
    applyPromoResponse = responseObject;
    return responseObject;
  }

  displayWalletPoints() async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/displayCoins/$phoneNumber';
    var response = await https.get(url);
    var responseObject = json.decode(response.body);
    displayWalletPointsController.sink.add(responseObject["points"]);
  }

  applyWalletPoints() async {
    var phoneNumber = await verifyCurrentUser();
    int cartAmount = await displayAmount();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/redeemCoins/$phoneNumber/$cartAmount';
    var response = await https.get(url);
    var responseObject = json.decode(response.body);

    finalAmountController.sink.add(responseObject["finalAmount"]);
    discountController.sink.add(responseObject["discountValue"]);
    applyPromoController.sink.add(null);
    applyPromoResponse = null;
    applyWalletPointsController.sink.add(responseObject["message"]);
    applyWalletPointsResponse = responseObject;
    return responseObject;
  }

// FETCH AVAILABLE COUPONS
  displayAvailableCoupons(TextEditingController promoController) async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/availableCoupons/$phoneNumber';
    var response = await https.get(url);
    var responseObject = json.decode(response.body)["coupons"];

    List<AvailableCouponsCard> couponCardList =
        List.generate(responseObject.length, (index) {
      return AvailableCouponsCard(
        couponCardDetails: responseObject[index],
        promoController: promoController,
        applyPromoFunction: applyPromoCode,
      );
    });
    availableCouponsController.sink.add(couponCardList);
  }

  void dispose() {
    checkoutEventsController.close();
    amountController.close();
    discountController.close();
    finalAmountController.close();
    displayCheckoutProductsController.close();
    applyWalletPointsController.close();
    applyPromoController.close();
    displayWalletPointsController.close();
    availableCouponsController.close();
  }
}
