import 'package:mc_queen_cargo/features/Authorazation/auth_information.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'update_personal_widget.dart';

class UpdatePersonalPage extends StatefulWidget {
  const UpdatePersonalPage({super.key});

  @override
  State<UpdatePersonalPage> createState() => _UpdatePersonalPageState();
}

class _UpdatePersonalPageState extends State<UpdatePersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar()),
      body: _UpdatePersonalBodyItem()
    );
  }
}
