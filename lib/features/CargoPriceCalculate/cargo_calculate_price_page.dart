import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/CargoPriceCalculate/cargo_calculate_price_mixin.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CargoPricaCalculatePage extends StatefulWidget {
  const CargoPricaCalculatePage({super.key});

  @override
  State<CargoPricaCalculatePage> createState() =>
      _CargoPricaCalculatePageState();
}

class _CargoPricaCalculatePageState extends State<CargoPricaCalculatePage>
    with CargoPricaCalculateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: CustomPadding.only(top: 50),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedCustomerAddressContainer(),
              SizedBox(height: 10.h),
              selectedRecevierAddressContainer(),
              nextButton()
            ],
          ),
        ),
      ),
    );
  }

  Container nextButton() {
    return Container(
      margin: CustomPadding.symmetricInset(50, 25),
      child: recevierAddressModel != null && customerAddressModel != null
          ? AtomicOrangeButton(
              onPressed: () {
                Get.toNamed("/shipmentType");
              },
              title: "Devam Et")
          : Container(),
    );
  }

  Widget selectedCustomerAddressContainer() {
    return Container(
      color: Colors.white,
      width: 190.w,
      height: 89.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: CustomPadding.onlyVerticalInset(10),
            child: checkImageWidget(
                iconData: "images/future_location_icon.png",
                state: customerAddressModel == null ? false : true),
          ),
          Divider(color: Colors.grey, height: 1.h),
          InkWell(
              onTap: () async {
                var result = await Get.toNamed("/addressPage", arguments: {
                  "incoming": "customer",
                  "process": "getCourier"
                });
                if (result != null) {
                  customerAddressModel = result;
                  setState(() {});
                }
              },
              child: Container(
                margin: CustomPadding.symmetricInset(10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        title: customerAddressModel == null
                            ? "Nereden?"
                            : "${customerAddressModel!.districtName}/${customerAddressModel!.provinceName}",
                        fontsize: 14.sp),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget selectedRecevierAddressContainer() {
    return Container(
      color: Colors.white,
      width: 190.w,
      height: 89.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: CustomPadding.onlyVerticalInset(10),
            child: checkImageWidget(
                iconData: "images/is_will_location_icon.png",
                state: recevierAddressModel == null ? false : true),
          ),
          Divider(color: Colors.grey, height: 1.h),
          InkWell(
            onTap: () async {
              var result = await Get.toNamed("/addressPage",
                  arguments: {"incoming": "recevier", "process": "getCourier"});
              if (result != null) {
                recevierAddressModel = result;
                setState(() {});
              }
            },
            child: Container(
              margin: CustomPadding.symmetricInset(10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                      title: recevierAddressModel == null
                          ? "Nereye?"
                          : "${recevierAddressModel!.districtName}/${recevierAddressModel!.provinceName}",
                      fontsize: 14.sp),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack checkImageWidget({required String iconData, bool state = false}) {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: Image.asset(iconData)),
        Align(
          alignment: Alignment.topRight,
          child: state
              ? SizedBox(
                  width: 15.w,
                  height: 15.h,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 10.r,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
