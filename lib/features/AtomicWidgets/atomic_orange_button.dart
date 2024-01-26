import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AtomicOrangeButton extends StatefulWidget {
  const AtomicOrangeButton(
      {super.key, required this.onPressed, required this.title});

  final Function() onPressed;
  final String title;
  @override
  State<AtomicOrangeButton> createState() => _AtomicOrangeButtonState();
}

class _AtomicOrangeButtonState extends State<AtomicOrangeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.orange.shade500,
        gradient: LinearGradient(colors: [
          Colors.orange.shade700,
          Colors.orange.shade400,
          Colors.orange.shade300
        ], tileMode: TileMode.clamp),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
    );
  }
}
