import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType fieldType;

  CustomTextField(
      {this.hintText, this.controller, this.fieldType = TextInputType.text});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          bottom: 24.w,
        ),
        child: TextField(
          style: TextStyle(fontSize: 40.sp),
          cursorColor: Colors.black,
          cursorWidth: 2,
          controller: widget.controller,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 40.sp),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.w)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.w)),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: widget.fieldType,
        ));
  }
}
