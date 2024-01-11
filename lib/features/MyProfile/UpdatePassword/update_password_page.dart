import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/MyProfile/UpdatePassword/update_password_mixin.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage>
    with UpdatePasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              margin: CustomPadding.symmetricInset(20, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  oldPasswordWidget(),
                  SizedBox(height: 10.h),
                  newPasswordWidget(),
                  SizedBox(height: 10.h),
                  repeatNewPasswordWidget(),
                  SizedBox(height: 10.h),
                  saveButton()
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
      centerTitle: true,
      title: textWidget(
          title: "Şifre Değiştir", fontsize: 14.sp, color: Colors.white),
      flexibleSpace: appbarFlexibleSpace(),
      toolbarHeight: 27.h,
      leading: appBarIcon(),
    );
  }

  AtomicTextFormField oldPasswordWidget() {
    return AtomicTextFormField(
      title: "Şifre",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Bırakılamaz";
        }
        return null;
      },
      onSaved: (newValue) {
        oldPassword = newValue!;
      },
    );
  }

  AtomicTextFormField newPasswordWidget() {
    return AtomicTextFormField(
      title: "Yeni Şifre",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Bırakılamaz";
        }

        return null;
      },
      onChanged: (value) {
        newPassword = value;
      },
    );
  }

  AtomicTextFormField repeatNewPasswordWidget() {
    return AtomicTextFormField(
      title: "Yeni Şifre Tekrar",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Bırakılamaz";
        } else if (!value!.contains(newPassword)) {
          return "Şifreler uyuşmuyor";
        }
        return null;
      },
      onSaved: (newValue) {
        repeatNewPassword = newValue!;
      },
    );
  }

  Container saveButton() {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(25),
      child: AtomicOrangeButton(
          onPressed: () async {
            bool isValidate = formKey.currentState!.validate();
            if (isValidate) {
              formKey.currentState!.save();
              updatePassword().then((value) {
                EasyLoading.showToast(value);
                Get.back();
                return value;
              }).onError((error, stackTrace) {
                EasyLoading.showToast(error.toString());
                return error.toString();
              });
            }
          },
          title: "Şifre Değiştir"),
    );
  }
}
