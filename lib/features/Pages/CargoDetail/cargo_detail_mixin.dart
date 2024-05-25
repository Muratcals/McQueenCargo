import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/CargoDetail/cargo_detail_page.dart';

mixin CargoDetailMixin on State<CargoDetailPage> {
  RxInt tabIndex = 0.obs;
  Services service = Services();
  int cargoId = Get.arguments["cargoId"];
}
