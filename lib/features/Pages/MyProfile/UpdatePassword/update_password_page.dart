import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/UpdatePassword/update_password_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

part 'update_personal_widget.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage>
    with UpdatePasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar()),
      body: UpdatePasswordBody(
        formKey: formKey,
        newPassword: newPassword,
        oldPassword: oldPassword,
        onPressedButton: () => onPressedButton(),
        repeatNewPassword: repeatNewPassword,
      ),
    );
  }
}
