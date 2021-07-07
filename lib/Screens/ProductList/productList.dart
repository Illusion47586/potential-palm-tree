import 'package:flutter/material.dart';
import 'package:skyLenses/LocalData/naturalProductsList.dart.dart';
import 'package:skyLenses/LocalData/duskyProductsList.dart';
import 'package:skyLenses/Screens/ProductList/widgets/productListCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductList extends StatelessWidget { 
  final String categoryName;
  ProductList({this.categoryName});

  @override
  Widget build(BuildContext context) {
        ScreenUtil.init(context, designSize: Size(750, 1334));
    return Scaffold( 
      backgroundColor:
          categoryName == "Dusky Sky" ? Color(0xffD5F6FC) : Color(0xffD7F8E4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          0.07.hp,
        ),
        child: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.031)),
          elevation: 0,
          centerTitle: true,
          brightness: Brightness.dark,
          backgroundColor: categoryName == "Dusky Sky"
              ? Color(0xff042460)
              : Color(0xff316436),
          title: Text(categoryName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.031)),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                children: List.generate(
                    categoryName == "Dusky Sky"
                        ? duskyProductList.length
                        : naturalProductList.length, (index) {
                  return ProductListCard(
                      productInfo: categoryName == "Dusky Sky"
                          ? duskyProductList[index]
                          : naturalProductList[index]);
                }),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
