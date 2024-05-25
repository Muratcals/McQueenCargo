import 'package:mc_queen_cargo/features/Model/price_detail_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceInformation/price_information_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PriceInformationPage extends StatefulWidget {
  const PriceInformationPage({super.key});

  @override
  State<PriceInformationPage> createState() => _PriceInformationPageState();
}

class _PriceInformationPageState extends State<PriceInformationPage>
    with PriceInformationMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: appBar(),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
          margin: CustomPadding.symmetricInset(10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              closePageButton(),
              Divider(color: Colors.grey, height: 1.h),
              SizedBox(height: 5.h),
              priceInformationPage(),
              SizedBox(height: 5.h)
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 30.h,
      leading: const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      title: GeneralTextWidget(
          title: "Fiyat Bilgisi", fontsize: 14.sp, color: Colors.white),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () {
            resetAdditionalService();
            // Get.offAllNamed("/main", arguments: {"userId": 0});
            Get.until((route) => Get.currentRoute == "/main");
          },
          child: Container(
              alignment: Alignment.center,
              margin: CustomPadding.only(right: 10),
              child: GeneralTextWidget(
                  title: "İptal", fontsize: 14.sp, color: Colors.white)),
        )
      ],
    );
  }

  InkWell closePageButton() {
    return InkWell(
      onTap: () {
        PriceDetailModel priceDetail = PriceDetailModel(
            transportPrice: discountPackagePrice,
            additionalServicePrice: additionalServicePrice,
            kdv: kdv);
        Get.toNamed("/priceDetail",
            arguments: {"model": priceDetail, "incoming": incoming});
      },
      child: titleWidget(),
    );
  }

  ListTile titleWidget() {
    return ListTile(
      title: GeneralTextWidget(
          title: "${incoming.toUpperCase()} / STANDART",
          fontsize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      subtitle: GeneralTextWidget(
          title: "Tüm Türkiye geneli standart hizmettir.",
          fontsize: 13.sp,
          color: Colors.grey),
      trailing: InkWell(
        onTap: () {},
        child: const Icon(Icons.chevron_right),
      ),
    );
  }

  Container priceInformationPage() {
    return Container(
      padding: CustomPadding.allInset(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 5.h),
          columnItems(
              title: "Liste Fiyatı",
              subTitle: "₺${notDiscountPrice.toStringAsFixed(2).toString()}"),
          columnItems(
              title: "Kampanyalı Fiyat",
              subTitle: "₺${taxSumPrice.toStringAsFixed(2).toString()}"),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }

  Column columnItems({required String title, required String subTitle}) {
    return Column(
      children: [
        GeneralTextWidget(title: title, fontsize: 16.sp, color: Colors.black),
        SizedBox(height: 5.h),
        Text(
          subTitle,
          style: TextStyle(
              color: title.contains("Liste") ? Colors.grey : Colors.green,
              fontSize: 17.sp,
              decoration: title.contains("Liste")
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        )
      ],
    );
  }
}
