import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Pages/Register/Password/password_page.dart';

mixin PasswordPageMixin on State<PasswordPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final password1 = "".obs;
  final password2 = "".obs;

  void onPressed() {
    bool isValidate = key.currentState!.validate();
    if (isValidate) {
      key.currentState!.save();
      FocusScope.of(context).unfocus();
      Get.toNamed(GenerateRoute.registerPage,arguments: "finish");
    }
  }
}
