import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPageWidgets {
  AppBar registerAppBar() {
    return AppBar(
      toolbarHeight: 30.h,
      leading: appBarIcon(),
      flexibleSpace: appbarFlexibleSpace(),
      centerTitle: true,
      title: Text(
        "Üye Ol",
        style: TextStyle(fontSize: 15.sp),
      ),
    );
  }

  Column registerPageColumnItems(String number, String title, String incoming) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          contentPadding: CustomPadding.allInset(0),
          title: Text(
            title,
            style: TextStyle(fontSize: 17.sp, color: Colors.grey),
          ),
          leading: Container(
            width: 20.w,
            height: 20.h,
            margin: CustomPadding.onlyHorizontalInset(10),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                number,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          trailing: incoming.contains("entry")
              ? null
              : Container(
                  width: 20.w,
                  height: 20.h,
                  margin: CustomPadding.onlyHorizontalInset(10),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
        ),
        Divider(
          endIndent: 70.w,
          indent: 70.w,
          height: 2.h,
          color: Colors.black,
        )
      ],
    );
  }
}
