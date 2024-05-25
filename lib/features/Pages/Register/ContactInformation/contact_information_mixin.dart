import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Pages/Register/ContactInformation/contact_information_page.dart';

mixin ContactInformationPageMixin on State<ContactInformationPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxString eMail = "".obs;

  void onPressed() {
    bool isValidate = key.currentState!.validate();
    if (isValidate) {
      key.currentState!.save();
      FocusScope.of(context).unfocus();
      Get.toNamed(GenerateRoute.passwordPage);
      Get.toNamed("/passwordPage");
    }
  }
}
