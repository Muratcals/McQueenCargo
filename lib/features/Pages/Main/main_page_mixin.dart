// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/Pages/Main/main_page.dart';

mixin MainMixin on State<MainPage> {
  Services service = Services();
}
