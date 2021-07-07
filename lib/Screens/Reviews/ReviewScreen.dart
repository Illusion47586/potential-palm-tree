import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as https;

class ReviewSreen extends StatefulWidget {
  @override
  _ReviewSreenState createState() => _ReviewSreenState();
}

class _ReviewSreenState extends State<ReviewSreen> {
  bool isLoading = false;
  List review_list = [];
  void getReviews() async {
    setState(() {
      isLoading = true;
    });
    String url = 'https://www.skycosmeticlenses.com/api/reviews/getAllReviews';
    var response = await https.get(url);
    var res = json.decode(response.body);
    print(res);
    setState(() {
      isLoading = false;
      review_list = res["data"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    getReviews();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  int stars = 5;

  Future<void> submitRating(String review, String name, int stars) async {
    FocusManager.instance.primaryFocus.unfocus();
    try {
      String url = 'https://www.skycosmeticlenses.com/api/reviews/postReview';
      var response = await https.post(url, body: {
        "review": review,
        "given_by": name,
        "stars": (stars).toString()
      });
      var body = json.decode(response.body);
      print(body);
      getReviews();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container();
    }
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.31,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CupertinoTextField(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(25.w))),
                    controller: reviewController,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: TextStyle(fontSize: 30.sp, color: Colors.black),
                    placeholder: 'Your Review',
                    placeholderStyle: TextStyle(
                        fontSize: 30.sp,
                        color: CupertinoColors.placeholderText),
                  ),
                  SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(25.w))),
                    controller: nameController,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: TextStyle(fontSize: 30.sp, color: Colors.black),
                    placeholder: 'Your Name',
                    placeholderStyle: TextStyle(
                        fontSize: 30.sp,
                        color: CupertinoColors.placeholderText),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Rating: $stars',
                    style: TextStyle(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            stars = 1;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            stars = 2;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            stars = 3;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            stars = 4;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            stars = 5;
                          });
                        },
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: () async {
                      try {
                        String name = nameController.text == ""
                            ? "Unknown"
                            : nameController.text;
                        await submitRating(reviewController.text, name, stars);
                      } catch (err) {
                        print(err);
                      }
                    },
                    child: Text("Submit",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemBuilder: (ctx, review) {
                    List star = [];
                    for (var i = 0; i < review_list[review]["stars"]; i++) {
                      star.add("s");
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            '${review_list[review]["given_by"]}',
                            style: TextStyle(
                              fontSize: 35.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: star.map((r) {
                              return Icon(
                                Icons.star,
                                color: Colors.yellow,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${review_list[review]["review"]}',
                            style: TextStyle(
                              fontSize: 31.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: review_list.length,
                  reverse: true,
                )),
          ),
        ],
      ),
    );
  }
}
