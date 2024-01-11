import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/GetCourier/SelectedPostType/selected_post_type_mixin.dart';
import 'package:mc_queen_cargo/features/GetCourier/get_courier_information.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectedPostType extends StatefulWidget {
  const SelectedPostType({super.key});

  @override
  State<SelectedPostType> createState() => _SelectedPostTypeState();
}

class _SelectedPostTypeState extends State<SelectedPostType>
    with SelectedPostTypeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appbar(),
      body: AtomicFutureBuilder(
        future: Future.wait([
          service.getCustomerAddress(
              addressId:
                  controller.getCourierModel.value.customerMobilAdressId ?? 0,
              accessToken: controller.accessToken.value),
          service.getReceiverAddress(
              addressId: controller.getCourierModel.value.receiverId ?? 0,
              accessToken: controller.accessToken.value)
        ]),
        child: (model) {
          AddressModel customerAddressModel = model[0];
          ReceiverAddressModel receiverAddressModel = model[1];
          return Container(
            margin: CustomPadding.symmetricInset(15, 5),
            child: Column(
              children: [
                CourierInformation(
                    customerAddressModel: customerAddressModel,
                    receiverAddressModel: receiverAddressModel,
                    type: type),
                selectedPriceText(),
                selectedCargoPrice(),
                nextButton()
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      leading: appBarIcon(),
      toolbarHeight: 30.h,
      flexibleSpace: appbarFlexibleSpace(),
      title: textWidget(title: title, fontsize: 14.sp, color: Colors.white),
    );
  }

  Container selectedPriceText() {
    return Container(
      padding: EdgeInsets.all(15.r),
      child: textWidget(
          title: "Gönderinizi nasıl göndermemizi istersiniz", fontsize: 16.sp),
    );
  }

  Obx nextButton() {
    return Obx(
      () => Container(
        margin: CustomPadding.onlyVerticalInset(20),
        child: selectedValue.value == 0
            ? AtomicOrangeButton(
                onPressed: () async {
                  await Get.toNamed("additionalServicePage", arguments: {
                    "price": price,
                    "type": type,
                    "weight": weight,
                  });
                  controller.packageProcurementServices.clear();
                  controller.packageProcurementServices.addAll([
                    AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
                    AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
                  ]);
                },
                title: "Devam Et")
            : Container(),
      ),
    );
  }

  Obx selectedCargoPrice() {
    return Obx(
      () => Container(
        padding: CustomPadding.symmetricInset(5, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r), color: Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Radio.adaptive(
              value: 0,
              activeColor: Colors.green,
              groupValue: selectedValue.value,
              onChanged: (value) {
                selectedValue.value = value ?? 0;
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      title: "STANDART",
                      fontsize: 14.sp,
                      fontWeight: FontWeight.bold),
                  textWidget(
                      title: "Tüm türkiye geneline standart taşıma hizmetidir.",
                      fontsize: 12.sp,
                      color: Colors.grey),
                ],
              ),
            ),
            Container(
              padding: CustomPadding.onlyHorizontalInset(10),
              child: textWidget(
                  title: "${price.toStringAsFixed(2)} TL",
                  fontsize: 17.sp,
                  color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
