import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/PersonalInformation/personal_information_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part '../PersonalInformation/personal_information_widgets.dart';

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
      appBar: PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar()),
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
                  _NameTextField(),
                  SizedBox(height: 15.h),
                  _LastNameTextField(),
                  SizedBox(height: 15.h),
                  _TcNumberTextField(),
                  SizedBox(height: 15.h),
                  _DateTimeField(),
                  SizedBox(height: 15.h),
                  AtomicOrangeButton(
                      onPressed: () {
                        onPressed();
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
