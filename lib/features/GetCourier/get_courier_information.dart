import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CourierInformation extends StatelessWidget {
  CourierInformation({
    super.key,
    required this.customerAddressModel,
    required this.receiverAddressModel,
    required this.type,
    this.transportPrice,
    this.transportService,
  });
  final PartnerController controller = Get.find();
  final AddressModel customerAddressModel;
  final ReceiverAddressModel receiverAddressModel;
  String type;
  String? transportService;
  double? transportPrice;

  @override
  Widget build(BuildContext context) {
    return getCourierPackageInformationContainer();
  }

  Column getCourierPackageInformationContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: CustomPadding.allInset(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                  title: "Nereden",
                  fontsize: 14.sp,
                  color: Colors.grey.shade800),
              textWidget(
                  title: "Nereye",
                  fontsize: 14.sp,
                  color: Colors.grey.shade800),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.blueGrey.shade700,
                padding: CustomPadding.onlyVerticalInset(9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    textWidget(
                        title:
                            "${customerAddressModel.districtName} / ${customerAddressModel.provinceName}",
                        fontsize: 13.sp,
                        color: Colors.white),
                    const Icon(
                      Icons.swipe_right_alt_sharp,
                      color: Colors.white,
                    ),
                    textWidget(
                        title:
                            "${receiverAddressModel.districtName} / ${receiverAddressModel.provinceName}",
                        fontsize: 13.sp,
                        color: Colors.white),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: CustomPadding.allInset(10),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey.shade500,
                      size: 23.r,
                    ),
                  ),
                  textWidget(
                    title: DateFormat('dd MMMM y EEEE', 'tr_TR').format(
                        controller.getCourierModel.value.cargoRealeseDate!),
                    fontsize: 12.sp,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              Divider(height: 1.h, color: Colors.grey),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: CustomPadding.onlyHorizontalInset(10),
                    child: Image.asset("images/parcel_icon.png",
                        width: 20.w, height: 20.h, color: Colors.grey),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: CustomPadding.onlyVerticalInset(5),
                        child: textWidget(title: type, fontsize: 12.sp),
                      ),
                      transportPrice == null && transportService == null
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: CustomPadding.onlyVerticalInset(5),
                                  child: Row(
                                    children: [
                                      textWidget(
                                        title: "Taşıma Hizmeti: ",
                                        fontsize: 12.sp,
                                      ),
                                      textWidget(
                                          title: transportService!,
                                          fontsize: 12.sp,
                                          color: Colors.grey.shade600),
                                    ],
                                  ),
                                ),
                                transportPrice != null
                                    ? Container(
                                        padding:
                                            CustomPadding.onlyVerticalInset(5),
                                        child: Row(
                                          children: [
                                            textWidget(
                                                title:
                                                    "Taşıma Hizmeti Bedeli: ",
                                                fontsize: 12.sp,
                                                color: Colors.grey.shade600),
                                            textWidget(
                                              title:
                                                  "${transportPrice?.toStringAsFixed(2)} TL",
                                              fontsize: 12.sp,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
