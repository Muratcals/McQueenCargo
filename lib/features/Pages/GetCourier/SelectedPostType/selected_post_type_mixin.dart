import 'package:mc_queen_cargo/features/Pages/GetCourier/SelectedPostType/selected_post_type_page.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SelectedPostTypeMixin on State<SelectedPostType> {
  late double weight;
  late String type;
  late double price;
  String title = "Gönderi Şekli Seçimi";
  Services service = Services();

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments;
    weight = arguments["weight"];
    type = arguments["type"];
    price = arguments["price"];
    type == "KOLİ - PAKET" ? priceCalculate() : null;
  }

  double priceCalculate() {
    if (weight <= 45) {
      return price = price * 1;
    } else if (weight > 45 && weight <= 100) {
      return price = price * 2;
    } else {
      return price = price * 3;
    }
  }
}
