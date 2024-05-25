import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

class CalculatePriceController extends GetxController {
  final customerAddressModel = Rx<AddressModel?>(null);
  final recevierAddressModel = Rx<ReceiverAddressModel?>(null);
}
