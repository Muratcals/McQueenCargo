import 'package:mc_queen_cargo/features/Model/price_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceDetail/View/price_detail_page.dart';

mixin PriceDetailMixin on State<PriceDetailPage> {
  String title = "Fiyat detay";
  PriceDetailModel model = Get.arguments["model"];
  String incoming = Get.arguments["incoming"];

  void updateDeliveryPrice(double deliveryPrice) {
    model.additionalServicePrice += deliveryPrice;
    model.kdv =
        ((model.additionalServicePrice + model.transportPrice) *
                20) /
            100;
  }

  void updateProcurementPrice(double procurementPrice) {
    model.additionalServicePrice += procurementPrice;
    model.kdv =
        ((model.additionalServicePrice + model.transportPrice) *
                20) /
            100;
  }

}
