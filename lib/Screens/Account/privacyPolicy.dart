import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key}) : super(key: key);
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.065,
        ),
        child: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 50.sp,
              )),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                '{This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from skycosmeticlenses.com (the “Site”). PERSONAL INFORMATION WE COLLECT When you visit the Site, we automatically collect certain information about your device, including information about your web browser, IP address, time zone, and some of the cookies that are installed on your device. Additionally, as you browse the Site, we collect information about the individual web pages or products that you view, what websites or search terms referred you to the Site, and information about how you interact with the Site. We refer to this automatically-collected information as “Device Information”.We collect Device Information using the following technologies:- “Cookies” are data files that are placed on your device or computer and often include an anonymous unique identifier. For more information about cookies, and how to disable cookies, visit http://www.allaboutcookies.org.- “Log files” track actions occurring on the Site, and collect data including your IP address, browser type, Internet service provider, referring/exit pages, and date/time stamps. - “Web beacons”, “tags”, and “pixels” are electronic files used to record information about how you browse the Site.Additionally when you make a purchase or attempt to make a purchase through the Site, we collect certain information from you, including your name, billing address, shipping address, payment information (including credit card numbers), email address, and phone number. We refer to this information as "Order Information”. When we talk about “Personal Information” in this Privacy Policy, we are talking both about Device Information and Order Information. HOW DO WE USE YOUR PERSONAL INFORMATION? We use the Order Information that we collect generally to fulfill any orders placed through the Site (including processing your payment information, arranging for shipping, and providing you with invoices and/or order confirmations). Additionally, we use this Order Information to: - Communicate with you; - Screen our orders for potential risk or fraud; and - When in line with the preferences you have shared with us, provide you with information or advertising relating to our products or services. We use the Device Information that we collect to help us screen for potential risk and fraud (in particular, your IP address), and more generally to improve and optimize our Site (for example, by generating analytics about how our customers browse and interact with the Site, and to assess the success of our marketing and advertising campaigns). BEHAVIOURAL ADVERTISING. As described above, we may in the future use your Personal Information to provide you with targeted advertisements or marketing communications we believe may be of interest to you.  DO NOT TRACK Please note that we do not alter our Site’s data collection and use practices when we see a Do Not Track signal from your browser. DATA RETENTION .When you place an order through the Site, we will maintain your Order Information for our records unless and until you ask us to delete this information. CHANGES. We may update this privacy policy from time to time in order to reflect, for example, changes to our practices or for other operational, legal or regulatory reasons. CONTACT US.For more information about our privacy practices, if you have questions, or if you would like to make a complaint, please contact us by e mail at',
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15, top: 2),
              child: Text(
                'skycosmeticlenses@gmail.com',
                style: TextStyle(fontSize: 39.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
