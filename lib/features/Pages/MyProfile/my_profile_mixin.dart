import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_information.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/my_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin MyProfileMixin on State<MyProfilePage> {
  Services service = Services();

  Future<void> deleteCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("userId", 0);
    Auth.authId = 0;
    AuthInformation.auth = LoginModel();
  }
}
