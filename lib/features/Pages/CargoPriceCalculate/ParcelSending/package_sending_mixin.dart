import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Model/package_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/package_sending_widgets.dart';

mixin PackageSendingMixin on State<PackageSendingPageWidgets> {
  int smallQuantity = 0;
  int mediumQuantity = 0;
  int largeQuantity = 0;
  int xLargeQuantity = 0;
  List<CargoParcelTypeModel> packages = [];
  String? incoming;

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
    } else if (cargoParcelTypeName == "Large") {
      if (largeQuantity != 0) {
        largeQuantity = largeQuantity - 1;
      }
    } else {
      if (xLargeQuantity != 0) {
        xLargeQuantity = xLargeQuantity - 1;
      }
    }
    setState(() {});
  }

  addQuantity(String cargoParcelTypeName) {
    if (cargoParcelTypeName.contains("Small")) {
      smallQuantity += 1;
    } else if (cargoParcelTypeName.contains("Medium")) {
      mediumQuantity += 1;
    } else if (cargoParcelTypeName == "Large") {
      largeQuantity += 1;
    } else {
      xLargeQuantity += 1;
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
        await Get.toNamed(GenerateRoute.priceInformation, arguments: {
          "price": sumPrice(),
          "incoming": "KOLİ - PAKET",
          "weight": packageWeight()
        });
      } else {
        await Get.toNamed(GenerateRoute.selectedPostType, arguments: {
          "price": sumPrice() - (sumPrice() * 25) / 100,
          "type": "KOLİ - PAKET",
          "weight": packageWeight()
        });
      }
      resetAdditionalService();
    }
  }

  void resetAdditionalService() {
    AdditionalServicePrice.packageProcurementServices.clear();
    AdditionalServicePrice.packageProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);
    AdditionalServicePrice.packageDeliveryServices.clear();
    AdditionalServicePrice.packageDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);
  }

  double sumPrice() {
    double smallPackagesPrice = widget.model
            .lastWhere((element) => element.cargoParcelTypeName! == "Small")
            .price! *
        smallQuantity;
    double mediumPackagesPrice = widget.model
            .lastWhere((element) => element.cargoParcelTypeName! == "Medium")
            .price! *
        mediumQuantity;
    double largePackagesPrice = widget.model
            .lastWhere((element) => element.cargoParcelTypeName! == "Large")
            .price! *
        largeQuantity;
    double xlargePackagesPrice = widget.model
            .lastWhere((element) => element.cargoParcelTypeName! == "X-Large")
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
