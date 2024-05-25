import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceInformation/price_information_page.dart';

mixin PriceInformationMixin on State<PriceInformationPage> {
  double packagesPrice = Get.arguments["price"];
  double packagesWeight = Get.arguments["weight"];
  String incoming = Get.arguments["incoming"];
  double discountPackagePrice = 0;
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
    AdditionalServicePrice.packageDeliveryServices[0].price =
        AdditionalServicePrice.packageDeliveryServices[0].price * count;
    AdditionalServicePrice.packageDeliveryServices[1].price =
        AdditionalServicePrice.packageDeliveryServices[1].price * count;
    AdditionalServicePrice.packageProcurementServices[0].price =
        AdditionalServicePrice.packageProcurementServices[0].price * count;
    AdditionalServicePrice.packageProcurementServices[1].price =
        AdditionalServicePrice.packageProcurementServices[1].price * count;
    additionalServicePrice = AdditionalServicePrice.packageProcurementServices[0].price +
        AdditionalServicePrice.packageDeliveryServices[0].price;
  }

  void packagePriceCalculate() {
    discountPackagePrice = packagesPrice - ((packagesPrice * 25) / 100);
    if (packagesWeight <= 45) {
      updatePrice(1);
    } else if (packagesWeight > 45 && packagesWeight <= 100) {
      updatePrice(2);
    } else {
      updatePrice(3);
    }
    additionalServicePrice = AdditionalServicePrice.packageDeliveryServices[0].price +
        AdditionalServicePrice.packageProcurementServices[0].price;
    sumPrice = discountPackagePrice + additionalServicePrice;
    kdv = (sumPrice * 20) / 100;
    taxSumPrice = sumPrice + kdv;
    notDiscountPrice = packagesPrice + kdv + additionalServicePrice;
  }

  void filePriceCalculate() {
    discountPackagePrice = packagesPrice - ((packagesPrice * 25) / 100);
    additionalServicePrice = AdditionalServicePrice.fileDeliveryServices[0].price +
        AdditionalServicePrice.fileProcurementServices[0].price;
    sumPrice = discountPackagePrice + additionalServicePrice;
    kdv = (sumPrice * 20) / 100;
    taxSumPrice = sumPrice + kdv;
    notDiscountPrice = packagesPrice + kdv + additionalServicePrice;
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
}
