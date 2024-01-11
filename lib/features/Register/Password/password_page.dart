import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Register/Password/password_page_mixin.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> with PasswordPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                  passwordWidget(),
                  SizedBox(height: 15.h),
                  passwordRepeatWidget(),
                  SizedBox(height: 10.h),
                  AtomicOrangeButton(
                      onPressed: () {
                        bool isValidate = key.currentState!.validate();
                        if (isValidate) {
                          key.currentState!.save();
                          FocusScope.of(context).unfocus();
                          Get.toNamed("/registerPage", arguments: "finish");
                        }
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

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 30.h,
      leading: appBarIcon(),
      flexibleSpace: appbarFlexibleSpace(),
      centerTitle: true,
      title: Text(
        "Şifre İşlemleri",
        style: TextStyle(fontSize: 15.sp),
      ),
    );
  }

  AtomicTextFormField passwordWidget() {
    return AtomicTextFormField(
      onSaved: (newValue) {
        controller.customerModel.password = newValue?.trim();
      },
      onChanged: (value) {
        password1.value = value.trim();
      },
      obscureText: true,
      title: "Şifreniz",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilemez";
        } else if (value!.length <= 6 && value.length > 40) {
          return "Şifreni< 6 ile 40 karakter arasında olmalıdır";
        }
        return null;
      },
    );
  }

  AtomicTextFormField passwordRepeatWidget() {
    return AtomicTextFormField(
      obscureText: true,
      title: "Şifreniz (Tekrar)",
      validator: (value) {
        if (value?.isNotEmpty == true) {
          if (value! != password1.value) {
            return "Şifreler uyuşmuyor!";
          }
        } else {
          return "Boş Geçilemez";
        }
        return null;
      },
    );
  }
}
