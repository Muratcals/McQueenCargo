import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

mixin ShipmentTypeWidgets {
  PartnerController controller = Get.find();
  InkWell cancelButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 10.w),
          child: textWidget(
              title: "İptal Et", fontsize: 13.sp, color: Colors.white)),
    );
  }

  Container fileOrDocumentsWidget() {
    return Container(
      color: Colors.white,
      width: 170.w,
      height: 110.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.contain,
            "images/file_icon.png",
            width: 80.w,
            height: 80.h,
          ),
          const Divider(color: Colors.grey, height: 0.5),
          Container(
            padding: EdgeInsets.all(5.r),
            child: InkWell(
              onTap: () {
                Get.toNamed("/priceInformation", arguments: {
                  "incoming": "DOSYA - EVRAK",
                  "price": 43.58,
                  "weight": 0.0
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: textWidget(title: "Dosya-Evrak", fontsize: 14.sp)),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container parcelOrPackageWidget() {
    return Container(
      color: Colors.white,
      width: 170.w,
      height: 110.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.contain,
            "images/parcel_icon.png",
            width: 80.w,
            height: 80.h,
          ),
          const Divider(color: Colors.grey, height: 0.5),
          Container(
            padding: EdgeInsets.all(5.r),
            child: InkWell(
              onTap: () {
                Get.toNamed("/parcelSending",
                    arguments: {"incoming": "calculate"});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: textWidget(title: "Koli-Paket", fontsize: 14.sp)),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
