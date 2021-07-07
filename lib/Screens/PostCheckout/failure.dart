import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/HomeScreen/HomePage.dart';

class FailureScreen extends StatefulWidget {
  FailureScreen({Key key}) : super(key: key);

  @override
  _FailureScreenState createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          title: Text('An Error Occured',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: Image.asset(
                      'assets/Cart/Sad.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Text('There was an error processing your Payment! ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.red)),
          SizedBox(
            height: 15,
          ),
          Text('Please try again!',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              )),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 25),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text(
                'Back To Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ]));
  }
}
