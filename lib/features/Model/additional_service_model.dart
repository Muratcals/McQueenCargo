import 'package:flutter/material.dart';

class AdditionalServiceModel {
  String name;
  double price;
  IconData? icon;

  AdditionalServiceModel(
      {required this.name, required this.price, this.icon = Icons.home});
}
