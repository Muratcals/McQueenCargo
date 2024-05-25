import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Model/price_detail_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class PriceDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PriceDetailAppBar(
      {super.key,
      required this.model,
      required this.incoming,
      required this.title});
  final PriceDetailModel model;
  final String incoming;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title:
          GeneralTextWidget(title: title, fontsize: 14.sp, color: Colors.white),
      flexibleSpace: const AppbarFlexibleSpace(),
      leading: const AppBarIcon(),
      toolbarHeight: 30.h,
      bottom: _AppBarBottomItems(model: model, incoming: incoming),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(((Get.height * 38) / 100) + 30.h);
}

class _AppBarBottomItems extends StatelessWidget
    implements PreferredSizeWidget {
  const _AppBarBottomItems({required this.model, required this.incoming});
  final PriceDetailModel model;
  final String incoming;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: GeneralTextWidget(
                  title: "${incoming.toUpperCase()} / STANDART",
                  fontsize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
            Divider(height: 1.h, color: Colors.grey),
            SizedBox(height: 10.h),
            RowItems(
                title: "Standart Taşıma Bedeli",
                subTitle: model.transportPrice),
            SizedBox(height: 5.h),
            RowItems(
                title: "Ek hizmetler Toplam",
                subTitle: model.additionalServicePrice),
            SizedBox(height: 5.h),
            RowItems(
                title: "Toplam",
                subTitle: model.transportPrice + model.additionalServicePrice),
            SizedBox(height: 5.h),
            RowItems(title: "KDV", subTitle: model.kdv),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralTextWidget(
                    title: "Genel Toplam",
                    fontsize: 16.sp,
                    color: Colors.green),
                GeneralTextWidget(
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
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, (Get.height * 38) / 100);
}

class RowItems extends StatelessWidget {
  const RowItems({super.key, required this.title, required this.subTitle});
  final String title;
  final double subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GeneralTextWidget(title: title, fontsize: 14.sp, color: Colors.grey),
        GeneralTextWidget(
            title: "${subTitle.toStringAsFixed(2)} TL",
            fontsize: 14.sp,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
