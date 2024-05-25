import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_information.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/cargo_calculate_price_page.dart';
import 'package:mc_queen_cargo/features/Pages/Cargos/get_courier_cargos_page.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/view/get_courier_page.dart';
import 'package:mc_queen_cargo/features/Pages/Home/home_page.dart';
import 'package:mc_queen_cargo/features/Pages/Main/main_bottom_sheet_widget.dart';
import 'package:mc_queen_cargo/features/Pages/Main/main_page_mixin.dart';
import 'package:mc_queen_cargo/features/Pages/Main/selected_bottom_sheet.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/my_profile_page.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

part 'main_page_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SelectedBottomSheet(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: PreferredSize(
              preferredSize: Size(30.w, 20.h), child: _MainAppBar()),
          bottomNavigationBar: const MainBottomSheet(),
          body: Auth.authId == 0
              ? _MainPageDesign()
              : AtomicFutureBuilder(
                  future: service.getCustomerInformation(Auth.authId),
                  child: (model) {
                    AuthInformation.auth = model;
                    return _MainPageDesign();
                  },
                  onError: () => setState(() {
                    
                  }),
                ),
        ),
      ),
    );
  }
}
