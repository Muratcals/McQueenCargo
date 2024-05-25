part of '../ContactInformation/contact_information_page.dart';

class _ContactInformationBody extends StatelessWidget {
  const _ContactInformationBody({required this.eMail, required this.onPressed, required this.formKey});
  final RxString eMail;
  final GlobalKey<FormState> formKey;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: CustomPadding.onlyHorizontalInset(40),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                _EMailTextField(eMail: eMail),
                SizedBox(height: 15.h),
                _EMailRepeatTextField(
                  eMail: eMail,
                ),
                SizedBox(height: 15.h),
                _PhoneNumberTextField(),
                SizedBox(height: 15.h),
                AtomicOrangeButton(
                    onPressed: () {
                      onPressed();
                    },
                    title: "Devam Et")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 30.h,
      leading: AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      centerTitle: true,
      title: GeneralTextWidget(
          title: "İletişim Bilgileri", fontsize: 15.sp, color: Colors.white),
    );
  }
}

class _EMailRepeatTextField extends StatelessWidget {
  const _EMailRepeatTextField({required this.eMail});
  final RxString eMail;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller) {
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
      },
    );
  }
}

class _EMailTextField extends StatelessWidget {
  const _EMailTextField({required this.eMail});
  final RxString eMail;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _PhoneNumberTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}
