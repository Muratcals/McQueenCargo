import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/PersonalInformation/personal_information_mixin.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage>
    with PersonalInformationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: widgets.appBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: CustomPadding.onlyHorizontalInset(40),
            child: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widgets.nameWidget(),
                  SizedBox(height: 15.h),
                  widgets.lastNameWidget(),
                  SizedBox(height: 15.h),
                  widgets.tcNumberWidget(),
                  SizedBox(height: 15.h),
                  widgets.dateTimeWidget(context),
                  SizedBox(height: 15.h),
                  AtomicOrangeButton(
                      onPressed: () {
                        var isValidate = key.currentState!.validate();
                        if (isValidate) {
                          key.currentState!.save();
                          FocusScope.of(context).unfocus();
                          Get.toNamed("/contactInformationPage");
                        }
                      },
                      title: "Devam Et")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
