import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/Message/ChatListWidget.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

final ScrollController listScrollController3 = ScrollController();

abstract class MessageEvents {}

class DisplayMessages extends MessageEvents {}

class InsertMessage extends MessageEvents {
  final TextEditingController textController;
  final Map<String, String> messageBody;
  InsertMessage({this.messageBody, this.textController});
}

class MessagesBloc {
  // INITALIZING CONTROLLERS
  // ==========================================================
  final messagesEventController = StreamController<MessageEvents>.broadcast();
  final displayMessagesController = StreamController<List<dynamic>>.broadcast();
  final insertMessagesController =
      StreamController<Map<String, dynamic>>.broadcast();

  MessagesBloc() {
    messagesEventController.stream.listen(_mapEventsToState);
  }

// MAPPING FUNCTION
// ===============================================
  void _mapEventsToState(MessageEvents event) {
    if (event is DisplayMessages) {
      displayMessages();
    }
    if (event is InsertMessage) {
      insertMessage(event.messageBody, event.textController);
    }
  }

  // FUNCTIONS CONTAINING LOGIC
  // ===============================================
  displayMessages() async {
    // LOGIC FOR CHECKING THE STOCK QUANTITY
    // SEND A GET REQUETS TO /messages/9871511555/
    var phoneNumber = await verifyCurrentUser();
    String url = 'https://www.skycosmeticlenses.com/api/messages/$phoneNumber';
    try {
      var response = await https.get(url);
      List<dynamic> fetchedMessages = json.decode(response.body)["history"];
      if (fetchedMessages != null) {
        displayMessagesController.sink.add(fetchedMessages);
      } else {}
    } catch (err) {
      print(err);
    }
  }

  insertMessage(Map<String, String> messageBody,
      TextEditingController textController) async {
    var phoneNumber = await verifyCurrentUser();
    textController.clear();

    String url =
        'https://www.skycosmeticlenses.com/api/messages/$phoneNumber/insertMessage';
    try {
      var response = await https.post(url, body: messageBody);
      List<dynamic> insertResponse = json.decode(response.body)["history"];
      displayMessagesController.sink.add(insertResponse);
      Timer(Duration(milliseconds: 500), () {
        if (listScrollController3.hasClients) {
          listScrollController3
              .jumpTo(listScrollController3.position.maxScrollExtent);
        }
      });
    } catch (err) {
      print(err);
    }
  }

// DISPOSE FUNCTION
// ===============================================
  void dispose() {
    messagesEventController.close();
    displayMessagesController.close();
    insertMessagesController.close();
  }
}
