import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/GetCourier/Approve/approve_mixin.dart';
import 'package:mc_queen_cargo/features/GetCourier/get_courier_information.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/post_courier_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApprovePage extends StatefulWidget {
  const ApprovePage({super.key});

  @override
  State<ApprovePage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> with ApproveMixin {
  @override
  Widget build(BuildContext context) {
    return StackProgressWidget(
      visibility: visibilty,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          flexibleSpace: appbarFlexibleSpace(),
          leading: appBarIcon(),
          toolbarHeight: 30.h,
          centerTitle: true,
          title: textWidget(title: title, fontsize: 14.sp, color: Colors.white),
        ),
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
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Container(
                margin: CustomPadding.symmetricInset(15, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CourierInformation(
                        customerAddressModel: customerAddressModel,
                        receiverAddressModel: receiverAddressModel,
                        type: type,
                        transportService: "STANDART"),
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: approveColumnItems(),
                    ),
                    SizedBox(height: 10.h),
                    informationText(),
                    SizedBox(height: 10.h),
                    cargoSaveButton()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AtomicOrangeButton cargoSaveButton() {
    return AtomicOrangeButton(
        onPressed: () {
          visibilty.value = true;
          controller.getCourierModel.value.callCourierOk = false;
          controller.getCourierModel.value.cargoTransportationConditionsId = 1;
          controller.getCourierModel.value.price =
              double.parse(sumPrice.toStringAsFixed(2));
          service
              .postCargo(
                  model: controller.getCourierModel.value,
                  accessToken: controller.accessToken.value)
              .then((value) {
            EasyLoading.showSuccess(value);
            controller.getCourierModel.value = PostCourierModel();
            updateAdditionalService();
            Get.offAllNamed("/main",arguments: {
              "userId":0
            });
          }).onError((error, stackTrace) {
            EasyLoading.showError(error.toString());
            visibilty.value = false;
          });
        },
        title: "Onayla");
  }

  Text informationText() {
    return Text(
      "Seçimize göre tahmini gönderi bedeli üst sınırdan hesaplanacak, gerçek fiyat ise şubede kargonuzun ölçüm tartım işlemleri gerçekleştikten sonra belirlenecektir.",
      style: TextStyle(color: Colors.red, fontSize: 12.sp),
      textAlign: TextAlign.center,
    );
  }

  Column paymentType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
            title: "Ödeme", fontsize: 13.sp, fontWeight: FontWeight.bold),
        SizedBox(height: 5.h),
        Row(
          children: [
            Icon(
              Icons.wallet,
              size: 20.r,
            ),
            SizedBox(width: 5.w),
            textWidget(
                title: "Nakit Ödeme",
                fontsize: 13.sp,
                color: Colors.grey.shade700)
          ],
        )
      ],
    );
  }

  Column priceInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
            title: "Fiyat Bilgisi",
            fontsize: 13.sp,
            fontWeight: FontWeight.bold),
        SizedBox(height: 5.h),
        priceInformationColumnItems(
            title: "Toplam Fiyat:  ",
            subTitle: "${price.toStringAsFixed(2)} TL"),
        SizedBox(height: 5.h),
        priceInformationColumnItems(
            title: "Toplam Kdv:  ", subTitle: "${tax.toStringAsFixed(2)} TL"),
        SizedBox(height: 5.h),
        priceInformationColumnItems(
            title: "GENEL TOPLAM:  ",
            subTitle: "${sumPrice.toStringAsFixed(2)} TL")
      ],
    );
  }

  Row priceInformationColumnItems(
      {required String title, required String subTitle}) {
    return Row(
      children: [
        textWidget(
            title: title,
            fontsize: 13.sp,
            fontWeight: title.contains("GENEL TOPLAM")
                ? FontWeight.bold
                : FontWeight.normal,
            color: Colors.grey.shade700),
        textWidget(
            title: subTitle,
            fontsize: 13.sp,
            fontWeight: title.contains("GENEL TOPLAM")
                ? FontWeight.bold
                : FontWeight.normal,
            color: title.contains("GENEL TOPLAM")
                ? Colors.green
                : Colors.grey.shade700)
      ],
    );
  }

  Column additionalServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textWidget(
            title: "Ek Hizmetler",
            fontsize: 13.sp,
            fontWeight: FontWeight.bold),
        SizedBox(height: 5.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addionatiolServiceRowItems(title: "Adresten Alım"),
            SizedBox(width: 5.h),
            addionatiolServiceRowItems(
                title: type == "KOLİ - PAKET"
                    ? controller.packageDeliveryServices[deliveryIndex].name
                    : controller.fileDeliveryServices[deliveryIndex].name)
          ],
        )
      ],
    );
  }

  Row addionatiolServiceRowItems({required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 8.r,
          child: Icon(
            Icons.done,
            size: 10.r,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 3.h),
        textWidget(title: title, fontsize: 13.sp)
      ],
    );
  }

  Widget approveColumnItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: Colors.grey, height: 1.h),
        SizedBox(height: 10.h),
        additionalServices(),
        SizedBox(height: 10.h),
        Divider(color: Colors.grey, height: 1.h),
        SizedBox(height: 5.h),
        priceInformation(),
        SizedBox(height: 10.h),
        Divider(color: Colors.grey, height: 1.h),
        SizedBox(height: 5.h),
        paymentType(),
      ],
    );
  }
}
