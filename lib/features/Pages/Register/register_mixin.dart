import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/Register/Controller/create_customer_cubit.dart';
import 'package:mc_queen_cargo/features/Pages/Register/register_page.dart';

mixin RegisterMixin on State<RegisterPage> {
  late String incoming;
  RxBool visibilty = false.obs;
  Services service = Services();

  @override
  void initState() {
    super.initState();
    incoming = Get.arguments;
  }

  Future<void> buttonProcess() async {
    if (incoming.contains("entry")) {
      Get.toNamed(GenerateRoute.personalInformationPage);
    } else {
      visibilty.value = true;
      await service
          .createCustomer(context.read<CreteCustomerState>().state)
          .then((value) {
        Get.toNamed(GenerateRoute.loginPage);
      }).onError((error, stackTrace) {});
      visibilty.value = false;
    }
  }
}
