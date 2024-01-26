import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPadding {
  static EdgeInsets onlyHorizontalInset(double value) =>
      EdgeInsets.symmetric(horizontal: value.w, vertical: 0);
  static EdgeInsets onlyVerticalInset(double value) =>
      EdgeInsets.symmetric(vertical: value.h, horizontal: 0);
  static EdgeInsets symmetricInset(double horizantal, double vertical) =>
      EdgeInsets.symmetric(horizontal: horizantal.w, vertical: vertical.h);
  static EdgeInsets allInset(double value) => EdgeInsets.all(value);
  static EdgeInsets only(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      EdgeInsets.only(
          left: left.w, top: top.h, right: right.w, bottom: bottom.h);
}
