import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/Address/address_page.dart';

mixin AddressMixin on State<AddressPage> {
  late String incoming;
  late String process;
  Services service = Services();
  List<AddressModel> customerAddressList = [];
  List<ReceiverAddressModel> receiverAddressList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments =Get.arguments;
    incoming = arguments["incoming"];
    process = arguments["process"];
  }

  Future<List<AddressModel>> getCustomerAddress(
      {required int customerId}) async {
    return service.getAllCustomerAddress(customerId: customerId);
  }

  Future<List<ReceiverAddressModel>> getReceiverAddress(
      {required int customerId}) async {
    return service.getAllReceiverAddress(customerId: customerId);
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
