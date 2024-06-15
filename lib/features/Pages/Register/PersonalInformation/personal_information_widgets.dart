

part of 'personal_information_page.dart';
class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 30.h,
      leading: 
    const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      centerTitle: true,
      title: GeneralTextWidget(
          title: "Kişisel Bilgiler", fontsize: 15.sp, color: Colors.white),
    );
  }
}

class _NameTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      fontSize: 14.sp,
      onSaved: (newValue) {
        context.read<CreteCustomerState>().changeValue(name: newValue?.trim() ?? "") ;
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
}

class _LastNameTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      fontSize: 14.sp,
      onSaved: (newValue) {
        context.read<CreteCustomerState>().changeValue(surname:  newValue?.trim() ?? "") ;
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
}

class _TcNumberTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
        context.read<CreteCustomerState>().changeValue(tcNo:  newValue?.trim() ?? "") ;
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
}

class _DateTimeField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.input,
      dateFormat: DateFormat("dd.MM.yyyy"),
      use24hFormat: true,
      mode: DateTimeFieldPickerMode.date,
      onDateSelected: (value) {
        FocusScope.of(context).unfocus();
        context.read<CreteCustomerState>().changeValue(birthDate:  value);
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
