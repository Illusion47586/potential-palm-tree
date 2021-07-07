import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/Cart/widgets/cartInStockCard.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

abstract class CartEvents {}

class DisplayCartItems extends CartEvents {
  final CartBloc bloc;
  DisplayCartItems({this.bloc});
}

class DisplayTotalCartPrice extends CartEvents {}

class DisplayOrders extends CartEvents {}

class CartBloc {
  final cartEventsController = StreamController<CartEvents>.broadcast();
  final displayCartItemsController =
      StreamController<List<CartInStockCard>>.broadcast();
  final displayTotalCartPriceController = StreamController<int>.broadcast();
  final ordersController = StreamController<List<dynamic>>.broadcast();
  final cancelOrderMessageController = StreamController<String>.broadcast();

  CartBloc() {
    cartEventsController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartEvents event) {
    if (event is DisplayCartItems) {
      displayCartItems(event.bloc);
    }
    if (event is DisplayTotalCartPrice) {
      displayTotalCartPrice();
    }
    if (event is DisplayOrders) {
      displayOrders();
    }
  }

// FUNCTION TO FETCH ANDDISPLAY CART ITEMS
  void displayCartItems(bloc) async {
    List<CartInStockCard> itemsList = [];
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/fetchCartItems/$phoneNumber';
    var response = await https.get(url);
    List<dynamic> fetchedCartList = json.decode(response.body)["items"];
    String status = json.decode(response.body)["status"];
    if (status != "empty") {
      itemsList = fetchedCartList.map((cartItem) {
        bloc.cartEventsController.sink.add(DisplayTotalCartPrice());
        return CartInStockCard(
          cardDetails: {
            "productName": cartItem["itemObject"]["productName"],
            "quantity": cartItem["itemObject"]["quantity"],
            "power": cartItem["itemObject"]["power"],
            "price": cartItem["itemObject"]["price"],
            "stock": cartItem["stock"],
            "bloc": bloc,
          },
        );
      }).toList();
    } else {
      itemsList = [];
    }

    displayCartItemsController.sink.add(itemsList);
  }

  displayTotalCartPrice() async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/fetchCartItems/$phoneNumber';
    var response = await https.get(url);
    int totalCartPrice = json.decode(response.body)["totalPrice"];
    displayTotalCartPriceController.sink.add(totalCartPrice);
  }

  // FUNCTION TO CHECK STOCK AND
  Future<String> checkCartItemStock(productName, power) async {
    String responseMessage = '';
    String url =
        'https://www.skycosmeticlenses.com/api/cart/$productName/$power/checkStock';
    var response = await https.get(url);
    responseMessage = json.decode(response.body)["message"];
    return responseMessage;
  }

// GET ORDERS
  displayOrders() async {
    String phone = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/orders/$phone/getOrders';
    var response = await https.get(url);
    String status = json.decode(response.body)["status"];
    if (status == "exists") {
      ordersController.sink.add(json.decode(response.body)["orders"]);
    } else {
      ordersController.sink.add([]);
    }
  }

  void dispose() {
    cartEventsController.close();
    displayCartItemsController.close();
    displayTotalCartPriceController.close();
    ordersController.close();
  }
}
