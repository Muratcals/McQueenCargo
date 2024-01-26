import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/ContactInformation/contact_information_mixin.dart';

class ContactInformationPage extends StatefulWidget {
  const ContactInformationPage({super.key});

  @override
  State<ContactInformationPage> createState() => _ContactInformationPageState();
}

class _ContactInformationPageState extends State<ContactInformationPage>
    with ContactInformationPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: widgets.appBar(),
        body: Center(
          child: Container(
            margin: CustomPadding.onlyHorizontalInset(40),
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    widgets.eMailWidget(),
                    SizedBox(height: 15.h),
                    widgets.eMailRepeatWidget(),
                    SizedBox(height: 15.h),
                    widgets.phoneNumberWidget(),
                    SizedBox(height: 15.h),
                    AtomicOrangeButton(
                        onPressed: () {
                          bool isValidate = key.currentState!.validate();
                          if (isValidate) {
                            key.currentState!.save();
                            FocusScope.of(context).unfocus();
                            Get.toNamed("/passwordPage");
                          }
                        },
                        title: "Devam Et")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
