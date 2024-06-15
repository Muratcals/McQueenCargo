import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  Future<void> buttonProcess(BuildContext buildContext) async {
    if (incoming.contains("entry")) {
      Get.toNamed(GenerateRoute.personalInformationPage);
    } else {
      visibilty.value = true;
      var model = buildContext.read<CreteCustomerState>().state;
      await service.createCustomer(model).then((value) {
        EasyLoading.showToast("Kullanıcı başarıyla oluşturulmuştur");
        Get.toNamed(GenerateRoute.loginPage);
      }).onError((error, stackTrace) {});
      visibilty.value = false;
    }
  }
}
