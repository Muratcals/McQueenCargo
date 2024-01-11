import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/MyProfile/my_profile_page.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin MyProfileMixin on State<MyProfilePage> {
  PartnerController controller = Get.find();
  Services service = Services();

  Future<void> deleteCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userId", 0);
    controller.currentAuth.value = 0;
    controller.userInformation.value = LoginModel();
  }
}
