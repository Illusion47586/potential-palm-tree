import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/PostCheckout/addressWidget.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

abstract class PostCheckoutEvents {}

class DisplayAddresses extends PostCheckoutEvents {
  final PostCheckoutBloc bloc;
  DisplayAddresses({this.bloc});
}

class RemoveAddress extends PostCheckoutEvents {
  final String flatNo;
  final PostCheckoutBloc bloc;
  RemoveAddress({this.flatNo, this.bloc});
}

class ControlRadioButton extends PostCheckoutEvents {
  final dynamic value;
  ControlRadioButton({this.value});
}

class PostCheckoutBloc {
  List<AddressWidget> addresses = [];
  var selectedAddress;
  final postCheckoutEventsController =
      StreamController<PostCheckoutEvents>.broadcast();
  final displayAddressesController =
      StreamController<List<AddressWidget>>.broadcast();

  final radioController = StreamController<dynamic>.broadcast();

  PostCheckoutBloc() {
    postCheckoutEventsController.stream.listen(_mapEventsToState);
  }

  void _mapEventsToState(event) {
    if (event is DisplayAddresses) {
      displayAddresses(event.bloc);
    }
    if (event is ControlRadioButton) {
      controlRadioButton(event.value);
    }
    if (event is RemoveAddress) {
      removeAddress(event.flatNo, event.bloc);
    }
  }

  displayAddresses(bloc) async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/cart/checkout/getCustomers/$phoneNumber';
    var response = await https.get(url);
    var customersList = json.decode(response.body)["customers"];
    String isEmpty = json.decode(response.body)["isEmpty"];
    if (isEmpty == "no") {
      customersList.forEach((customer) {
        addresses.add(AddressWidget(customerDetails: customer, bloc: bloc));
      });
      displayAddressesController.sink.add(addresses);
    } else {
      displayAddressesController.sink.add(addresses);
    }
  }

  controlRadioButton(value) {
    radioController.sink.add(value);
    selectedAddress = value;
    return value;
  }

  removeAddress(String flatNo, PostCheckoutBloc bloc) async {
    var phoneNumber = await verifyCurrentUser();
    String url =
        'https://www.skycosmeticlenses.com/api/user/$phoneNumber/deleteCustomer/$flatNo';
    var response = await https.get(url);
    String status = json.decode(response.body)["status"];
    addresses.removeWhere((item) => item.customerDetails["flatNo"] == flatNo);
    displayAddressesController.sink.add(addresses);
  }

  void dispose() {
    postCheckoutEventsController.close();
    displayAddressesController.close();
    radioController.close();
  }
}
