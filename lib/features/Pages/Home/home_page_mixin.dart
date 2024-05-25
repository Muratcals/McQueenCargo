import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/Pages/Home/home_page.dart';

mixin HomePageMixin on State<HomePage> {
  Services service = Services();
  String trackingNo = "";
}
