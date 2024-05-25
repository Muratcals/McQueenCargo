part of '../UpdatePassword/update_password_page.dart';

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: GeneralTextWidget(
          title: "Şifre Değiştir", fontsize: 14.sp, color: Colors.white),
      flexibleSpace: const AppbarFlexibleSpace(),
      toolbarHeight: 27.h,
      leading: AppBarIcon(),
    );
  }
}

class _OldPasswordTextField extends StatelessWidget {
  const _OldPasswordTextField({required this.oldPassword});
  final RxString oldPassword;

  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      title: "Şifre",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Bırakılamaz";
        }
        return null;
      },
      onSaved: (newValue) {
        oldPassword.value = newValue!;
      },
    );
  }
}

class _NewPasswordTextField extends StatelessWidget {
  const _NewPasswordTextField({ required this.newPassword});
  final RxString newPassword;
  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      title: "Yeni Şifre",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Bırakılamaz";
        }

        return null;
      },
      onChanged: (value) {
        newPassword.value = value;
      },
    );
  }
}

class _RepeatNewPasswordTextField extends StatelessWidget {
  const _RepeatNewPasswordTextField(
      { required this.newPassword, required this.repeatNewPassword});
  final RxString newPassword;
  final RxString repeatNewPassword;
  @override
  Widget build(BuildContext context) {
    return AtomicTextFormField(
      title: "Yeni Şifre Tekrar",
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Bırakılamaz";
        } else if (!value!.contains(newPassword.value)) {
          return "Şifreler uyuşmuyor";
        }
        return null;
      },
      onSaved: (newValue) {
        repeatNewPassword.value = newValue!;
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton(
      { required this.formKey, required this.onPressed});
  final GlobalKey<FormState> formKey;
  final dynamic Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(25),
      child: AtomicOrangeButton(onPressed: onPressed, title: "Şifre Değiştir"),
    );
  }
}

class UpdatePasswordBody extends StatelessWidget {
  const UpdatePasswordBody(
      {super.key,
      required this.formKey,
      required this.oldPassword,
      required this.newPassword,
      required this.repeatNewPassword,
      required this.onPressedButton});
  final GlobalKey<FormState> formKey;
  final RxString oldPassword;
  final RxString newPassword;
  final RxString repeatNewPassword;
  final Function() onPressedButton;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            margin: CustomPadding.symmetricInset(20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _OldPasswordTextField(
                  oldPassword: oldPassword,
                ),
                SizedBox(height: 10.h),
                _NewPasswordTextField(
                  newPassword: newPassword,
                ),
                SizedBox(height: 10.h),
                _RepeatNewPasswordTextField(
                  newPassword: newPassword,
                  repeatNewPassword: repeatNewPassword,
                ),
                SizedBox(height: 10.h),
                _SaveButton(
                  formKey: formKey,
                  onPressed: () => onPressedButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
