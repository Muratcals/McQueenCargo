import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/Register/Password/password_page_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

part '../Password/password_page_widget.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> with PasswordPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar()),
      body: Center(
        child: Form(
          key: key,
          child: Container(
            margin: CustomPadding.onlyHorizontalInset(40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PasswordTextField(password1: password1,),
                  SizedBox(height: 15.h),
                  _PasswordRepeatTextField(password1: password1,),
                  SizedBox(height: 10.h),
                  AtomicOrangeButton(
                      onPressed: () {
                        onPressed();
                      },
                      title: "Devam Et"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
