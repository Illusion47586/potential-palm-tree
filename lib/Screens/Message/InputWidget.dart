import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Message/ChatListWidget.dart';
import 'package:skyLenses/Screens/Message/MessageBlocs/messageBloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
final ScrollController listScrollController2 = ScrollController();

class InputWidget extends StatefulWidget {
  final MessagesBloc bloc;

  InputWidget({this.bloc});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Text input
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                onTap: () {
                  listScrollController2
                      .jumpTo(listScrollController2.position.maxScrollExtent);
                },
                autofocus: false,
                cursorColor: Colors.black,
                cursorWidth: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.sp,
                ),
                controller: messageController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your query....',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 35.sp,
                  ),
                ),
              ),
            ),
          ),

          // Send Message Button
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 0.0),
            child: new IconButton(
              icon: new Icon(
                Icons.send,
                size: MediaQuery.of(context).size.height * 0.029,
              ),
              onPressed: () {
                widget.bloc.messagesEventController.sink.add(InsertMessage(
                    textController: messageController,
                    messageBody: {
                      "author": "user",
                      "message": messageController.text
                    }));
                messageController.clear();
                listScrollController2
                    .jumpTo(listScrollController2.position.maxScrollExtent);
              },
              color: Colors.black,
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 50.h,
      margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 23.h, top: 15.h),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(40.w),
          border: new Border.all(color: Colors.black, width: 1),
          color: Colors.white),
    );
  }
}
