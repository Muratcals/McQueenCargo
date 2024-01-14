import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin GetCourierMixin<T extends StatefulWidget> on State<T> {
  List<String> months = [
    "",
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];
  CarouselController carouselController = CarouselController();
  RxBool selectedAddress = false.obs;
  RxInt selectedDate = 0.obs;
  PartnerController controller = Get.find();
  final customerAddresssModel = AddressModel().obs;
  final receiverAddressModel = ReceiverAddressModel().obs;
  String monthConverter(int index) {
    return months[index];
  }
}


