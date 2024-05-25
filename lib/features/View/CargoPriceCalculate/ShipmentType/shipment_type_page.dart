import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part  '../ShipmentType/shipment_type_widget.dart';

class ShipmentTypePage extends StatefulWidget {
  const ShipmentTypePage({super.key});

  @override
  State<ShipmentTypePage> createState() => _ShipmentTypePageState();
}

class _ShipmentTypePageState extends State<ShipmentTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        actions: [_CancelButton()],
        toolbarHeight: 28.h,
        title: GeneralTextWidget(
            title: "Gönderi Türü", fontsize: 13.sp, color: Colors.white),
        flexibleSpace: const AppbarFlexibleSpace(),
        leading: AppBarIcon(),
        centerTitle: true,
      ),
      body: Container(
        margin: CustomPadding.only(top: 35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _FileOrDocumentsWidget(),
              SizedBox(height: 15.h),
              _ParcelOrPackageWidget()
            ],
          ),
        ),
      ),
    );
  }
}
