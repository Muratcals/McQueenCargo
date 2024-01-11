import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AtomicTextFormField extends TextFormField {
  AtomicTextFormField(
      {super.key,
      super.onSaved,
      required String title,
      super.onChanged,
      Color fontColor = Colors.black,
      required super.validator,
      super.keyboardType,
      double fontSize = 13,
      super.inputFormatters,
      super.obscureText = false})
      : super(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            labelText: title,
            labelStyle: TextStyle(
                color: fontColor, fontFamily: "Arial", fontSize: fontSize),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        );
}
