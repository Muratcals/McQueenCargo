import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/CargoDetail/cargo_detail_page.dart';

mixin CargoDetailMixin on State<CargoDetailPage> {
  RxInt tabIndex = 0.obs;
  PartnerController controller = Get.find();
  Services service = Services();
  int cargoId = Get.arguments["cargoId"];
}
