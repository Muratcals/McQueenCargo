import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/post_courier_model.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:get/get.dart';

class PartnerController extends GetxController {
  final RxString selectedBottomSheet = "main".obs;

  final customerModel = LoginModel();
  
  final userInformation = LoginModel().obs;

  final getCourierModel = PostCourierModel().obs;

  final customerAddressModel = AddressModel(countryId: 1).obs;

  final receiverAddressModel = ReceiverAddressModel(countryId: 1).obs;

  final packageProcurementServices = [
    AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
  ];

  final packageDeliveryServices = [
    AdditionalServiceModel(name: "Adrese Teslimat", price: 24.46),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
  ];

  final fileProcurementServices = [
    AdditionalServiceModel(name: "Adresten Alım", price: 13.55),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
  ];

  final fileDeliveryServices = [
    AdditionalServiceModel(name: "Adrese Teslimat", price: 13.48),
    AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
  ];
}
