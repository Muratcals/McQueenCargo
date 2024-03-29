import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/cargo_calculate_price_page.dart';
import 'package:mc_queen_cargo/features/View/Cargos/get_courier_cargos_page.dart';
import 'package:mc_queen_cargo/features/View/Home/home_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/my_profile_page.dart';

class MainPageWidgets {
  PartnerController controller = Get.find();

  Text textWidgets({required String title}) => Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 12.sp, fontFamily: "Arial"),
      );

  Widget bottomSheetWidget(String value) {
    if (value.contains("main")) {
      return const HomePage();
    } else if (value.contains("myCargos")) {
      return const GetCourierCargosPage();
    } else if (value.contains("getCourier")) {
      return const GetCourierPage();
    } else if (value.contains("calculatePrice")) {
      return const CargoPricaCalculatePage();
    } else {
      return const MyProfilePage();
    }
  }
}
