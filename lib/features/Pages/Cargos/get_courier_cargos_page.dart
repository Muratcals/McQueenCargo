import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/cargo_information_model.dart';
import 'package:mc_queen_cargo/features/Model/call_courier_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/Cargos/get_courier_cargos_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

part 'get_courier_cargos_widget.dart';

class GetCourierCargosPage extends StatefulWidget {
  const GetCourierCargosPage({super.key});

  @override
  State<GetCourierCargosPage> createState() => _GetCourierCargosPageState();
}

class _GetCourierCargosPageState extends State<GetCourierCargosPage>
    with GetCourierCargosMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: _CargosPageBody(
          service: service, tcNo: tcNo),
    );
  }
}
