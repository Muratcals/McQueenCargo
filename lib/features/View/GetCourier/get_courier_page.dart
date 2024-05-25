import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_controller.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_mixin.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part '../GetCourier/get_courier_widgets.dart';

class GetCourierPage extends StatefulWidget {
  const GetCourierPage({super.key});

  @override
  State<GetCourierPage> createState() => _GetCourierPageState();
}

class _GetCourierPageState extends State<GetCourierPage> with GetCourierMixin {
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: _GetCourierBody(),
    );
  }
}
