import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/UpdatePersonal/update_parsonal_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePersonalPage extends StatefulWidget {
  const UpdatePersonalPage({super.key});

  @override
  State<UpdatePersonalPage> createState() => _UpdatePersonalPageState();
}

class _UpdatePersonalPageState extends State<UpdatePersonalPage>
    with UpdatePersonalMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: appBarIcon(),
        title: textWidget(
            title: "Kişisel Bilgiler", fontsize: 14.sp, color: Colors.white),
        centerTitle: true,
        flexibleSpace: appbarFlexibleSpace(),
      ),
      body: Container(
        margin: CustomPadding.symmetricInset(15, 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5.h),
            _columnItems(
                title: "Ad", value: controller.userInformation.value.name!),
            _columnItems(
                title: "Soyad",
                value: controller.userInformation.value.surname!),
            _columnItems(
                title: "Tc Kimlik No",
                value:
                    "${controller.userInformation.value.tcNo!.substring(0, 3)}********"),
            _columnItems(
                title: "E-Posta",
                value: controller.userInformation.value.email!),
            _columnItems(
                title: "Cep Telefon No",
                value: controller.userInformation.value.numberPhone!),
            SizedBox(height: 5.h)
          ],
        ),
      ),
    );
  }

  Container _columnItems({required String title, required String value}) {
    return Container(
      padding: CustomPadding.symmetricInset(10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(
              title: title, fontsize: 13.sp, color: Colors.grey.shade500),
          textWidget(
              title: value,
              fontsize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500)
        ],
      ),
    );
  }
}
