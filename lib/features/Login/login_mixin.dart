import 'package:mc_queen_cargo/features/Login/login_page.dart';
import 'package:mc_queen_cargo/features/Login/login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoginMixin on State<LoginPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  LoginPageWidget widgets = LoginPageWidget();
  String userName = "";
  String password = "";
  RxBool visibilty = false.obs;
  
}
