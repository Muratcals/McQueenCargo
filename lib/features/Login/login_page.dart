import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/Login/login_mixin.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          appBar: widgets.loginAppBar(),
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
                          widgets.ePostaWidget(),
                          SizedBox(height: 15.h),
                          widgets.passwordWidget(),
                          SizedBox(
                            height: 5.h,
                          ),
                          widgets.resetPasswordWidget(),
                          SizedBox(
                            height: 15.h,
                          ),
                          widgets.loginButton(key, (_) {
                            visibilty.value = _;
                          }),
                          widgets.notAccountWidget()
                        ],
                      ),
                    ),
                  ),
                ),
              ))),
    );
  }
}
