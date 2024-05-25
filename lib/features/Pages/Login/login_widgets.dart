part of 'login_page.dart';

class _LoginTextWidget extends StatelessWidget {
  const _LoginTextWidget({
    required this.title,
    required this.fontSize,
    this.color,
    this.fontWeight,
  });
  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

class _NotAccountWidget extends StatelessWidget {
  const _NotAccountWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.onlyVerticalInset(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LoginTextWidget(
              title: "Üye Değil misiniz?",
              color: Colors.grey.shade600,
              fontSize: 13.sp),
          SizedBox(
            width: 3.w,
          ),
          InkWell(
            onTap: () {
              Get.toNamed("/registerPage", arguments: "entry");
            },
            child: _LoginTextWidget(
                title: "Üye Olun",
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 13.sp),
          )
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton(
      {required this.globalKey,
      required this.onPressed,
      required this.service});
  final GlobalKey<FormState> globalKey;
  final Function(bool visibilty) onPressed;
  final Services service;

  Future<void> saveDatabase(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("userId", userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AtomicOrangeButton(
          onPressed: () async {
            onPressed(true);
            bool isValidate = globalKey.currentState!.validate();
            if (isValidate) {
              globalKey.currentState!.save();
              Map<String, String> model = {
                "userName": state.userName,
                "password": state.password
              };
              await service.login(model, "Login").then((value) async {
                await saveDatabase(value.id!);
                EasyLoading.showToast("Giriş başarılı");
                Auth.authId = value.id!;
                Get.offAllNamed("/main", arguments: {"userId": value.id});
              }).onError((error, stackTrace) {});
            }
            onPressed(false);
          },
          title: "Giriş Yap",
        );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: _LoginTextWidget(
          title: "Şifremi unuttum",
          color: Colors.grey.shade600,
          fontSize: 14.sp),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      onSaved: (newValue) {
        context.read<LoginCubit>().changeState(password: newValue!.trim());
      },
      obscureText: true,
      title: "Şifre",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Bu alan Boş geçilemez";
        } else if (value!.length <= 6 && value.length > 40) {
          return "Şifreni< 6 ile 40 karakter arasında olmalıdır";
        } else {
          return null;
        }
      },
    );
  }
}

class _EPostaTextField extends StatelessWidget {
  const _EPostaTextField();

  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      onSaved: (newValue) {
        context.read<LoginCubit>().changeState(userName: newValue!.trim());
      },
      title: "E-Posta / T.C Kimlik",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Bu alan Boş geçilemez";
        }
        return null;
      },
    );
  }
}

class _LoginAppBar extends StatelessWidget {
  const _LoginAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade700,
      flexibleSpace: const AppbarFlexibleSpace(),
      leading: const AppBarIcon(),
      centerTitle: true,
      title: _LoginTextWidget(
          title: "Giriş Yap", fontSize: 16.sp, fontWeight: FontWeight.bold),
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 30.h),
        child: Container(
          padding: CustomPadding.symmetricInset(30, 10),
          child: _LoginTextWidget(
              title:
                  "E-Posta veya T.C Kimlik numaranız veya GSM numaranız ile  giriş yapabilirsiniz,",
              fontSize: 13.sp),
        ),
      ),
    );
  }
}
