import 'package:mc_queen_cargo/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

Container appbarFlexibleSpace() {
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

IconButton appBarIcon() {
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

Text textWidget(
        {required String title,
        required double fontsize,
        Color color = Colors.black,
        FontWeight fontWeight = FontWeight.normal}) =>
    Text(
      title,
      style: TextStyle(
          decoration: TextDecoration.none,
          color: color,
          fontSize: fontsize,
          fontWeight: fontWeight,
          fontFamily: "times"),
    );
    
