import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/Home/home_page_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        homePageAppBar(controller.currentAuth.value != 0
            ? "HOŞGELDİN ${controller.userInformation.value.name}"
            : "Giriş Yap / Üye Ol"),
        searchCargoTextForm(),
      ],
    );
  }

  Container searchCargoTextForm() {
    return Container(
      margin:
          EdgeInsets.only(top: (Get.height * 9) / 100, left: 10.w, right: 10.w),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.black)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Gönderi Ara",
          hintStyle: TextStyle(
              color: Colors.black, fontFamily: "times", fontSize: 13.sp),
          suffixIcon: IconButton(
              onPressed: () async {
                await service
                    .getTrackingCargo(
                        accessToken: controller.accessToken.value,
                        trackingNo: trackingNo,
                        incoming: "Cargo")
                    .then((value) {
                  Get.toNamed("cargoDetailPage",
                      arguments: {"cargoId": value.id});
                });
              },
              icon: const Icon(Icons.search)),
        ),
        onChanged: (newValue) {
          trackingNo = newValue;
        },
      ),
    );
  }

  Container homePageAppBar(String title) {
    return Container(
      width: double.infinity,
      height: (Get.height * 13) / 100,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.blue.shade700
          ],
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [loginButtonWidget(title: title), profilIconWidget()],
      ),
    );
  }

  Container profilIconWidget() {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(
        10,
      ),
      child: InkWell(
        onTap: () {
          if (controller.currentAuth.value != 0) {
            controller.selectedBottomSheet.value = "myProfile";
          } else {
            Get.toNamed("/loginPage");
          }
        },
        child: const CircleAvatar(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container loginButtonWidget({required String title}) {
    return Container(
      margin: CustomPadding.symmetricInset(15, 5),
      child: InkWell(
          onTap: () async {
            if (title == "Giriş Yap / Üye Ol") {
              await Get.toNamed("/loginPage");
              setState(() {});
            }
          },
          child:
              textWidget(title: title, fontsize: 14.sp, color: Colors.white)),
    );
  }
}
