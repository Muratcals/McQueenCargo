import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/UpdatePassword/update_password_page.dart';

mixin UpdatePasswordMixin on State<UpdatePasswordPage> {
  RxString oldPassword = "".obs;
  RxString newPassword = "".obs;
  RxString repeatNewPassword = "".obs;
  Services service = Services();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> updatePassword() async {
    return await service.updatePassword(
        oldPassword: oldPassword.value,
        newPassword: newPassword.value);
  }

  void onPressedButton() {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      formKey.currentState!.save();
      updatePassword().then((value) {
        EasyLoading.showToast(value);
        Get.back();
        return value;
      }).onError((error, stackTrace) {
        EasyLoading.showToast(error.toString());
        return error.toString();
      });
    }
  }
}
