import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Service/response_error.dart';
import 'package:mc_queen_cargo/features/View/Main/main_bottom_sheet_widget.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        appBar: mainAppBar(),
        bottomNavigationBar: const MainBottomSheet(),
        body: userId == 0
            ? mainPageWidget()
            : AtomicFutureBuilder(
                future: service.getCustomerInformation(
                    userId, partnerController.accessToken.value),
                child: (model) {
                  partnerController.userInformation.value = model;
                  return mainPageWidget();
                },
              ),
      ),
    );
  }

  Widget mainPageWidget() {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Obx(
          () {
            return widgets
                .bottomSheetWidget(partnerController.selectedBottomSheet.value);
          },
        ),
      ),
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      title: Text(
        "McQueenCargo",
        style: TextStyle(
            color: Colors.white, fontSize: 14.sp, fontFamily: "appBar"),
      ),
      leading: Container(),
      flexibleSpace: appbarFlexibleSpace(),
      centerTitle: true,
      toolbarHeight: 20.h,
      elevation: 0,
    );
  }
}
