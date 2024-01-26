import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/register_page.dart';
import 'package:mc_queen_cargo/features/View/Register/register_widgets.dart';

mixin RegisterMixin on State<RegisterPage> {
  RegisterPageWidgets widgets = RegisterPageWidgets();
  String incoming = Get.arguments;
  PartnerController controller = Get.find();
  RxBool visibilty = false.obs;
  Services service = Services();
  
}
