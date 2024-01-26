import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/SelectedPostType/selected_post_type_page.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SelectedPostTypeMixin on State<SelectedPostType> {
  double weight = Get.arguments["weight"];
  String type = Get.arguments["type"];
  double price = Get.arguments["price"];

  String title = "Gönderi Şekli Seçimi";
  RxInt selectedValue = 1.obs;
  Services service = Services();
  PartnerController controller = Get.find();

  @override
  void initState() {
    super.initState();
    type == "KOLİ - PAKET" ? priceCalculate() : null;
  }

  double priceCalculate() {
    if (weight < 45) {
      return price = price * 1;
    } else if (weight > 45 && weight < 100) {
      return price = price * 2;
    } else {
      return price = price * 3;
    }
  }
}
