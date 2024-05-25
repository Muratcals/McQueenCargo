import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Cargos/get_courier_cargos_page.dart';

mixin GetCourierCargosMixin on State<GetCourierCargosPage> {
  PartnerController controller = Get.find();
  Services service = Services();
  String tcNo = "";

  @override
  void initState() {
    super.initState();
    tcNo = controller.userInformation.value.tcNo ?? "";
  }
}
