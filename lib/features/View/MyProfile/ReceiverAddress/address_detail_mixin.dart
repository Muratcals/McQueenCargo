import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/ReceiverAddress/address_detail_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/ReceiverAddress/address_detail_widgets.dart';

mixin ReceiverAddressInformationMixin on State<ReceiverAddressInformationPage> {
  int addressId = Get.arguments["addressId"];
  Services service = Services();
  PartnerController controller = Get.find();
  AddressInformationWidgets widgets = AddressInformationWidgets();

  Future<ReceiverAddressModel> getAddress() async {
    return service.getReceiverAddress(
        addressId: addressId, accessToken: controller.accessToken.value);
  }

  Future<String> deleteAddress() async {
    return service.deleteReceiverAddress(
        addressId: addressId, accessToken: controller.accessToken.value);
  }
}
