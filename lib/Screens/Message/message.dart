import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Authentication/sendOtp.dart';
import 'package:skyLenses/Screens/Message/ChatListWidget.dart';
import 'package:skyLenses/Screens/Message/InputWidget.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';

import 'MessageBlocs/messageBloc.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final bloc = MessagesBloc();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: verifyCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2,
            ));
          } else {
            if (snapshot.data != "") {
              return Scaffold(
                  backgroundColor: Colors.white,
                  // Custom app bar for chat screen
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.74,  
                          child: ChatListWidget(bloc: bloc)),
                      // Expanded(child: SizedBox(height: 0)),  //Chat list
                      Positioned(
                          bottom: 0,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.09,
                              child:
                                  InputWidget(bloc: bloc))) //  The input widget
                    ]),
                  ));
            } else {
              return LoginPage();
            }
          }
        });
  }
}
