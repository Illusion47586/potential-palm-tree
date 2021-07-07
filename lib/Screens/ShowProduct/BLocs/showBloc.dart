import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

abstract class ShowProductEvents {}

class StockMessage extends ShowProductEvents {
  final double selectedPower;
  final String productName;
  StockMessage({this.selectedPower, this.productName});
}

class StockMessageSolution extends ShowProductEvents {
  final String volume;
  StockMessageSolution({this.volume});
}

class AddToCart extends ShowProductEvents {
  final Map<String, dynamic> productInfo;
  final double selectedPower;
  AddToCart({this.productInfo, this.selectedPower});
}

class AddSolutionToCart extends ShowProductEvents {
  final String selectedVolume;
  AddSolutionToCart({this.selectedVolume});
}

class GetProductPrice extends ShowProductEvents {}

class ShowProductBloc {
  // INITALIZING CONTROLLERS
  // ==========================================================
  final showProductEventController =
      StreamController<ShowProductEvents>.broadcast();
  final stockMessageController = StreamController<String>.broadcast();
  final solutionStockMessageController = StreamController<String>.broadcast();
  final productPriceController = StreamController<String>.broadcast();

  ShowProductBloc() {
    showProductEventController.stream.listen(_mapEventsToState);
  }

// MAPPING FUNCTION
// ===============================================
  void _mapEventsToState(ShowProductEvents event) {
    if (event is StockMessage) {
      displayStockMessage(event.selectedPower, event.productName);
    }
    if (event is AddToCart) {
      addToCart(event.productInfo, event.selectedPower);
    }
    if (event is StockMessageSolution) {
      displayStockMessageSolution(event.volume);
    }
    if (event is AddSolutionToCart) {
      addSolutionToCart(event.selectedVolume);
    }
    if (event is GetProductPrice) {
      getProductPrice();
    }
  }

  // FUNCTIONS CONTAINING LOGIC
  // ===============================================
  void displayStockMessage(double selectedPower, String productName) async {
    String responseMessage = '';
    String url =
        'https://www.skycosmeticlenses.com/api/cart/$productName/$selectedPower/checkStock';
    try {
      var response = await https.get(url);
      responseMessage = json.decode(response.body)["message"];
    } catch (err) {
      print(err);
    }
    stockMessageController.sink.add(responseMessage);
  }

  displayStockMessageSolution(String volume) async {
    String responseMessage = '';
    String url =
        'https://www.skycosmeticlenses.com/api/cart/SOLUTION/$volume/checkSolutionStock';
    try {
      var response = await https.get(url);
      responseMessage = json.decode(response.body)["message"];
    } catch (err) {
      print(err);
    }
    print(responseMessage);
    solutionStockMessageController.sink.add(responseMessage);
  }

  void addToCart(Map<String, dynamic> productInfo, double selectedPower) async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/$phoneNumber/${productInfo["productName"]}/$selectedPower/addToCart';
    try {
      var response = await https.get(url);
      List<dynamic> fetchedMessages = json.decode(response.body)["history"];
    } catch (err) {
      print(err);
    }
  }

  void addSolutionToCart(String selectedVolume) async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/$phoneNumber/SOLUTION/$selectedVolume/addSolutionToCart';
    try {
      var response = await https.get(url);
      List<dynamic> fetchedMessages = json.decode(response.body)["history"];
    } catch (err) {
      print(err);
    }
  }

  getProductPrice() async {
    String url =
        'https://www.skycosmeticlenses.com/api/product/MERMAID/getPrice';
    try {
      var response = await https.get(url);
      String fetchedPrice = json.decode(response.body)["price"].toString();
      productPriceController.sink.add(fetchedPrice);
    } catch (err) {
      print(err);
    }
  }

// DISPOSE FUNCTION
// ===============================================
  void dispose() {
    showProductEventController.close();
    stockMessageController.close();
    solutionStockMessageController.close();
    productPriceController.close();
  }
}
