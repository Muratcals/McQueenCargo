part of 'password_page.dart';

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 30.h,
      leading: const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      centerTitle: true,
      title: GeneralTextWidget(
          title: "Şifre İşlemleri", fontsize: 15.sp, color: Colors.white),
    );
    
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({required this.password1});
  final RxString password1;
  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      onSaved: (newValue) {
        context.read<CreteCustomerState>().changeValue( password:  newValue?.trim() ?? "");
      },
      onChanged: (value) {
        password1.value = value.trim();
      },
      obscureText: true,
      title: "Şifreniz",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilemez";
        } else if (value!.length <= 6) {
          return "Şifreniz 6 ile 40 karakter arasında olmalıdır";
        }
        return null;
      },
    );
  }
}

class _PasswordRepeatTextField extends StatelessWidget {
  const _PasswordRepeatTextField({required this.password1});
  final RxString password1;
  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      obscureText: true,
      title: "Şifreniz (Tekrar)",
      validator: (value) {
        if (value?.isNotEmpty == true) {
          if (value! != password1.value) {
            return "Şifreler uyuşmuyor!";
          }
        } else if (value!.length <= 6) {
          return "Şifreniz 6 ile 40 karakter arasında olmalıdır";
        } else {
          return "Boş Geçilemez";
        }
        return null;
      },
    );
  }
}
