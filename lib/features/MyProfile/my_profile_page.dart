import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/MyProfile/my_profile_mixin.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> with MyProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          appbar(),
          Container(
            margin: CustomPadding.onlyHorizontalInset(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Container(
                  margin: CustomPadding.onlyHorizontalInset(10),
                  child: textWidget(
                      title: "SEÇENEKLER",
                      fontsize: 15.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                myProfileProperties(),
                SizedBox(height: 10.h),
                deleteUserButton(),
                SizedBox(height: 10.h),
                signOutButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  Container appbar() {
    return Container(
      width: double.infinity,
      height: (Get.height * 15) / 100,
      alignment: Alignment.center,
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
      child: textWidget(
          title:
              "HOŞGELDİN ${controller.userInformation.value.name?.toUpperCase()}",
          fontsize: 18.sp,
          color: Colors.white),
    );
  }

  InkWell deleteUserButton() {
    return InkWell(
      onTap: () async {
        await service
            .deleteCustomer(
                customerId: controller.currentAuth.value,
                accessToken: controller.accessToken.value)
            .then((value) {
          EasyLoading.showToast(value);
          deleteCustomer();
          Get.offAll("/main", arguments: {"userId": 0});
        }).onError((error, stackTrace) {
          EasyLoading.showToast(error.toString());
        });
      },
      child: Container(
        width: double.infinity,
        height: (Get.height * 7) / 100,
        padding: CustomPadding.allInset(10.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey),
            color: Colors.grey.shade100),
        child: textWidget(
            title: "Hesabımı Sil", fontsize: 15.sp, color: Colors.red),
      ),
    );
  }

  InkWell signOutButton() {
    return InkWell(
      onTap: () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt("userId", 0);
        controller.currentAuth.value = 0;
        controller.userInformation.value = LoginModel();
        controller.selectedBottomSheet.value = "main";
        Get.offAndToNamed("/main", arguments: {"userId": 0});
      },
      child: Container(
        width: double.infinity,
        height: (Get.height * 7) / 100,
        padding: CustomPadding.allInset(10.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey),
            color: Colors.grey.shade100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(title: "Çıkış Yap", fontsize: 15.sp, color: Colors.grey),
            const Icon(
              Icons.output,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Container myProfileProperties() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r), color: Colors.white),
      child: Column(
        children: [
          columnItems(title: "Kişisel Bilgilerim", onPressed: "updatePersonal"),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          columnItems(
              title: "Gönderici Adresleri", onPressed: "customerAddress"),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          columnItems(title: "Alıcı Adresleri", onPressed: "receiverAddress"),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          columnItems(title: "Şifre Değiştir", onPressed: "updatePassword"),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          columnItems(title: "Gönderilerim", onPressed: "myCargos"),
        ],
      ),
    );
  }

  InkWell columnItems({required String title, required String onPressed}) {
    return InkWell(
      onTap: () {
        clickController(onPressed);
      },
      child: ListTile(
        contentPadding: CustomPadding.onlyHorizontalInset(10),
        title: textWidget(
            title: title,
            fontsize: 14.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  void clickController(String title) {
    if (title.contains("updatePersonal")) {
      Get.toNamed(title);
    } else if (title.contains("customerAddress")) {
      Get.toNamed("/addressPage",
          arguments: {"incoming": "customer", "process": "information"});
    } else if (title.contains("receiverAddress")) {
      Get.toNamed("/addressPage",
          arguments: {"incoming": "receiver", "process": "information"});
    } else if (title.contains("updatePassword")) {
      Get.toNamed(title);
    } else {
      controller.selectedBottomSheet.value = "myCargos";
    }
  }
}
