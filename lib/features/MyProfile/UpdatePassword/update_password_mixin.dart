import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/MyProfile/UpdatePassword/update_password_page.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin UpdatePasswordMixin on State<UpdatePasswordPage> {
  String oldPassword = "";
  String newPassword = "";
  String repeatNewPassword = "";
  Services service = Services();
  PartnerController controller = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> updatePassword() async {
    return await service.updatePassword(
        customerMobilId: controller.currentAuth.value,
        oldPassword: oldPassword,
        newPassword: newPassword,
        accessToken: controller.accessToken.value);
  }
}
