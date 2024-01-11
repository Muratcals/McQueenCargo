import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Register/Password/password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin PasswordPageMixin on State<PasswordPage> {
  PartnerController controller = Get.find();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final password1 = "".obs;
  final password2 = "".obs;
}
