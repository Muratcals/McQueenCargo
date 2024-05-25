import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Pages/Register/PersonalInformation/personal_information_page.dart';

mixin PersonalInformationMixin on State<PersonalInformationPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  void onPressed() {
    var isValidate = key.currentState!.validate();
    if (isValidate) {
      key.currentState!.save();
      FocusScope.of(context).unfocus();
      Get.toNamed(GenerateRoute.contactInformationPage);
    }
  }
}
