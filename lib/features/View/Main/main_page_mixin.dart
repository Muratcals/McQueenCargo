// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page.dart';

mixin MainMixin on State<MainPage> {
  Services service = Services();
  int userId = Get.arguments["userId"];
}
