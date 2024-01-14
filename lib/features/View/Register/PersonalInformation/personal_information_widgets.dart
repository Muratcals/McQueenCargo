import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonelInformatinWidgets {
  PersonelInformatinWidgets();
  PartnerController controller = Get.find();

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 30.h,
      leading: appBarIcon(),
      flexibleSpace: appbarFlexibleSpace(),
      centerTitle: true,
      title: textWidget(
          title: "Kişisel Bilgiler", fontsize: 15.sp, color: Colors.white),
    );
  }

  AtomicTextFormField nameWidget() {
    return AtomicTextFormField(
      fontSize: 14.sp,
      onSaved: (newValue) {
        controller.customerModel.name = newValue?.trim();
      },
      title: "Adınız",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş bırakılamaz";
        }
        return null;
      },
    );
  }

  AtomicTextFormField lastNameWidget() {
    return AtomicTextFormField(
      fontSize: 14.sp,
      onSaved: (newValue) {
        controller.customerModel.surname = newValue?.trim();
      },
      title: "Soyadınız",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş bırakılamaz";
        }
        return null;
      },
    );
  }

  Widget tcNumberWidget() {
    return TextFormField(
      maxLength: 11,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: CustomPadding.onlyHorizontalInset(10),
        labelText: "T.C. Kimlik No",
        labelStyle: TextStyle(
            color: Colors.black, fontFamily: "Arial", fontSize: 14.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      onSaved: (newValue) {
        controller.customerModel.tcNo = newValue?.trim();
      },
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilemez";
        } else if (value!.length < 11) {
          return "Lütfen 11 hane olarak giriniz";
        } else {
          return null;
        }
      },
    );
  }

  DateTimeFormField dateTimeWidget(BuildContext context) {
    return DateTimeFormField(
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.input,
      dateFormat: DateFormat("dd.MM.yyyy"),
      use24hFormat: true,
      mode: DateTimeFieldPickerMode.date,
      onDateSelected: (value) {
        FocusScope.of(context).unfocus();
        controller.customerModel.birthDate = value;
      },
      decoration: InputDecoration(
        labelText: "Doğum Tarihi",
        labelStyle: TextStyle(
          fontSize: 14.sp,
        ),
        contentPadding: CustomPadding.onlyHorizontalInset(10),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "Boş Geçilemez";
        }
        return null;
      },
    );
  }
}
