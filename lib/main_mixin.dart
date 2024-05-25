// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mc_queen_cargo/main.dart';

mixin MainAppMixin on State<MainApp> {
  RxBool visibility = true.obs;

  @override
  void initState() {
    super.initState();
    networkController();
    connectionStream();
  }

  void networkController() async {
    var connectivity = await Connectivity().checkConnectivity();
    connectivity == ConnectivityResult.none
        ? visibility.value = false
        : visibility.value = true;
  }

  void connectionStream() {
    Connectivity().onConnectivityChanged.listen(
      (event) {
        event == ConnectivityResult.none
            ? visibility.value = false
            : visibility.value = true;
      },
    );
  }
}

class AppbarFlexibleSpace extends StatelessWidget {
  const AppbarFlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.blue.shade700
          ],
        ),
      ),
    );
  }
}

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Icons.chevron_left,
        color: Colors.white,
        size: 25.sp,
      ),
    );
  }
}

/// [Color] color default [Colors.black]
/// [FontWeight] fontWeight default [FontWeight.normal]
class GeneralTextWidget extends StatelessWidget {
  const GeneralTextWidget({
    Key? key,
    required this.title,
    required this.fontsize,
    this.color,
    this.fontWeight,
  }) : super(key: key);
  final String title;
  final double fontsize;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          decoration: TextDecoration.none,
          color: color ?? Colors.black,
          fontSize: fontsize,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: "times"),
    );
  }
}
