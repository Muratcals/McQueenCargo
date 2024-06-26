import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/Register/ContactInformation/contact_information_mixin.dart';
import 'package:mc_queen_cargo/features/Pages/Register/Controller/create_customer_cubit.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part 'contact_information_widgets.dart';

class ContactInformationPage extends StatefulWidget {
  const ContactInformationPage({super.key});

  @override
  State<ContactInformationPage> createState() => _ContactInformationPageState();
}

class _ContactInformationPageState extends State<ContactInformationPage>
    with ContactInformationPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:
            PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar()),
        body: _ContactInformationBody(
          formKey: key,
          eMail: eMail,
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}
