import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Controllers/LoginCubit/login_cubit.dart';
import 'package:mc_queen_cargo/features/Pages/Login/login_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_widgets.dart';

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
            preferredSize: Size(70.w, 70.h), child: const _LoginAppBar()),
        body: StackProgressWidget(
          visibility: visibilty,
          child: Center(
            child: Container(
              margin: CustomPadding.onlyHorizontalInset(40),
              child: BlocProvider(
                create: (context) => LoginCubit(),
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
      ),
    );
  }
}
