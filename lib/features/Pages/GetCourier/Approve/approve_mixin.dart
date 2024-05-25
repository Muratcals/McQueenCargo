import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/Approve/approve_page.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Constants/GetCourierCubit/post_courier_cubit.dart';

mixin ApproveMixin on State<ApprovePageBody> {
  late String type;
  late double price;
  late int deliveryIndex;
  Services service = Services();
  double tax = 0;
  double sumPrice = 0;
  RxBool visibilty = false.obs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = Get.arguments;
    type = arguments["type"];
    price = arguments["price"];
    deliveryIndex = arguments["deliveryIndex"];
    tax = (price * 20) / 100;
    sumPrice = tax + price;
  }

  void onPressed() {
    visibilty.value = true;
    context.read<GetCourierPostCubit>().state.callCourierOk = false;
    context.read<GetCourierPostCubit>().state.cargoTransportationConditionsId =
        1;
    context.read<GetCourierPostCubit>().state.price =
        double.parse(sumPrice.toStringAsFixed(2));
    service
        .postCargo(
      model: context.read<GetCourierPostCubit>().state,
    )
        .then((value) {
      EasyLoading.showSuccess(value);
      context.read<GetCourierPostCubit>().clearModel();
      _updateAdditionalService();
      Get.until((route) => Get.currentRoute == "/main");
      // Get.offAllNamed("/main",arguments: {
      //   "userId":0
      // });
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString());
      visibilty.value = false;
    });
  }

  void _updateAdditionalService() {
    AdditionalServicePrice.packageProcurementServices.clear();
    AdditionalServicePrice.packageProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);

    AdditionalServicePrice.packageDeliveryServices.clear();
    AdditionalServicePrice.packageDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adrese Teslimat", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);

    AdditionalServicePrice.fileProcurementServices.clear();
    AdditionalServicePrice.fileProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 13.55),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);

    AdditionalServicePrice.fileDeliveryServices.clear();
    AdditionalServicePrice.fileDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adrese Teslimat", price: 13.48),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);
  }
}
