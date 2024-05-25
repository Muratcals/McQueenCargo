import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/register_page.dart';

mixin RegisterMixin on State<RegisterPage> {
  String incoming = Get.arguments;
  RxBool visibilty = false.obs;
  Services service = Services();

  Future<void> buttonProcess(PartnerController controller) async {
    if (incoming.contains("entry")) {
      Get.toNamed("/personalInformationPage");
    } else {
      visibilty.value = true;
      await service
          .createCustomer(
              controller.customerModel)
          .then((value) {
        Get.offAllNamed("/loginPage");
      }).onError((error, stackTrace) {});
      visibilty.value = false;
    }
  }
  
}
