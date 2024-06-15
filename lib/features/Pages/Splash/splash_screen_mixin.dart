import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_information.dart';
import 'package:mc_queen_cargo/features/Authorazation/token.dart';

import 'package:mc_queen_cargo/features/Model/authentication_model.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/Services/response_error.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/Splash/splash_screen_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SplashScreenMixin on State<SplashScreen> {
  Services service = Services();

   void serviceException() {
    ErrorResponse.stream.listen((event) {
      ErrorResponse.responseErrorDialog(context, event);
    });
  }

  Future<AuthenticationModel> getUser() async => await service.loginAuth();
  
  Future<void> getCustomerId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int customerId = sharedPreferences.getInt("userId") ?? 0;
    Auth.authId = customerId;
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
    AuthenticationToken.token = accessToken;
    return authenticationModelToJson(AuthenticationModel(
        accessToken: accessToken, refreshToken: refreshToken));
  }

  Future<void> deleteCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userId", 0);
    Auth.authId = 0;
  }

  Future<void> refreshTokenProcess() async {
    String oldToken = await getToken();
    await service.refreshToken(oldToken).then((value) {
      saveToken(
          accessToken: value.accessToken!, refreshToken: value.refreshToken!);
      AuthenticationToken.token = value.accessToken!;
      loginModelProcess(value.accessToken!);
    }).onError((error, stackTrace) {
      return Future.error(error.toString());
    });
  }

  void loginModelProcess(String accessToken) async {
    await getCustomerId();
    int userId = Auth.authId;
    if (userId == 0) {
      AuthInformation.auth = LoginModel();
      Get.offAllNamed("/main");
    } else {
      await service.getCustomerInformation(userId).then((value) {
        AuthInformation.auth = value;
        Get.offAllNamed("/main");
      });
    }
  }
}
