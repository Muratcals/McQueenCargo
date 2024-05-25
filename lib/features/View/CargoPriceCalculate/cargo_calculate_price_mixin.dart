import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/cargo_calculate_price_controller.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/cargo_calculate_price_page.dart';

mixin CargoPricaCalculateMixin on State<CargoPricaCalculatePage> {
  CalculatePriceController controller = Get.put(CalculatePriceController());
}
