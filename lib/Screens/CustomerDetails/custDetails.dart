import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/CustomerDetails/custextfield.dart';
import 'package:http/http.dart' as https;
import 'package:skyLenses/Screens/ProductList/checkAuth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerDetails extends StatefulWidget {
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final errorFields = SnackBar(
    content:
        Text("Fill all fields Correctly", style: TextStyle(fontSize: 40.sp)),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 900),
  );

// ======================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
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
      body: Builder(builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            left: 15,
            top: 10,
            right: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter a shipping address',
                  style:
                      TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Text(
                  'Add a new address',
                  style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 20.w),
                CustomTextField(
                    hintText: "Full name", controller: nameController),
                CustomTextField(
                  hintText: "Mobile number",
                  controller: mobileController,
                  fieldType: TextInputType.number,
                ),
                CustomTextField(hintText: "Email", controller: emailController),
                CustomTextField(
                  hintText: "PIN code",
                  controller: pincodeController,
                  fieldType: TextInputType.number,
                ),
                CustomTextField(
                    hintText: "Flat,House no.,Building,Company,Apartment",
                    controller: flatController),
                CustomTextField(
                    hintText: "Area,Colony,Street,Sector,Village",
                    controller: areaController),
                CustomTextField(
                    hintText: "Landmark e.g. near Apollo Hospital",
                    controller: landmarkController),
                CustomTextField(
                    hintText: "Town/City", controller: cityController),
                CustomTextField(hintText: "State", controller: stateController),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  margin: EdgeInsets.only(bottom: 30.w),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.w)),
                    color: Colors.black,
                    onPressed: () async {
                      bool isEmailValid =
                          EmailValidator.validate(emailController.text);

                      pincodeValidator(String pincode) {
                        if (pincode.length == 6 &&
                            !(pincode.startsWith('0')) &&
                            !(pincode.contains(" "))) {
                          return true;
                        } else {
                          return false;
                        }
                      }

                      // FINAL VALIDATION
                      if (nameController.text != "" &&
                          mobileController.text != "" &&
                          (mobileController.text.length == 10) &&
                          (pincodeController.text.length == 6) &&
                          isEmailValid &&
                          flatController.text != "" &&
                          areaController.text != "" &&
                          landmarkController.text != "" &&
                          cityController.text != "" &&
                          stateController.text != "") {
                        print("VALIDATION SUCCESSFUL");
                        //SENDING DETAILS TO DB
                        var phoneNumber = await verifyCurrentUser();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        String url =
                            'https://www.skycosmeticlenses.com/api/cart/checkout/registerCustomer/$phoneNumber';
                        var response = await https.post(url, body: {
                          "fullName": nameController.text,
                          "mobileNumber": mobileController.text,
                          "pincode": pincodeController.text,
                          "flatNo": flatController.text,
                          "Area": areaController.text,
                          "landmark": landmarkController.text,
                          "city": cityController.text,
                          "state": stateController.text,
                          "email": emailController.text,
                        });
                      } else {
                        Scaffold.of(context).showSnackBar(errorFields);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 45.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
