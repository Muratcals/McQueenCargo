import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/MyProfile/CustomerAddress/address_detail_page.dart';
import 'package:mc_queen_cargo/features/MyProfile/CustomerAddress/address_detail_widgets.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin CustomerAddressInformationMixin
    on State<CustomerAddresssInformationPage> {
  CustomerAddressWidget widgets = CustomerAddressWidget();
  int addressId = Get.arguments["addressId"];
  PartnerController controller = Get.find();
  Services service = Services();

  Future<AddressModel> getCustomerAddress() async {
    return await service.getCustomerAddress(
        addressId: addressId, accessToken: controller.accessToken.value);
  }

  Future<String> deleteAddress() async {
    return service.deleteCustomerAddress(
        addressId: addressId, accessToken: controller.accessToken.value);
  }
}
