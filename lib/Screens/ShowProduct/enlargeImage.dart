import 'package:flutter/material.dart';

class EnlargeImage extends StatelessWidget {
  final String imgUrl;
  EnlargeImage({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Center(
            child: Image.asset(
          imgUrl,
          fit: BoxFit.contain,
        )));
  }
}
