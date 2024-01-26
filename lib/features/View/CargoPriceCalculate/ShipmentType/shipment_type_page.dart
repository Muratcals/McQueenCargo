import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ShipmentType/shipment_type_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShipmentTypePage extends StatefulWidget {
  const ShipmentTypePage({super.key});

  @override
  State<ShipmentTypePage> createState() => _ShipmentTypePageState();
}

class _ShipmentTypePageState extends State<ShipmentTypePage>
    with ShipmentTypeWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        actions: [cancelButton()],
        toolbarHeight: 28.h,
        title: textWidget(
            title: "Gönderi Türü", fontsize: 13.sp, color: Colors.white),
        flexibleSpace: appbarFlexibleSpace(),
        leading: appBarIcon(),
        centerTitle: true,
      ),
      body: Container(
        margin: CustomPadding.only(top: 35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              fileOrDocumentsWidget(),
              SizedBox(height: 15.h),
              parcelOrPackageWidget()
            ],
          ),
        ),
      ),
    );
  }
}
