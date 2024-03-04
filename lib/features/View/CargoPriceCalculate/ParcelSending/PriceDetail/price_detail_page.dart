import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/FileSending/file_additional_service.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/PriceDetail/package_additional_services_widget.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/PriceDetail/price_detail_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PriceDetailPage extends StatefulWidget {
  const PriceDetailPage({super.key});

  @override
  State<PriceDetailPage> createState() => _PriceDetailPageState();
}

class _PriceDetailPageState extends State<PriceDetailPage>
    with PriceDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar(title, model, incoming),
      body: Container(
        margin: CustomPadding.allInset(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: Colors.white),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              columnItemsAppBar(),
              addiitonalServiceWidget(),
              SizedBox(height: 10.h),
              finishButton()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox finishButton() {
    return SizedBox(
        width: Get.width / 1.5,
        child: AtomicOrangeButton(
            onPressed: () async {
              Get.until((route) => Get.currentRoute == "/main");
              // Get.offAllNamed("/main", arguments: {"userId": 0});
            },
            title: "Bitir"));
  }

  Widget addiitonalServiceWidget() {
    if (incoming.contains("KOLİ - PAKET")) {
      return PackageAdditionalServices(
        selectedProcurement: (procurementPrice) {
          setState(() {
            updateProcurementPrice(procurementPrice);
          });
        },
        selecteddelivery: (deliveryPrice) {
          setState(() {
            updateDeliveryPrice(deliveryPrice);
          });
        },
      );
    } else {
      return FileAdditionalService(
        selectedProcurement: (procurementPrice) {
          setState(() {
            updateProcurementPrice(procurementPrice);
          });
        },
        selecteddelivery: (deliveryPrice) {
          setState(() {
            updateDeliveryPrice(deliveryPrice);
          });
        },
      );
    }
  }

  Container columnItemsAppBar() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo.shade200,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
      padding: CustomPadding.allInset(15),
      child: GeneralTextWidget(
        title: "TAMAMLAYICI / EK HİZMETLER",
        fontsize: 14.sp,
        color: Colors.white,
      ),
    );
  }
}
