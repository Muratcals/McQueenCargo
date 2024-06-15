// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Controllers/SelectedPostCubit/selected_post_type_cubit.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/SelectedPostType/selected_post_type_mixin.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/get_courier_information.dart';
import 'package:mc_queen_cargo/features/Constants/GetCourierCubit/post_courier_cubit.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part 'selected_post_widget.dart';

class SelectedPostType extends StatefulWidget {
  const SelectedPostType({super.key});

  @override
  State<SelectedPostType> createState() => _SelectedPostTypeState();
}

class _SelectedPostTypeState extends State<SelectedPostType>
    with SelectedPostTypeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
          preferredSize: Size(30.w, 30.h),
          child: _AppBar(
            title: title,
          )),
      body: BlocProvider(
        create: (context) => SelectedPostTypeCubit(),
        child: _SelectedPostBody(
          service: service,
          type: type,
          price: price,
          weight: weight,
        ),
      ),
    );
  }
}
