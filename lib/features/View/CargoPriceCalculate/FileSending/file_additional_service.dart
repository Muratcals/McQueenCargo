import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FileAdditionalService extends StatefulWidget {
  const FileAdditionalService(
      {super.key,
      required this.selectedProcurement,
      required this.selecteddelivery});

  final Function(double procurementPrice) selectedProcurement;
  final Function(double deliveryPrice) selecteddelivery;

  @override
  State<FileAdditionalService> createState() => _FileAdditionalServiceState();
}

class _FileAdditionalServiceState extends State<FileAdditionalService> {
  PartnerController controller = Get.find();
  int selectedProcurement = 0;
  int selectedDelivery = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          GeneralTextWidget(title: "Alım Hizmetleri", fontsize: 16.sp),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0;
                    i < controller.fileProcurementServices.length;
                    i++)
                  procurementServiceRowItems(
                      controller.fileProcurementServices[i], i)
              ],
            ),
          ),
          SizedBox(height: 5.h),
          GeneralTextWidget(title: "Teslimat Hizmetleri", fontsize: 16.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            child: Row(
              children: [
                for (int i = 0; i < controller.fileDeliveryServices.length; i++)
                  deliveryServiceRowItems(controller.fileDeliveryServices[i], i)
              ],
            ),
          ),
        ],
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

  InkWell procurementSelectedButtonController(int index) {
    return InkWell(
      onTap: () {
        double procurementPrice =
            controller.fileProcurementServices[index].price -
                controller.fileProcurementServices[selectedProcurement].price;
        widget.selectedProcurement(procurementPrice);
        setState(() {
          selectedProcurement = index;
        });
      },
      child: Container(
        color: selectedProcurement != index ? Colors.white : Colors.green,
        padding: EdgeInsets.symmetric(vertical: 3.h),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: selectedProcurement != index ? "+" : "✓",
            fontsize: 14.sp,
            color: selectedProcurement != index ? Colors.black : Colors.white),
      ),
    );
  }

  InkWell deliverySelectedButtonController(int index) {
    return InkWell(
      onTap: () {
        double deliveryPrice = controller.fileDeliveryServices[index].price -
            controller.fileDeliveryServices[selectedDelivery].price;
        widget.selecteddelivery(deliveryPrice);
        setState(() {
          selectedDelivery = index;
        });
      },
      child: Container(
        color: selectedDelivery != index ? Colors.white : Colors.green,
        padding: EdgeInsets.symmetric(vertical: 3.h),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: selectedDelivery != index ? "+" : "✓",
            fontsize: 14.sp,
            color: selectedDelivery != index ? Colors.black : Colors.white),
      ),
    );
  }
}