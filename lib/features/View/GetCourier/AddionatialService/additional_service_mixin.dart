import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/AddionatialService/additiona_service_page.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AdditionalServiceMixin on State<AdditionalServicePage> {
  String type = Get.arguments["type"];
  double price = Get.arguments["price"];
  double weight = Get.arguments["weight"];
  PartnerController controller = Get.find();
  Services service = Services();
  double addionatialServicePrice = 0;
  int deliveryIndex = 0;
  double procurementPrice = 0;
  double delivertPrice = 0;

  @override
  void initState() {
    super.initState();
    priceCalculate();
  }

  void priceCalculate() {
    if (weight < 45) {
      updatePrice(1);
    } else if (weight > 45 && weight < 100) {
      updatePrice(2);
    } else {
      updatePrice(3);
    }
    procurementPrice = type == "KOLİ - PAKET"
        ? controller.packageProcurementServices[0].price
        : controller.fileProcurementServices[0].price;
    delivertPrice = type == "KOLİ - PAKET"
        ? controller.packageDeliveryServices[0].price
        : controller.fileDeliveryServices[0].price; 
    addionatialServicePrice =
        price + procurementPrice + delivertPrice;
  }

  void updatePrice(int count) {
    controller.packageDeliveryServices[0].price =
        controller.packageDeliveryServices[0].price * count;
    controller.packageDeliveryServices[1].price =
        controller.packageDeliveryServices[1].price * count;
    controller.packageProcurementServices[0].price =
        controller.packageProcurementServices[0].price * count;
    controller.packageProcurementServices[1].price =
        controller.packageProcurementServices[1].price * count;
  }
}
