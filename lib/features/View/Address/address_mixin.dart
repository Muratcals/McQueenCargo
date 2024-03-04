import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Address/address_page.dart';



mixin AddressMixin on State<AddressPage> {
  String incoming = Get.arguments["incoming"];
  String process = Get.arguments["process"];
  RxString searchableString = "".obs;
  Services service = Services();
  PartnerController controller = Get.find();
  RxList<AddressModel> inializeList = <AddressModel>[].obs;
  List<AddressModel> customerAddressList = [];
  List<ReceiverAddressModel> receiverAddressList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<AddressModel>> getCustomerAddress(
      {required int customerId}) async {
    return service.getAllCustomerAddress(
        customerId: customerId, accessToken: controller.accessToken.value);
  }

  Future<List<ReceiverAddressModel>> getReceiverAddress(
      {required int customerId}) async {
    return service.getAllReceiverAddress(
        customerId: customerId, accessToken: controller.accessToken.value);
  }

  List<dynamic> filter(String query) {
    if (incoming.contains("customer")) {
      return customerAddressList
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      return receiverAddressList
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
