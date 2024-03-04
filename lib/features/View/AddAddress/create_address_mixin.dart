
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/district_model.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';
import 'package:mc_queen_cargo/features/Model/province_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/AddAddress/create_address_page.dart';

mixin CreateAddressMixin on State<CreateAddressPage> {
  PartnerController partnerController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> neighbourhoodKey = GlobalKey<FormFieldState>();
  String incoming = Get.arguments;
  RxBool visibilty = false.obs;
  RxInt clickButton = 0.obs;
  Services service = Services();
  List<ProvinceModel> provinceList = [];
  RxList<NeighbourhoodModel> neighbourhoodList = <NeighbourhoodModel>[].obs;
  List<DistrictModel> districtList = [];

  Future<void> saveButtonProcess() async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      formKey.currentState!.save();
      if (incoming.contains("customer")) {
        await saveCustomerAddress();
      } else {
        await saveReceiverAddress();
      }
    }
    visibilty.value = false;
  }

  Future<void> saveReceiverAddress() async {
    ReceiverAddressModel model = partnerController.receiverAddressModel.value;
    model.customerMobilId = partnerController.currentAuth.value;
    model.countryId = 1;
    var result = await service.postReceiverAddress(
        model: model, accessToken: partnerController.accessToken.value);
    if (result.contains("OK")) {
      EasyLoading.showToast("Adres başarıyla kaydedildi");
      Get.back(result: result);
    }
  }

  Future<void> saveCustomerAddress() async {
    AddressModel model = partnerController.customerAddressModel.value;
    model.customerMobilId = partnerController.currentAuth.value;
    model.countryId = 1;
    var result = await service.postCustomerAddress(
        model: model,
        customerId: partnerController.currentAuth.value,
        accessToken: partnerController.accessToken.value);
    if (result.contains("OK")) {
      EasyLoading.showToast("Adres başarıyla kaydedildi");
      Get.back(result: result);
    }
  }
}
