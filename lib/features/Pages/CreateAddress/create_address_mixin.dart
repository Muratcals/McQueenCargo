import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/Controller/create_address_cubit/create_address_cubit.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/View/create_address_page.dart';

mixin CreateAddressMixin on State<CreateAddressPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> neighbourhoodKey = GlobalKey<FormFieldState>();
  late String incoming;
  RxBool visibilty = false.obs;
  RxInt clickButton = 0.obs;
  Services service = Services();

  @override
  void initState() {
    incoming = Get.arguments;
    super.initState();
  }

  Future<void> saveButtonProcess(BuildContext context) async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      formKey.currentState!.save();
      if (incoming.contains("customer")) {
        await saveCustomerAddress(context);
      } else {
        await saveReceiverAddress(context);
      }
    }
    visibilty.value = false;
  }

  Future<void> saveReceiverAddress(BuildContext context) async {
    ReceiverAddressModel model =
        context.read<CreateAddressCubit>().state.receiverAddress;
    model.customerMobilId = Auth.authId;
    model.countryId = 1;
    var result = await service.postReceiverAddress(model: model);
    if (result.contains("OK")) {
      EasyLoading.showToast("Adres başarıyla kaydedildi");
      Get.back(result: result);
    }
    visibilty.value = false;
  }

  Future<void> saveCustomerAddress(BuildContext context) async {
    AddressModel model = context.read<CreateAddressCubit>().state.customerAddress;
    model.customerMobilId = Auth.authId;
    model.countryId = 1;
    var result = await service.postCustomerAddress(model: model);
    if (result.contains("OK")) {
      EasyLoading.showToast("Adres başarıyla kaydedildi");
      Get.back(result: result);
    }
  }
}
