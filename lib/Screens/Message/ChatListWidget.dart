import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Message/ChatItemWidget.dart';
import 'package:skyLenses/Screens/Message/MessageBlocs/messageBloc.dart';

final ScrollController listScrollController = ScrollController();

class ChatListWidget extends StatefulWidget {
  final MessagesBloc bloc;
  ChatListWidget({this.bloc});
  @override
  _ChatListWidgetState createState() => _ChatListWidgetState(); 
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  void initState() {
    super.initState();
    widget.bloc.messagesEventController.sink.add(DisplayMessages());
    Timer(Duration(milliseconds: 500), () {
      if (listScrollController.hasClients) {
        listScrollController
            .jumpTo(listScrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: [],
        stream:
            widget.bloc.displayMessagesController.stream.asBroadcastStream(),
        builder: (context, messagesList) {
          if (messagesList.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2,
            ));
          } else {
            if (listScrollController.hasClients) {
              listScrollController
                  .jumpTo(listScrollController.position.maxScrollExtent);
            }
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                print(messagesList.data[index]["message"]);
                return Container(
                  margin: EdgeInsets.only(top: 15),
                  child: ChatItemWidget(
                    author: messagesList.data[index]["author"],
                    messageContent: messagesList.data[index]["message"],
                  ),
                );
              },
              itemCount: messagesList.data.length,
              controller: listScrollController,
              shrinkWrap: true,
            );
          }
        });
  }
}
