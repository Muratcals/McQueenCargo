import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/Main/selected_bottom_sheet.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class MainBottomSheet extends StatefulWidget {
  const MainBottomSheet({super.key});
  @override
  State<MainBottomSheet> createState() => _MainBottomSheetState();
}

class _MainBottomSheetState extends State<MainBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedBottomSheet, String>(
      builder: (context, state) {
        return Container(
          padding: CustomPadding.symmetricInset(5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  context.read<SelectedBottomSheet>().changeValue("main");
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _BottomSheetIcon(
                        icon: "images/main_icon.png", title: "main"),
                    GeneralTextWidget(
                      title: "Ana Sayfa",
                      fontsize: 14.sp,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (Auth.authId == 0) {
                    Get.toNamed(GenerateRoute.loginPage);
                  } else {
                    context.read<SelectedBottomSheet>().changeValue("myCargos");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _BottomSheetIcon(
                        icon: "images/cargos_icon.png", title: "myCargos"),
                    GeneralTextWidget(
                      title: "Kargolarım",
                      fontsize: 14.sp,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (Auth.authId == 0) {
                    Get.toNamed(GenerateRoute.loginPage);
                  } else {
                    context
                        .read<SelectedBottomSheet>()
                        .changeValue("getCourier");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _BottomSheetIcon(
                        icon: "images/get_cargo_icon.png", title: "getCourier"),
                    GeneralTextWidget(
                      title: "Kurye Çağır",
                      fontsize: 14.sp,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (Auth.authId == 0) {
                    Get.toNamed(GenerateRoute.loginPage);
                  } else {
                    context
                        .read<SelectedBottomSheet>()
                        .changeValue("calculatePrice");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _BottomSheetIcon(
                        icon: "images/cargo_price_calculator_icon.png",
                        title: "calculatePrice"),
                    GeneralTextWidget(
                      title: "Fiyat Hesapla",
                      fontsize: 14.sp,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (Auth.authId == 0) {
                    Get.toNamed(GenerateRoute.loginPage);
                  } else {
                    context
                        .read<SelectedBottomSheet>()
                        .changeValue("myProfile");
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _BottomSheetIcon(
                        icon: "images/profil_icon.png", title: "myProfile"),
                    GeneralTextWidget(
                      title: "Profilim",
                      fontsize: 14.sp,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomSheetIcon extends StatelessWidget {
  const _BottomSheetIcon({required this.icon, required this.title});
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedBottomSheet, String>(builder: (context, state) {
      return Image.asset(
        icon,
        width: 20.w,
        height: 20.h,
        color: state.contains(title) ? null : Colors.grey,
      );
    });
  }
}
