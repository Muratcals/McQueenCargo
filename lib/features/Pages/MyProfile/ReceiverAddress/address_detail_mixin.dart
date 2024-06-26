import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/ReceiverAddress/address_detail_page.dart';

mixin ReceiverAddressInformationMixin on State<ReceiverAddressInformationPage> {
  int addressId = Get.arguments["addressId"];
  Services service = Services();

  Future<ReceiverAddressModel> getAddress() async {
    return service.getReceiverAddress(
        addressId: addressId);
  }

  Future<void> onPressedButton() async {
    await deleteAddress().then((value) {
      EasyLoading.showToast(value);
      Get.back(result: 1);
    }).onError((error, stackTrace) {
      EasyLoading.showToast(error.toString());
    });
  }

  Future<String> deleteAddress() async {
    return service.deleteReceiverAddress(
        addressId: addressId);
  }
}
