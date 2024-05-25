import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/View/Login/login_controller.dart';
import 'package:mc_queen_cargo/features/View/Login/login_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';

part  '../Login/login_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
            preferredSize: Size(60.w, 60.h), child: const _LoginAppBar()),
        body: StackProgressWidget(
          visibility: visibilty,
          child: Center(
            child: Container(
              margin: CustomPadding.onlyHorizontalInset(40),
              child: Form(
                key: key,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 10.h),
                      const _EPostaTextField(),
                      SizedBox(height: 15.h),
                      const _PasswordTextField(),
                      SizedBox(
                        height: 5.h,
                      ),
                      const _ResetPasswordButton(),
                      SizedBox(
                        height: 15.h,
                      ),
                      _LoginButton(
                        globalKey: key,
                        onPressed: (_) {
                          visibilty.value = _;
                        },
                        service: service,
                      ),
                      const _NotAccountWidget()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
