import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/Pages/Login/login_page.dart';

mixin LoginMixin on State<LoginPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool visibilty = false.obs;
  Services service = Services();
}
