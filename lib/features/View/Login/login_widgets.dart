import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class LoginPageWidget {
  String userName = "";
  String password = "";
  Services service = Services();
  PartnerController controller = Get.find();
  Text loginTextWidget(
          {required String title,
          Color color = Colors.white,
          FontWeight fontWeight = FontWeight.normal,
          required double fontSize}) =>
      Text(
        title,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      );

  Container notAccountWidget() {
    return Container(
      margin: CustomPadding.onlyVerticalInset(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loginTextWidget(
              title: "Üye Değil misiniz?",
              color: Colors.grey.shade600,
              fontSize: 13.sp),
          SizedBox(
            width: 3.w,
          ),
          InkWell(
            onTap: () {
              Get.toNamed("/registerPage", arguments: "entry");
            },
            child: loginTextWidget(
                title: "Üye Olun",
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 13.sp),
          )
        ],
      ),
    );
  }

  AtomicOrangeButton loginButton(
      GlobalKey<FormState> key, Function(bool visibilty) onPressed) {
    return AtomicOrangeButton(
      onPressed: () async {
        onPressed(true);
        bool isValidate = key.currentState!.validate();
        if (isValidate) {
          key.currentState!.save();
          Map<String, String> model = {
            "userName": userName,
            "password": password
          };
          await service
              .login(model, controller.accessToken.value,"Login")
              .then((value) async {
            await saveDatabase(value.id!);
            EasyLoading.showToast("Giriş başarılı");
            controller.currentAuth.value = value.id!;
            Get.offAllNamed("/main", arguments: {"userId": value.id});
          }).onError((error, stackTrace) {});
        }
        onPressed(false);
      },
      title: "Giriş Yap",
    );
  }

  Future<void> saveDatabase(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("userId", userId);
  }

  Align resetPasswordWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: loginTextWidget(
          title: "Şifremi unuttum",
          color: Colors.grey.shade600,
          fontSize: 14.sp),
    );
  }

  AtomicTextFormField passwordWidget() {
    return AtomicTextFormField(
      onSaved: (newValue) {
        password = newValue!.trim();
      },
      obscureText: true,
      title: "Şifre",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Bu alan Boş geçilemez";
        } else if (value!.length <= 6 && value.length > 40) {
          return "Şifreni< 6 ile 40 karakter arasında olmalıdır";
        } else {
          return null;
        }
      },
    );
  }

  AtomicTextFormField ePostaWidget() {
    return AtomicTextFormField(
      onSaved: (newValue) {
        userName = newValue!.trim();
      },
      title: "E-Posta / T.C Kimlik",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Bu alan Boş geçilemez";
        }
        return null;
      },
    );
  }

  AppBar loginAppBar() {
    return AppBar(
      backgroundColor: Colors.blue.shade700,
      flexibleSpace: appbarFlexibleSpace(),
      leading: appBarIcon(),
      centerTitle: true,
      title: loginTextWidget(
          title: "Giriş Yap", fontSize: 16.sp, fontWeight: FontWeight.bold),
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 30.h),
        child: Container(
          padding: CustomPadding.symmetricInset(30, 10),
          child: loginTextWidget(
              title:
                  "E-Posta veya T.C Kimlik numaranız veya GSM numaranız ile  giriş yapabilirsiniz,",
              fontSize: 13.sp),
        ),
      ),
    );
  }
}
