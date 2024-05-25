import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/ContactInformation/contact_information_page.dart';

mixin ContactInformationPageMixin on State<ContactInformationPage> {
  PartnerController controller = Get.find();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxString eMail = "".obs;

  void onPressed() {
    bool isValidate = key.currentState!.validate();
    if (isValidate) {
      key.currentState!.save();
      FocusScope.of(context).unfocus();
      Get.toNamed("/passwordPage");
    }
  }
}
