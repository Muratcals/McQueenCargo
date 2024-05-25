import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

class GetCourierController extends GetxController {
  RxBool selectedAddress = false.obs;
  RxInt selectedDate = 0.obs;
  final customerAddresssModel = Rx<AddressModel?>(null);
  final receiverAddressModel = Rx<ReceiverAddressModel?>(null);
  PartnerController partnerController = Get.find();
}
