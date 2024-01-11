import 'package:mc_queen_cargo/features/Model/price_detail_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PriceDetailWidget {
  AppBar appBar(String title, PriceDetailModel model, String incoming) {
    return AppBar(
      centerTitle: true,
      title: textWidget(title: title, fontsize: 14.sp, color: Colors.white),
      flexibleSpace: appbarFlexibleSpace(),
      leading: appBarIcon(),
      toolbarHeight: 30.h,
      actions: [
        InkWell(
          onTap: () {
            Get.offAllNamed("/main", arguments: {"userId": 0});
          },
          child: Container(
              alignment: Alignment.center,
              margin: CustomPadding.only(right: 10),
              child: textWidget(
                  title: "İptal", fontsize: 14.sp, color: Colors.white)),
        )
      ],
      bottom: appBarBottomItems(model, incoming),
    );
  }

  PreferredSize appBarBottomItems(PriceDetailModel model, String incoming) {
    return PreferredSize(
      preferredSize: Size(double.infinity, (Get.height * 38) / 100),
      child: Container(
        width: double.infinity,
        height: (Get.height * 33) / 100,
        margin: CustomPadding.allInset(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r), color: Colors.white),
        child: Container(
          padding: CustomPadding.onlyHorizontalInset(10),
          child: Column(
            children: [
              Container(
                padding: CustomPadding.allInset(15),
                child: textWidget(
                    title: "${incoming.toUpperCase()} / STANDART",
                    fontsize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              Divider(height: 1.h, color: Colors.grey),
              SizedBox(height: 10.h),
              rowItems(
                  title: "Standart Taşıma Bedeli",
                  subTitle: model.transportPrice),
              SizedBox(height: 5.h),
              rowItems(
                  title: "Ek hizmetler Toplam",
                  subTitle: model.additionalServicePrice),
              SizedBox(height: 5.h),
              rowItems(
                  title: "Toplam",
                  subTitle:
                      model.transportPrice + model.additionalServicePrice),
              SizedBox(height: 5.h),
              rowItems(title: "KDV", subTitle: model.kdv),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                      title: "Genel Toplam",
                      fontsize: 16.sp,
                      color: Colors.green),
                  textWidget(
                      title:
                          "${(model.additionalServicePrice + model.kdv + model.transportPrice).toStringAsFixed(2)} TL",
                      fontsize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row rowItems({required String title, required double subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(title: title, fontsize: 14.sp, color: Colors.grey),
        textWidget(
            title: "${subTitle.toStringAsFixed(2)} TL",
                      fontsize: 14.sp,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
