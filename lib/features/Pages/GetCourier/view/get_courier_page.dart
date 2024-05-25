import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/cubit/get_courier_cubit.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/Constants/GetCourierCubit/post_courier_cubit.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part 'get_courier_widgets.dart';

class GetCourierPage extends StatefulWidget {
  const GetCourierPage({super.key});

  @override
  State<GetCourierPage> createState() => _GetCourierPageState();
}

class _GetCourierPageState extends State<GetCourierPage>{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => GetCourierCubit(),
        child: const _GetCourierBody(),
      ),
    );
  }
}
