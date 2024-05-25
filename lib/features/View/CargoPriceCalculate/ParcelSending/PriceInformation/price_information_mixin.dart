import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/PriceInformation/price_information_page.dart';

mixin PriceInformationMixin on State<PriceInformationPage> {
  double packagesPrice = Get.arguments["price"];
  double packagesWeight = Get.arguments["weight"];
  String incoming = Get.arguments["incoming"];
  double discountPackagePrice = 0;
  PartnerController controller = Get.find();
  double kdv = 0;
  double additionalServicePrice = 0;
  double taxSumPrice = 0;
  double sumPrice = 0;
  double notDiscountPrice = 0;

  @override
  void initState() {
    super.initState();
    incoming.contains("KOLİ - PAKET")
        ? packagePriceCalculate()
        : filePriceCalculate();
  }

  void updatePrice(int count) {
    discountPackagePrice = discountPackagePrice * count;
    packagesPrice = packagesPrice * count;
    controller.packageDeliveryServices[0].price =
        controller.packageDeliveryServices[0].price * count;
    controller.packageDeliveryServices[1].price =
        controller.packageDeliveryServices[1].price * count;
    controller.packageProcurementServices[0].price =
        controller.packageProcurementServices[0].price * count;
    controller.packageProcurementServices[1].price =
        controller.packageProcurementServices[1].price * count;
    additionalServicePrice = controller.packageProcurementServices[0].price +
        controller.packageDeliveryServices[0].price;
  }

  void packagePriceCalculate() {
    discountPackagePrice = packagesPrice - ((packagesPrice * 25) / 100);
    if (packagesWeight < 45) {
      updatePrice(1);
    } else if (packagesWeight > 45 && packagesWeight < 100) {
      updatePrice(2);
    } else {
      updatePrice(3);
    }
    additionalServicePrice = controller.packageDeliveryServices[0].price +
        controller.packageProcurementServices[0].price;
    sumPrice = discountPackagePrice + additionalServicePrice;
    kdv = (sumPrice * 20) / 100;
    taxSumPrice = sumPrice + kdv;
    notDiscountPrice = packagesPrice + kdv + additionalServicePrice;
  }

  void filePriceCalculate() {
    discountPackagePrice = packagesPrice - ((packagesPrice * 25) / 100);
    additionalServicePrice = controller.fileDeliveryServices[0].price +
        controller.fileProcurementServices[0].price;
    sumPrice = discountPackagePrice + additionalServicePrice;
    kdv = (sumPrice * 20) / 100;
    taxSumPrice = sumPrice + kdv;
    notDiscountPrice = packagesPrice + kdv + additionalServicePrice;
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
}
