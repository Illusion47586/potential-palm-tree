import "package:flutter/material.dart";
import 'package:skyLenses/Screens/Authentication/sendOtp.dart';
import 'package:skyLenses/Screens/Cart/cart.dart';
import 'package:skyLenses/Screens/Cart/orders.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartTabBar extends StatefulWidget {
  @override
  _CartTabBarState createState() => _CartTabBarState();
}

class _CartTabBarState extends State<CartTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

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
                backgroundColor: Color(0xffF0F0F0),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(110.h),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 4,
                    flexibleSpace: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 1))),
                        ),
                        Expanded(
                          child: Container(
                            child: TabBar(
                              labelPadding: EdgeInsets.all(0),
                              isScrollable: false,
                              controller: _tabController,
                              unselectedLabelColor: Color(0xffAEAEAE),
                              labelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 3.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              unselectedLabelStyle: TextStyle(),
                              indicator: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 4),
                                left: BorderSide(color: Colors.grey, width: 1),
                                right: BorderSide(color: Colors.grey, width: 1),
                              )),
                              tabs: [
                                Tab(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Bag',  
                                        style: TextStyle(
                                          fontSize: 41.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Orders',
                                        style: TextStyle(
                                          fontSize: 41.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    CartScreen(),
                    OrderScreen(),
                  ],
                  controller: _tabController,
                ),
              );
            } else {
              return LoginPage();
            }
          }
        });
  }
}
