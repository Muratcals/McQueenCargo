import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProcumentService extends StatefulWidget {
  const ProcumentService({
    super.key,
    required this.onPressed,
    required this.type,
  });
  final Function(double updatePrice, int index) onPressed;
  final String type;

  @override
  State<ProcumentService> createState() => _ProcumentServiceState();
}

class _ProcumentServiceState extends State<ProcumentService> {
  PartnerController controller = Get.find();
  int selectedProcurement = 0;
  int selectedDelivery = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < controller.packageProcurementServices.length; i++)
            widget.type.contains("KOLİ - PAKET")
                ? procurementServiceRowItems(
                    controller.packageDeliveryServices[i], i)
                : deliveryServiceRowItems(controller.fileDeliveryServices[i], i)
        ],
      ),
    );
  }

  Column procurementServicesWidget(AdditionalServiceModel model, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                model.icon,
                color: Colors.orange,
                size: 25.r,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralTextWidget(
                    title: model.name, fontsize: 13.sp, color: Colors.grey),
                GeneralTextWidget(
                    title: model.price.toString(),
                    fontsize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)
              ],
            )
          ],
        ),
        SizedBox(height: 3.h),
        Divider(color: Colors.grey, height: 1.h),
        procurementSelectedButtonController(index),
      ],
    );
  }

  InkWell procurementSelectedButtonController(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          var price = controller.packageProcurementServices[index].price -
              controller.packageProcurementServices[selectedProcurement].price;
          selectedProcurement = index;
          widget.onPressed(price, index);
        });
      },
      child: Container(
        color: selectedProcurement != index ? Colors.white : Colors.green,
        padding: CustomPadding.onlyVerticalInset(3),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: selectedProcurement != index ? "+" : "✓",
            fontsize: 14.sp,
            color: selectedProcurement != index ? Colors.black : Colors.white),
      ),
    );
  }

  Container procurementServiceRowItems(
      AdditionalServiceModel model, int index) {
    return Container(
      width: (Get.width / 2) - 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.white),
      margin: CustomPadding.only(top: 5, bottom: 5, right: 15),
      padding: CustomPadding.only(top: 5),
      child: procurementServicesWidget(model, index),
    );
  }

  InkWell deliverySelectedButtonController(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          double deliveryPrice = controller.fileDeliveryServices[index].price -
              controller.fileDeliveryServices[selectedDelivery].price;
          widget.onPressed(deliveryPrice, index);
          selectedDelivery = index;
        });
      },
      child: Container(
        color: selectedDelivery != index ? Colors.white : Colors.green,
        padding: CustomPadding.onlyVerticalInset(3),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: selectedDelivery != index ? "+" : "✓",
            fontsize: 14.sp,
            color: selectedDelivery != index ? Colors.black : Colors.white),
      ),
    );
  }

  Column deliveryServicesWidget(AdditionalServiceModel model, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                model.icon,
                color: Colors.orange,
                size: 25.r,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralTextWidget(
                    title: model.name, fontsize: 13.sp, color: Colors.grey),
                GeneralTextWidget(
                    title: model.price.toString(),
                    fontsize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)
              ],
            )
          ],
        ),
        SizedBox(height: 3.h),
        Divider(color: Colors.grey, height: 1.h),
        deliverySelectedButtonController(index),
      ],
    );
  }

  Container deliveryServiceRowItems(AdditionalServiceModel model, int index) {
    return Container(
      width: (Get.width / 2) - 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.white),
      margin: CustomPadding.only(top: 5, bottom: 5, right: 15),
      padding: CustomPadding.only(top: 5),
      child: deliveryServicesWidget(model, index),
    );
  }
}
