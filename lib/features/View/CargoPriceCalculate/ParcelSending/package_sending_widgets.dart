import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Model/package_information.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/package_sending_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PackageSendingPageWidgets extends StatefulWidget {
  const PackageSendingPageWidgets(
      {super.key, required this.model, required this.incoming});
  final List<CargoParcelTypeModel> model;
  final String incoming;

  @override
  State<PackageSendingPageWidgets> createState() =>
      _PackageSendingPageWidgetsState();
}

class _PackageSendingPageWidgetsState extends State<PackageSendingPageWidgets>
    with PackageSendingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              margin: CustomPadding.symmetricInset(15, 10),
              child: Column(
                children: [
                  Text(
                    "Gönderi yapmak istediğiniz paket ebatını ve adetini belirleyiniz",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Seçiminize gre tahmini gönderi bedeli üst sınırdan hesaplanaccak, gerçek fiyat ise şubeden kargonuzu ölçüm tartım işlemleri gerçekleştirildikten sonra belirlenecektir",
                    style: TextStyle(fontSize: 12.sp, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  packageInformationWidget(
                      networkIcon: "https://ozerhamza.com.tr/img/s.png",
                      parcelSize: "Small"),
                  const Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  packageInformationWidget(
                      networkIcon: "https://ozerhamza.com.tr/img/m.png",
                      parcelSize: "Medium"),
                  const Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  packageInformationWidget(
                      networkIcon: "https://ozerhamza.com.tr/img/l.png",
                      parcelSize: "Large"),
                  const Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  packageInformationWidget(
                      networkIcon: "https://ozerhamza.com.tr/img/xl.png",
                      parcelSize: "X-Large"),
                  SizedBox(height: 15.h),
                  AtomicOrangeButton(
                      onPressed: () {
                        buttonProcess();
                      },
                      title: "Devam Et")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget packageInformationWidget(
      {required String networkIcon, required String parcelSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: CustomPadding.symmetricInset(15, 10),
              child: Column(
                children: [
                  GeneralTextWidget(
                      title: parcelSize == "X-Large"
                          ? "XL"
                          : parcelSize.substring(0, 1),
                      fontsize: 20.sp,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 5.w),
                  InkWell(
                    onTap: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return PackageSendingDialog(
                              model: widget.model.lastWhere((element) =>
                                  element.cargoParcelTypeName! == parcelSize),
                              icon: networkIcon);
                        },
                      );
                    },
                    child: Icon(
                      Icons.info,
                      size: 20.r,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Image.network(
              networkIcon,
              width: 80.w,
              height: 80.h,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            SizedBox(width: 5.w),
          ],
        ),
        packageQuantity(
            widget.model.lastWhere(
                (element) => element.cargoParcelTypeName == parcelSize),
            widget.model
                        .lastWhere((element) =>
                            element.cargoParcelTypeName == parcelSize)
                        .cargoParcelTypeName ==
                    "Small"
                ? smallQuantity
                : widget.model
                            .lastWhere((element) =>
                                element.cargoParcelTypeName == parcelSize)
                            .cargoParcelTypeName ==
                        "Medium"
                    ? mediumQuantity
                    : widget.model
                                .lastWhere((element) =>
                                    element.cargoParcelTypeName == parcelSize)
                                .cargoParcelTypeName ==
                            "Large"
                        ? largeQuantity
                        : xLargeQuantity)
      ],
    );
  }

  Widget packageQuantity(CargoParcelTypeModel model, int quantity) {
    return Row(
      children: [
        IconButton(
          color: Colors.grey,
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
          onPressed: () {
            deleteQuantity(model.cargoParcelTypeName!);
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GeneralTextWidget(
                title: quantity.toString(),
                fontsize: 12.sp,
                color: Colors.black),
            GeneralTextWidget(title: "Adet", fontsize: 12.sp)
          ],
        ),
        IconButton(
          color: Colors.blue,
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            addQuantity(model.cargoParcelTypeName!);
          },
        ),
      ],
    );
  }
}

class PackageSendingDialog extends StatelessWidget {
  const PackageSendingDialog({required this.model, required this.icon});

  final CargoParcelTypeModel model;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
          horizontal: (Get.width * 10) / 100,
          vertical: (Get.height * 17) / 100),
      padding: CustomPadding.allInset(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: CustomPadding.only(top: 10),
            child: Image.network(
              icon,
              height: 80.h,
              width: 80.w,
              fit: model.cargoParcelTypeName!.contains("XL")
                  ? BoxFit.cover
                  : BoxFit.contain,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralTextWidget(
                  title: "Kutu Ölçüsü :", fontsize: 14.sp, color: Colors.grey),
              Container(
                margin: CustomPadding.only(right: 5),
                child: GeneralTextWidget(
                    title: model.cargoParcelTypeName!,
                    fontWeight: FontWeight.bold,
                    fontsize: 14.sp,
                    color: Colors.grey),
              )
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(
            height: 0.5,
            color: Colors.grey,
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GeneralTextWidget(
                  title: "En Fazla Ağırlık",
                  fontsize: 14.sp,
                  color: Colors.grey),
              Container(
                margin: CustomPadding.only(right: 5),
                child: GeneralTextWidget(
                    title: model.maxSize!,
                    fontsize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GeneralTextWidget(
                  title: "En Uzun Kenar En Fazla",
                  fontsize: 14.sp,
                  color: Colors.grey),
              Container(
                margin: CustomPadding.only(right: 5),
                child: GeneralTextWidget(
                    title: model.desiSize!,
                    fontsize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GeneralTextWidget(
                  title: "Örnek koli boyutu",
                  fontsize: 14.sp,
                  color: Colors.grey),
              Container(
                margin: CustomPadding.only(right: 5),
                child: GeneralTextWidget(
                    title: "30cm x 22cm x 22cm",
                    fontsize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            margin: CustomPadding.only(right: 5),
            child: GeneralTextWidget(
                title: model.information ?? "",
                fontsize: 14.sp,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
