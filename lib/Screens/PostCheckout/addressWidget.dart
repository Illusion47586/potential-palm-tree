import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/PostCheckout/postCheckoutBloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressWidget extends StatefulWidget {
  final Map<String, dynamic> customerDetails;
  final PostCheckoutBloc bloc;
  AddressWidget({this.customerDetails, this.bloc});
  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  var isSelected;
  @override
  Widget build(BuildContext context) {
    return widget.customerDetails != null
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w),
            ),
            margin: EdgeInsets.only(top: 20.w, left: 10.w, right: 10.w),
            padding: EdgeInsets.only(left: 3, right: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                StreamBuilder(
                    initialData: {},
                    stream:
                        widget.bloc.radioController.stream.asBroadcastStream(),
                    builder: (context, snapshot) {
                      return Container(
                        height: 80.w,
                        width: 80.w,
                        margin: EdgeInsets.only(left: 10.w),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Radio(
                            value: widget.customerDetails,
                            groupValue: snapshot.data,
                            onChanged: (val) {
                              widget.bloc.postCheckoutEventsController.sink
                                  .add(ControlRadioButton(value: val));
                            },
                            activeColor: Colors.black,
                          ),
                        ),
                      );
                    }),
                SizedBox(width: 10.w),
                FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.customerDetails["fullName"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 45.sp,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.71,
                        decoration: BoxDecoration(),
                        // width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.customerDetails["flatNo"] +
                              " " +
                              widget.customerDetails["Area"] +
                              " " +
                              widget.customerDetails["landmark"] +
                              " " +
                              widget.customerDetails["city"] +
                              " " +
                              widget.customerDetails["pincode"],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 40.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.bloc.postCheckoutEventsController.add(RemoveAddress(
                        flatNo: widget.customerDetails["flatNo"]));
                  },
                  child: Icon(Icons.restore_from_trash,
                      color: Colors.black, size: 50.sp),
                ),
              ],
            ),
          )
        : Container();
  }
}
