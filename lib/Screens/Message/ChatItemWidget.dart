import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItemWidget extends StatelessWidget {
  final String author;
  final String messageContent;

  ChatItemWidget({this.author, this.messageContent});

  @override
  Widget build(BuildContext context) {
    if (author == "user") {
      //  VALID FOR USER MESSAGES
      return Container(
        constraints: BoxConstraints(
            minWidth: 100, maxWidth: MediaQuery.of(context).size.width * 0.6),
        margin: EdgeInsets.only(bottom: 0, top: 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.3,
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    messageContent,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.sp,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  decoration: BoxDecoration(
                      border: new Border.all(color: Colors.black, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: EdgeInsets.only(right: 10.0),
                )
              ],
              mainAxisAlignment:
                  MainAxisAlignment.end, // aligns the chatitem to right end
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[])
          ],
        ),
      );
      // VALID FOR ADMIN CONTAINER
    } else {
      return Container(
        constraints: BoxConstraints(
            minWidth: 100, maxWidth: MediaQuery.of(context).size.width * 0.6),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.3,
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Text(
                    messageContent,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.sp,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 5.0),
      );
    }
  }
}
