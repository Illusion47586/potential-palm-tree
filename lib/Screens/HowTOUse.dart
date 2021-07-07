import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
        child: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 40.sp)),
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.065,
              child: Image.asset(
                "assets/SplashScreen/skyLogo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffFAE8C8),
        ),
      ),
      backgroundColor: Color(0xffFAE8C8),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.h),
                Text("How To Use",
                    style: TextStyle(
                        fontSize: 50.sp, fontWeight: FontWeight.w800)),
                SizedBox(height: 18.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/HomeScreen/howTouse.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 18.h),
                Container( 
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 12),
                    margin: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact Lens Care",
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.w800)),
                        SizedBox(height: 13),
                        Text(
                            '1.Keep the contact lens case clean and replace it regularly atleast in every 3 months.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '2.Rinse the contact lens every time beore you wear and after you wore them.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '3.Rinse the contact lens case with fresh solution not with water.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '4.Do not allow tip of the solution bottle to come in contact with any surface and keep the bottle tightly closed when not in use.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '5.Change the solution in the lens carrying case daily after use.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '6.In case of irritation take off the lens from eye and clean it with lens solution,if problem persists then put eye drop in your eyes,to clean them.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text("CAUTIONS",
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.w800)),
                        SizedBox(height: 15.w),
                        Text(
                            '1.THOSE WHO HAVE ANY EYE DISEASE OR ARE SERIOUSLY ALLERGIC TO CONTACT LENS MUST NOT USE THE LENS.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            "2.CHECK IF YOU HAVE ANY DISEASE IN YOUR EYES OR WHOLE BODY,THEN FOLLOW AN OPTHALMOLOGIST\'S DIRECTION IN USING IT.",
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '3.DO NOT USE IF THE STERILE VIAL PACKAGE IS OPENED OR DAMAGED.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text('4.STORE IT IN A PRESERVATION SOLUTION FOR LENS.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '5.	USE A CLEANER, A RINSER OR A LUBRICANT APPROPRIATE FOR THE LENS MATERIALS.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '6.	IF YOU FEEL A SEVERE PAIN OR AN ALIEN SUBSTANCE DON’T PANNIC JUST TAKE THE LENS OUT OF YOUR EYES CLEAN IT AND CLEAN YOUR EYES AS WELL BY PUTTING EYE CARE SOLUTION IN EYE.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '7.	IF YOU HAVE AN UNSTABLE SIGHT DUE TO A DRY SURFACE OF A LENS, SUPPLEMENT ARTIFICIAL TEARS OR A PHYSIOLOGICAL SALINE SOLUTION AND BLINK YOUR EYES T GET NORMAL SIGHT.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '8.	IF YOU HAVE EYE STRAIN DUE TO OVERWORK, INSUFFICIENT SLEEP, OR LONG-TIME READING, STOP USING A LENS AND TAKE A REST FOR A WHILE.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '9.	USE PHYSIOLOGICAL SALINE SOLUTION, A CLEANER, OR A PRESERVATIVE SOLUTION, AND NEVER USE TAP WATER OR OTHER PRIVATELY-MADE INFERIOR GOODS.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text(
                            '10.	ENSURE A LENS DOES NOT CONTACT WITH SOAP, SHAMPOO, HAIR SPRAY, OR COSMETICS, AND PUT ON MAKEUP AFTER WEARING A LENS.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                        Text('11.	DO NOT LEAVE A FLAW WITH A FINGERNAIL.',
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.w),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
