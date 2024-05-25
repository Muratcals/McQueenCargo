import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/post_courier_model.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/Approve/approve_page.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ApproveMixin on State<ApprovePage> {
  final String title = "Onayla";
  String type = Get.arguments["type"];
  double price = Get.arguments["price"];
  int deliveryIndex = Get.arguments["deliveryIndex"];
  Services service = Services();
  double tax = 0;
  double sumPrice = 0;
  RxBool visibilty = false.obs;
  PartnerController controller = Get.find();

  @override
  void initState() {
    super.initState();
    tax = (price * 20) / 100;
    sumPrice = tax + price;
  }

  void onPressed() {
    visibilty.value = true;
    controller.getCourierModel.value.callCourierOk = false;
    controller.getCourierModel.value.cargoTransportationConditionsId = 1;
    controller.getCourierModel.value.price =
        double.parse(sumPrice.toStringAsFixed(2));
    service
        .postCargo(
            model: controller.getCourierModel.value,)
        .then((value) {
      EasyLoading.showSuccess(value);
      controller.getCourierModel.value = PostCourierModel();
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
    controller.packageProcurementServices.clear();
    controller.packageProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);

    controller.packageDeliveryServices.clear();
    controller.packageDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adrese Teslimat", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);

    controller.fileProcurementServices.clear();
    controller.fileProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 13.55),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);

    controller.fileDeliveryServices.clear();
    controller.fileDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adrese Teslimat", price: 13.48),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);
  }
}
