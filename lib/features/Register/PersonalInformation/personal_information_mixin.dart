import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Register/PersonalInformation/personal_information_page.dart';
import 'package:mc_queen_cargo/features/Register/PersonalInformation/personal_information_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin PersonalInformationMixin on State<PersonalInformationPage> {
  PartnerController controller = Get.find();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  PersonelInformatinWidgets widgets =
      PersonelInformatinWidgets();
}
