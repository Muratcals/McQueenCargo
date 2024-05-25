import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/FileSending/file_additional_service.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceDetail/package_additional_services_widget.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceDetail/View/price_detail_appbar.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceDetail/price_detail_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
part 'price_detail_widget.dart';

class PriceDetailPage extends StatefulWidget {
  const PriceDetailPage({super.key});

  @override
  State<PriceDetailPage> createState() => _PriceDetailPageState();
}

class _PriceDetailPageState extends State<PriceDetailPage>
    with PriceDetailMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            PriceDetailAppBar(title: title, model: model, incoming: incoming),
        body: Container(
          margin: CustomPadding.allInset(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: Colors.white),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const _ColumnItemsAppBar(),
                additonalServiceWidget(),
                SizedBox(height: 10.h),
                const _FinishButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget additonalServiceWidget() {
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
}
