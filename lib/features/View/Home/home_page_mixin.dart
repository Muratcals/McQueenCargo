import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Home/home_page.dart';

mixin HomePageMixin on State<HomePage> {
  PartnerController controller = Get.find();
  Services service = Services();
  String trackingNo = "";
}
