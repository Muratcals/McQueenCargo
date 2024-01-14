import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page_widgets.dart';

mixin MainMixin on State<MainPage> {
  MainPageWidgets widgets = MainPageWidgets();
  PartnerController partnerController = Get.find();
  Services service = Services();
  int userId = Get.arguments["userId"];
}
