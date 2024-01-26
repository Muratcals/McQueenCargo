import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page_widgets.dart';

class MainBottomSheet extends StatefulWidget {
  const MainBottomSheet({super.key});
  @override
  State<MainBottomSheet> createState() => _MainBottomSheetState();
}

class _MainBottomSheetState extends State<MainBottomSheet> {
  late PartnerController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  final MainPageWidgets widgets = MainPageWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.symmetricInset(5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              controller.selectedBottomSheet.value = "main";
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetIcon(icon: "images/main_icon.png", title: "main"),
                widgets.textWidgets(title: "Ana Sayfa")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.currentAuth.value == 0) {
                Get.toNamed("/loginPage");
              } else {
                controller.selectedBottomSheet.value = "myCargos";
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetIcon(
                    icon: "images/cargos_icon.png", title: "myCargos"),
                widgets.textWidgets(title: "Kargolarım")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.currentAuth.value == 0) {
                Get.toNamed("/loginPage");
              } else {
                controller.selectedBottomSheet.value = "getCourier";
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetIcon(
                    icon: "images/get_cargo_icon.png", title: "getCourier"),
                widgets.textWidgets(title: "Kurye Çağır")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.currentAuth.value == 0) {
                Get.toNamed("/loginPage");
              } else {
                controller.selectedBottomSheet.value = "calculatePrice";
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetIcon(
                    icon: "images/cargo_price_calculator_icon.png",
                    title: "calculatePrice"),
                widgets.textWidgets(title: "Fiyat Hesapla")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.currentAuth.value == 0) {
                Get.toNamed("/loginPage");
              } else {
                controller.selectedBottomSheet.value = "myProfile";
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetIcon(
                    icon: "images/profil_icon.png", title: "myProfile"),
                widgets.textWidgets(title: "Profilim")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheetIcon({required String icon, required String title}) {
    return Obx(
      () => Image.asset(
        icon,
        width: 20.w,
        height: 20.h,
        color: controller.selectedBottomSheet.value.contains(title)
            ? null
            : Colors.grey,
      ),
    );
  }
}
