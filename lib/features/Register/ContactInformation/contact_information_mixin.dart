import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Register/ContactInformation/contact_information_page.dart';
import 'package:mc_queen_cargo/features/Register/ContactInformation/contact_information_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ContactInformationPageMixin on State<ContactInformationPage> {
  PartnerController controller = Get.find();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  ContactInformationPageWidgets widgets = ContactInformationPageWidgets();
}
