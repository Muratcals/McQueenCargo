import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin GetCourierMixin<T extends StatefulWidget> on State<T> {
  
  CarouselController carouselController = CarouselController();
  RxBool selectedAddress = false.obs;
  RxInt selectedDate = 0.obs;
  final customerAddresssModel = AddressModel().obs;
  final receiverAddressModel = ReceiverAddressModel().obs;
  
}


