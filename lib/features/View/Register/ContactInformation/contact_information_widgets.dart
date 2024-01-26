import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactInformationPageWidgets {
  PartnerController controller = Get.find();
  RxString eMail = "".obs;
  AppBar appBar() {
    return AppBar(
      toolbarHeight: 30.h,
      leading: appBarIcon(),
      flexibleSpace: appbarFlexibleSpace(),
      centerTitle: true,
      title: textWidget(
        title:"İletişim Bilgileri",
         fontsize: 15.sp,
         color: Colors.white
      ),
    );
  }

  AtomicTextFormField eMailRepeatWidget() {
    return AtomicTextFormField(
      onSaved: (newValue) {
        controller.customerModel.email = newValue?.trim();
      },
      title: "E-Posta Adresiniz (Tekrar)",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilemez";
        } else {
          if (value?.trim() != eMail.value.trim()) {
            return "E-Posta adresiniz aynı değil!";
          }
        }
        return null;
      },
    );
  }

  AtomicTextFormField eMailWidget() {
    return AtomicTextFormField(
      onSaved: (newValue) {},
      title: "E-posta Adresiniz",
      validator: (value) {
        if (value?.isNotEmpty == true) {
          if (!value!.contains("@") || !value.contains(".com")) {
            return "Lütfen e-posta biçimde giriniz";
          }
        } else {
          return "Boş Geçilemez";
        }
        return null;
      },
      onChanged: (value) {
        eMail.value = value.trim();
      },
    );
  }

  TextFormField phoneNumberWidget() {
    return TextFormField(
      onSaved: (newValue) {
        controller.customerModel.numberPhone = newValue?.trim();
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: CustomPadding.onlyHorizontalInset(10),
        labelText: "Telefon Numaranız",
        labelStyle: TextStyle(
            color: Colors.black, fontFamily: "Arial", fontSize: 14.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      maxLength: 11,
      validator: (value) {
        if (value?.isNotEmpty == true) {
          if (value!.length < 11) {
            return "Lütfen 11 haneli bir telefon numarası giriniz";
          }
        } else {
          return "Boş Geçilemez";
        }
        return null;
      },
    );
  }
}
