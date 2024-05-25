import 'package:mc_queen_cargo/features/Authorazation/auth_information.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/Pages/Cargos/get_courier_cargos_page.dart';

mixin GetCourierCargosMixin on State<GetCourierCargosPage> {
  Services service = Services();
  String tcNo = "";

  @override
  void initState() {
    super.initState();
    tcNo = AuthInformation.auth.tcNo ?? "";
  }
}
