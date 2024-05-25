import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/AddionatialService/additiona_service_page.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';

mixin AdditionalServiceMixin on State<AdditionalServicePage> {
  Services service = Services();
  double addionatialServicePrice = 0;
  int deliveryIndex = 0;
  double procurementPrice = 0;
  double delivertPrice = 0;
  late String type;
  late double price;
  late double weight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = Get.arguments;
    weight = arguments["weight"];
    type = arguments["type"];
    price = arguments["price"];
    priceCalculate();
  }

  void priceCalculate() {
    if (weight <= 45) {
      updatePrice(1);
    } else if (weight > 45 && weight <= 100) {
      updatePrice(2);
    } else {
      updatePrice(3);
    }
    additionalPriceUpdate();
  }

  void additionalPriceUpdate() {
    procurementPrice = type == "KOLİ - PAKET"
        ? AdditionalServicePrice.packageProcurementServices[0].price
        : AdditionalServicePrice.fileProcurementServices[0].price;
    delivertPrice = type == "KOLİ - PAKET"
        ? AdditionalServicePrice.packageDeliveryServices[0].price
        : AdditionalServicePrice.fileDeliveryServices[0].price;
    addionatialServicePrice = price + procurementPrice + delivertPrice;
  }

  void updatePrice(int count) {
    AdditionalServicePrice.packageDeliveryServices[0].price =
        AdditionalServicePrice.packageDeliveryServices[0].price * count;
    AdditionalServicePrice.packageDeliveryServices[1].price =
        AdditionalServicePrice.packageDeliveryServices[1].price * count;
    AdditionalServicePrice.packageProcurementServices[0].price =
        AdditionalServicePrice.packageProcurementServices[0].price * count;
    AdditionalServicePrice.packageProcurementServices[1].price =
        AdditionalServicePrice.packageProcurementServices[1].price * count;
  }
}
