import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/response_error.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/cargo_calculate_price_page.dart';
import 'package:mc_queen_cargo/features/View/Cargos/get_courier_cargos_page.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_page.dart';
import 'package:mc_queen_cargo/features/View/Home/home_page.dart';
import 'package:mc_queen_cargo/features/View/Main/main_bottom_sheet_widget.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page_mixin.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/my_profile_page.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

part '../Main/main_page_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainMixin {
  @override
  void initState() {
    super.initState();
    ErrorResponse.stream.listen((event) {
      ErrorResponse.responseErrorDialog(context, event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
            preferredSize: Size(30.w, 20.h), child: _MainAppBar()),
        bottomNavigationBar: const MainBottomSheet(),
        body: GetBuilder<PartnerController>(
          builder: (controller) {
            return userId == 0
                ? _MainPageDesign()
                : AtomicFutureBuilder(
                    future: service.getCustomerInformation(userId),
                    child: (model) {
                      controller.userInformation.value = model;
                      return _MainPageDesign();
                    },
                  );
          },
        ),
      ),
    );
  }
}
