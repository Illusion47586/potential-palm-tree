import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyLenses/LocalData/HomeScreen/CategoryCards.dart';
import 'package:skyLenses/Screens/Account/account.dart';
import 'package:skyLenses/Screens/Cart/cartTabBar.dart';
import 'package:skyLenses/Screens/HomeScreen/DisplayCoupons.dart';
import 'package:skyLenses/Screens/HomeScreen/customSpinTheWheel.dart';
import 'package:skyLenses/Screens/HomeScreen/widgets/CategoryCard.dart';
import 'package:skyLenses/Screens/Message/message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:skyLenses/Screens/Reviews/ReviewScreen.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class HomePage extends StatefulWidget {
  static int currentIndex = 0;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = SpinWheelBloc();
  // SPIN WHEEL===========================================

  final List<Widget> _children = [
    ConversationPage(),
    CartTabBar(),
    AccountScreen(),
    ReviewSreen(),
  ];

  @override
  void initState() {
    super.initState();
    bloc.spinEventsController.sink.add(CheckIsSpinEnabled());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.spinEventsController.sink.add(CheckIsSpinEnabled());
  }

  @override
  Widget build(BuildContext context1) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    final loginSnackBar = SnackBar(
      content: Text(
        "Please sign in/sign up your account",
        style: TextStyle(fontSize: 40.sp),
      ),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 700),
    );
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: MediaQuery.of(context).size.height * 0.034,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: HomePage.currentIndex,
        showUnselectedLabels: true,
        selectedFontSize: 30.sp,
        unselectedFontSize: 30.sp,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        onTap: (index) {
          HomePage.currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
            ),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(Icons.message),
              onTap: () {
                FlutterOpenWhatsapp.sendSingleMessage("919711981848", "Hello");
              },
            ),
            title: Text('Message'),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shoppingBag),
            title: Text('Bag'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('Account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feedback_rounded,
            ),
            title: Text('Reviews'),
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.065,
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.09,
              child: Image.asset(
                "assets/SplashScreen/skyLogo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: HomePage.currentIndex == 0
          ? Builder(builder: (context) {
              bloc.spinEventsController.sink.add(CheckIsSpinEnabled());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        color: Colors.grey[200],
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: MediaQuery.of(context).size.width,
                        child: Carousel(
                          animationDuration: Duration(seconds: 1),
                          dotVerticalPadding: 0,
                          indicatorBgPadding: 10.h,
                          images: [
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img1.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img2.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img3.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img4.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img5.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img6.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img7.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 5000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img8.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            CachedNetworkImage(
                              memCacheWidth: 8000,
                              imageUrl:
                                  "https://skyphotos.s3.ap-south-1.amazonaws.com/sliders/img9.jpg",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ],
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.026),
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (await verifyCurrentUser() == "") {
                                  Scaffold.of(context)
                                      .showSnackBar(loginSnackBar);
                                  // SHOW SNACK BAR
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DisplayCoupons()));
                                }
                              },
                              child: Opacity(
                                opacity: 1,
                                child: Container(
                                  height: 0.14.hp,
                                  width: 0.14.hp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                      child: FittedBox(
                                    child: Text('Wallet',
                                        style: TextStyle(
                                          fontSize: 44.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              height: 0.17.hp,
                              width: 0.17.hp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                  'assets/SplashScreen/boxCover.png'),
                            ),
                            StreamBuilder<Object>(
                                stream: bloc.isSpinEnabledController.stream
                                    .asBroadcastStream(),
                                initialData: false,
                                builder: (context, snapshot) {
                                  return InkWell(
                                      onTap: snapshot.data
                                          ? () {
                                              // Scaffold.of(context)
                                              //     .showSnackBar(disabledSnackBar);
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      13.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      13.0))),
                                                  enableDrag: true,
                                                  // isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return CustomSpinTheWheel(
                                                      context: context,
                                                      bloc: bloc,
                                                    );
                                                  });
                                              // Future.delayed(
                                              //     Duration(seconds: 6), () {
                                              //   Scaffold.of(context)
                                              //       .hideCurrentSnackBar();
                                              // });
                                            }
                                          : () {},
                                      child: Opacity(
                                        opacity: snapshot.data ? 1 : 0.4,
                                        child: Container(
                                          height: 0.14.hp,
                                          width: 0.14.hp,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: ClipRRect(
                                            child: Image.asset(
                                              'assets/HomeScreen/smallSpinning.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                          ],
                        )),
                    SizedBox(height: 0.02.hp),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(categoryData.length, (index) {
                            return CategoryCard(
                              categoryName: categoryData[index]["categoryName"],
                              categoryTagline: categoryData[index]
                                  ["categoryTagline"],
                              color1: categoryData[index]["color1"],
                              color2: categoryData[index]["color2"],
                              imgUrl: categoryData[index]["imgUrl"],
                              alignment: categoryData[index]["alignment"],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          : _children[HomePage.currentIndex - 1],
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
