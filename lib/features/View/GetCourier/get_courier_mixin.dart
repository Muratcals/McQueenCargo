import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_controller.dart';

mixin GetCourierMixin<T extends StatefulWidget> on State<T> {
  CarouselController carouselController = CarouselController();
  GetCourierController controller =  Get.put(GetCourierController());
}
