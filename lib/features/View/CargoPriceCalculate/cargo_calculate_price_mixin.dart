import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/cargo_calculate_price_page.dart';

mixin CargoPricaCalculateMixin on State<CargoPricaCalculatePage> {
  AddressModel? customerAddressModel;
  ReceiverAddressModel? recevierAddressModel;
}
