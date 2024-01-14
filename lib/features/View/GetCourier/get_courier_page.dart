import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_mixin.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_widgets.dart';
import 'package:flutter/material.dart';

class GetCourierPage extends StatefulWidget {
  const GetCourierPage({super.key});

  @override
  State<GetCourierPage> createState() => _GetCourierPageState();
}

class _GetCourierPageState extends State<GetCourierPage> with GetCourierMixin {
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: GetCourierWidegets(),
    );
  }
}
