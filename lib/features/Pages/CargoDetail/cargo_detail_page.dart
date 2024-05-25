import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/cargo_information_model.dart';
import 'package:mc_queen_cargo/features/Model/cargo_movements_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CargoDetail/cargo_detail_mixin.dart';
import 'package:mc_queen_cargo/features/Pages/CargoDetail/cargo_state_widget.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


part 'cargo_detail_widget.dart';

class CargoDetailPage extends StatefulWidget {
  const CargoDetailPage({super.key});

  @override
  State<CargoDetailPage> createState() => _CargoDetailPageState();
}

class _CargoDetailPageState extends State<CargoDetailPage>
    with CargoDetailMixin, TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(30.w, 30.h),
        child: _AppBar(),
      ),
      body: _CargoDetailDesign(
          service: service,
          cargoId: cargoId,
          tabController: tabController,
          tabIndex: tabIndex),
    );
  }
}
