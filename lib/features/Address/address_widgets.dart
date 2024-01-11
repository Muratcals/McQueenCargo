import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdressWidgets {
  Widget customerAddresslistItems(
      {required AddressModel item,
      required String process,
      required Function(int state) setStatePage}) {
    return InkWell(
      onTap: () async {
        if (process.contains("getCourier")) {
          Get.back(result: item);
        } else {
          var result = await Get.toNamed("/customerAddressInformationPage",
              arguments: {"addressId": item.id});
          if (result != null) {
            setStatePage(result);
          }
        }
      },
      child: Container(
        margin: CustomPadding.onlyHorizontalInset(5),
        padding: CustomPadding.symmetricInset(10, 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.home,
                color: Colors.grey.shade600,
                size: 40,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textWidget(
                      title: item.title!,
                      fontsize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textWidget(
                      title: "${item.districtName}/${item.provinceName}",
                      fontsize: 13.sp,
                      color: Colors.grey.shade500),
                  SizedBox(height: 3.h),
                  textWidget(
                      color: Colors.grey.shade700,
                      title:
                          "${item.neighbourhoodName} ${item.street} No:${item.buildingNo} D:${item.apartmentNumber}",
                      fontsize: 13.sp)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget receiverAddresslistItems(
      {required ReceiverAddressModel item,
      required String process,
      required Function(dynamic state) setStatePage}) {
    return InkWell(
      onTap: () async {
        if (process.contains("getCourier")) {
          Get.back(result: item);
        } else {
          var result = await Get.toNamed("/receiverAddressInformationPage",
              arguments: {"addressId": item.id});
          if (result != null) {
            setStatePage(result);
          }
        }
      },
      child: Container(
        margin: CustomPadding.onlyHorizontalInset(5),
        padding: CustomPadding.symmetricInset(10, 5),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.home,
                color: Colors.grey.shade600,
                size: 40,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textWidget(
                      title: item.title!,
                      fontsize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textWidget(
                      title: "${item.districtName}/${item.provinceName}",
                      fontsize: 12.sp,
                      color: Colors.grey.shade500),
                  SizedBox(height: 5.h),
                  textWidget(
                      color: Colors.grey.shade700,
                      title:
                          "${item.neighbourhoodName} ${item.street} No:${item.buildingNo} D:${item.apartmentNumber}",
                      fontsize: 12.sp)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize appBarBottomItem(String incoming, Function() reload) {
    return PreferredSize(
      preferredSize: Size((Get.width * 90) / 100, 30.h),
      child: Container(
        alignment: Alignment.center,
        margin: CustomPadding.only(top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(color: Colors.grey.shade500, width: 1.w),
          ),
        ),
        child: TextButton(
          onPressed: () async {
            PartnerController controller = Get.find();
            await Get.toNamed("createAddressPage", arguments: incoming);
            controller.customerAddressModel.value = AddressModel();
            controller.receiverAddressModel.value = ReceiverAddressModel();
            reload();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: Colors.orange,
              ),
              textWidget(
                  title: incoming.contains("customer")
                      ? "Gönderici Adresi Ekle"
                      : "Alıcı Adresi Ekle",
                  fontsize: 14.sp,
                  color: Colors.orange)
            ],
          ),
        ),
      ),
    );
  }
}
