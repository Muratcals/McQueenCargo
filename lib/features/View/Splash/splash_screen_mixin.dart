import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/authentication_model.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Splash/splash_screen_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SplashScreenMixin on State<SplashScreen> {
  PartnerController controller = Get.find();
  Services service = Services();

  void getUser() async => service.loginAuth().then((value) async {
        saveToken(
            accessToken: value.accessToken!, refreshToken: value.refreshToken!);
        controller.accessToken.value = value.accessToken!;
        loginModelProcess(value.accessToken!);
      }).onError((error, stackTrace) async {});

  Future<void> getCustomerId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int customerId = sharedPreferences.getInt("userId") ?? 0;
    controller.currentAuth.value = customerId;
  }

  Future<void> saveToken(
      {required String accessToken, required String refreshToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", accessToken);
    sharedPreferences.setString("refreshToken", refreshToken);
  }

  Future<void> deleteToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", "");
    sharedPreferences.setString("refreshToken", "");
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken") ?? "";
    String refreshToken = sharedPreferences.getString("refreshToken") ?? "";
    controller.accessToken.value = accessToken;
    return authenticationModelToJson(AuthenticationModel(
        accessToken: accessToken, refreshToken: refreshToken));
  }

  Future<void> deleteCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userId", 0);
    controller.currentAuth.value = 0;
  }

  Future<void> refreshTokenProcess() async {
    String oldToken = await getToken();
    await service.refreshToken(oldToken).then((value) {
      saveToken(
          accessToken: value.accessToken!, refreshToken: value.refreshToken!);
      controller.accessToken.value = value.accessToken!;
      loginModelProcess(value.accessToken!);
    }).onError((error, stackTrace) {
      return Future.error(error.toString());
    });
  }

  void loginModelProcess(String accessToken) async {
    await getCustomerId();
    int userId = controller.currentAuth.value;
    if (userId == 0) {
      controller.userInformation.value = LoginModel();
      Get.offAllNamed("/main", arguments: {"userId": 0});
    } else {
      await service.getCustomerInformation(userId, accessToken).then((value) {
        controller.userInformation.value = value;
        Get.offAllNamed("/main", arguments: {"userId": 0});
      }).onError((error, stackTrace) {
        if (error == ("Not Found")) {
          deleteCustomer();
          controller.userInformation.value = LoginModel();
          Get.offAllNamed("/main", arguments: {"userId": 0});
        } else {
          refreshTokenProcess();
        }
      });
    }
  }
}
