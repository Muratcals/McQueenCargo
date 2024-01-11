import 'package:mc_queen_cargo/features/CargoPriceCalculate/ParcelSending/package_sending_widgets.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Model/package_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

mixin PackageSendingMixin on State<PackageSendingPageWidgets> {
  int smallQuantity = 0;
  int mediumQuantity = 0;
  int largeQuantity = 0;
  int xLargeQuantity = 0;
  List<CargoParcelTypeModel> packages = [];
  String? incoming;
  PartnerController controller = Get.find();

  @override
  void initState() {
    incoming = widget.incoming;
    super.initState();
  }

  deleteQuantity(String cargoParcelTypeName) {
    if (cargoParcelTypeName.contains("Small")) {
      if (smallQuantity != 0) {
        smallQuantity = smallQuantity - 1;
      }
    } else if (cargoParcelTypeName.contains("Medium")) {
      if (mediumQuantity != 0) {
        mediumQuantity = mediumQuantity - 1;
      }
    } else if (cargoParcelTypeName.contains("X-Large")) {
      if (xLargeQuantity != 0) {
        xLargeQuantity = xLargeQuantity - 1;
      }
    } else {
      if (largeQuantity != 0) {
        largeQuantity = largeQuantity - 1;
      }
    }
    setState(() {});
  }

  addQuantity(String cargoParcelTypeName) {
    if (cargoParcelTypeName.contains("Small")) {
      smallQuantity += 1;
    } else if (cargoParcelTypeName.contains("Medium")) {
      mediumQuantity += 1;
    } else if (cargoParcelTypeName.contains("X-Large")) {
      xLargeQuantity += 1;
    } else {
      largeQuantity += 1;
    }
    setState(() {});
  }

  Future<void> buttonProcess() async {
    if (smallQuantity == 0 &&
        mediumQuantity == 0 &&
        largeQuantity == 0 &&
        xLargeQuantity == 0) {
      EasyLoading.showToast("En az bir kutu seçimi yapınız.");
    } else {
      if (incoming!.contains("calculate")) {
        await Get.toNamed("priceInformation", arguments: {
          "price": sumPrice(),
          "incoming": "KOLİ - PAKET",
          "weight": packageWeight()
        });
      } else {
        await Get.toNamed("getCourierShipmentType", arguments: {
          "price": sumPrice() - (sumPrice() * 25) / 100,
          "type": "KOLİ - PAKET",
          "weight": packageWeight()
        });
      }
      resetAdditionalService();
    }
  }

  void resetAdditionalService() {
     controller.packageProcurementServices.clear();
    controller.packageProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);
    controller.packageDeliveryServices.clear();
    controller.packageDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);
  }

  double sumPrice() {
    double smallPackagesPrice = widget.model
            .lastWhere(
                (element) => element.cargoParcelTypeName!.contains("Small"))
            .price! *
        smallQuantity;
    double mediumPackagesPrice = widget.model
            .lastWhere(
                (element) => element.cargoParcelTypeName!.contains("Medium"))
            .price! *
        mediumQuantity;
    double largePackagesPrice = widget.model
            .lastWhere(
                (element) => element.cargoParcelTypeName!.contains("Large"))
            .price! *
        largeQuantity;
    double xlargePackagesPrice = widget.model
            .lastWhere(
                (element) => element.cargoParcelTypeName!.contains("X-Large"))
            .price! *
        xLargeQuantity;
    return smallPackagesPrice +
        mediumPackagesPrice +
        largePackagesPrice +
        xlargePackagesPrice.toDouble();
  }

  double packageWeight() {
    int smallPackagesWeight = 10 * smallQuantity;
    int mediumPackagesWeight = 15 * mediumQuantity;
    int largePackagesWeight = 20 * largeQuantity;
    int xlargePackagesWeight = 25 * xLargeQuantity;
    return smallPackagesWeight +
        mediumPackagesWeight +
        largePackagesWeight +
        xlargePackagesWeight.toDouble();
  }
}
