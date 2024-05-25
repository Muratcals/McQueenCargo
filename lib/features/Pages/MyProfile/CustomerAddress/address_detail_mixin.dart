import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/CustomerAddress/address_detail_page.dart';

mixin CustomerAddressInformationMixin
    on State<CustomerAddresssInformationPage> {
  int addressId = Get.arguments["addressId"];
  Services service = Services();

  Future<AddressModel> getCustomerAddress() async {
    return await service.getCustomerAddress(
        addressId: addressId);
  }

  Future<String> deleteAddress() async {
    return service.deleteCustomerAddress(
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
}
