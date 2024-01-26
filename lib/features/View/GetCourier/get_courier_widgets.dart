import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_mixin.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetCourierWidegets extends StatefulWidget {
  const GetCourierWidegets({super.key});

  @override
  State<GetCourierWidegets> createState() => _GetCourierWidegetsState();
}

class _GetCourierWidegetsState extends State<GetCourierWidegets>
    with GetCourierMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 40.h),
          selectedAddressContainer(),
          SizedBox(height: 30.h),
          Obx(
            () => receiverAddressModel.value.id != null &&
                    customerAddresssModel.value.id != null
                ? bottomContainer()
                : Container(),
          )
        ],
      ),
    );
  }

  Container bottomContainer() {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(15),
      padding: CustomPadding.allInset(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: bottomContainerColumn(),
    );
  }

  Column bottomContainerColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: [
            selectedDateWidget(),
            selectedCargoTypeWidget(),
          ],
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.9,
            aspectRatio: 1.5,
            initialPage: 0,
          ),
        )
      ],
    );
  }

  Widget selectedDateWidget() {
    return Column(
      children: [
        Text(
          "Gönderiniz hangi tarihte göndermek istiyorsunuz",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 15.sp),
        ),
        SizedBox(height: 3.h),
        Divider(
          color: Colors.grey,
          height: 1.h,
        ),
        SizedBox(height: 3.h),
        Container(
          padding: CustomPadding.symmetricInset(10, 5),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        carouselController.nextPage();
                        selectedDate.value = 1;
                        controller.getCourierModel.value.cargoRealeseDate =
                            DateTime.now();
                      },
                      child: dateWidget("Bugün", DateTime.now(), 1)),
                  InkWell(
                    onTap: () {
                      carouselController.nextPage();
                      selectedDate.value = 2;
                      controller.getCourierModel.value.cargoRealeseDate =
                          DateTime.now().add(const Duration(days: 1));
                    },
                    child: dateWidget("Yarın",
                        DateTime.now().add(const Duration(days: 1)), 2),
                  )
                ],
              )),
        ),
      ],
    );
  }

  Container dateWidget(String title, DateTime date, int selectedValue) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: Colors.green, width: 1.h),
          color: selectedDate.value == selectedValue
              ? Colors.green
              : Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: CustomPadding.symmetricInset(30, 3),
            color: Colors.white,
            child:
                textWidget(title: title, fontsize: 14.sp, color: Colors.grey),
          ),
          Container(
            padding: CustomPadding.onlyHorizontalInset(25),
            child: textWidget(
                title: monthConverter(date.month),
                fontsize: 15.sp,
                color: selectedDate.value == selectedValue
                    ? Colors.white
                    : Colors.green),
          ),
          textWidget(
              title: date.day.toString(),
              fontsize: 35.sp,
              fontWeight: FontWeight.bold,
              color: selectedDate.value == selectedValue
                  ? Colors.white
                  : Colors.green),
          textWidget(
              title: DateFormat('EEEE', "tr").format(date),
              fontsize: 13.sp,
              fontWeight: FontWeight.normal,
              color: selectedDate.value == selectedValue
                  ? Colors.white
                  : Colors.green),
          SizedBox(
            height: 4.h,
          )
        ],
      ),
    );
  }

  Container selectedAddressContainer() {
    return Container(
      padding: CustomPadding.allInset(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: Colors.grey, width: 0.5),
        color: Colors.white,
      ),
      margin: CustomPadding.onlyHorizontalInset(30),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () async {
                var model = await Get.toNamed("/addressPage", arguments: {
                  "incoming": "customer",
                  "process": "getCourier"
                });
                if (model != null) {
                  customerAddresssModel.value = model;
                  controller.getCourierModel.value.customerMobilAdressId =
                      customerAddresssModel.value.id;
                }
              },
              child: Container(
                padding: CustomPadding.allInset(5),
                child: selectedAddressColumnItem(
                    icon: "images/future_location_icon.png",
                    title: customerAddresssModel.value.title ??
                        "Gönderici Adresi Seçiniz",
                    district: customerAddresssModel.value.districtName,
                    provinceName: customerAddresssModel.value.provinceName),
              ),
            ),
            SizedBox(height: 5.h),
            Divider(
              color: Colors.grey,
              height: 1.h,
            ),
            SizedBox(height: 5.h),
            InkWell(
              onTap: () async {
                var model = await Get.toNamed("/addressPage", arguments: {
                  "incoming": "receiver",
                  "process": "getCourier"
                });
                if (model != null) {
                  receiverAddressModel.value = model;
                  controller.getCourierModel.value.receiverId =
                      receiverAddressModel.value.id;
                }
              },
              child: Container(
                padding: CustomPadding.allInset(5),
                child: selectedAddressColumnItem(
                    icon: "images/is_will_location_icon.png",
                    title: receiverAddressModel.value.title ??
                        "Alıcı Adresi Seçiniz",
                    district: receiverAddressModel.value.districtName,
                    provinceName: receiverAddressModel.value.provinceName),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row selectedAddressColumnItem(
      {required String icon,
      required String title,
      String? district,
      String? provinceName}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          icon,
          width: 25,
          height: 25,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            textWidget(
                title: title, fontsize: 13.sp, fontWeight: FontWeight.bold),
            district == null
                ? Container()
                : textWidget(
                    title: "$district/$provinceName",
                    fontsize: 14.sp,
                    fontWeight: FontWeight.normal),
          ],
        ),
        const Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.chevron_right)),
        )
      ],
    );
  }

  Column cargoTypeWidget({required String icon, required String title}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          width: 80.w,
          height: 60.h,
        ),
        Container(
          padding: CustomPadding.onlyHorizontalInset(
            15,
          ),
          child: textWidget(
            title: title,
            fontsize: 15.sp,
          ),
        ),
        SizedBox(
          height: 4.h,
        )
      ],
    );
  }

  Widget selectedCargoTypeWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
          child: Text(
            "Lütfen gönderi tipini seçiniz",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5.h),
        Divider(
          color: Colors.grey,
          height: 1.h,
        ),
        SizedBox(height: 5.h),
        Container(
          padding: CustomPadding.symmetricInset(5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () async {
                    controller.getCourierModel.value.cargoParcelTypeId = 5;
                    controller.getCourierModel.value.customerMobilId =
                        controller.currentAuth.value;
                    await Get.toNamed("getCourierShipmentType", arguments: {
                      "price": 43.58 - (43.58 * 25) / 100,
                      "type": "DOSYA - EVRAK",
                      "weight": 2.0
                    });
                  },
                  child: cargoTypeWidget(
                      icon: "images/file_icon.png", title: "Dosya-Evrak")),
              InkWell(
                  onTap: () {
                    controller.getCourierModel.value.cargoParcelTypeId = 6;
                    controller.getCourierModel.value.customerMobilId =
                        controller.currentAuth.value;
                    Get.toNamed("/parcelSending", arguments: {
                      "incoming": "getCourier",
                    });
                  },
                  child: cargoTypeWidget(
                      icon: "images/parcel_icon.png", title: "Koli-Paket")),
            ],
          ),
        ),
      ],
    );
  }
}
