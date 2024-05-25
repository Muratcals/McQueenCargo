part of '../MyProfile/my_profile_page.dart';

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (Get.height * 15) / 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.blue.shade700
          ],
        ),
      ),
      child: GetBuilder<PartnerController>(builder: (controller) {
        return GeneralTextWidget(
            title:
                "HOŞGELDİN ${controller.userInformation.value.name?.toUpperCase()}",
            fontsize: 18.sp,
            color: Colors.white);
      }),
    );
  }
}

class _DeleteUserButton extends StatelessWidget {
  const _DeleteUserButton({required this.service});
  final Services service;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
      return InkWell(
        onTap: () async {
          await service
              .deleteCustomer()
              .then((value) {
            EasyLoading.showToast(value);
            deleteCustomer(controller: controller);
            Get.offAll("/main", arguments: {"userId": 0});
          }).onError(
            (error, stackTrace) {
              EasyLoading.showToast(error.toString());
            },
          );
        },
        child: Container(
          width: double.infinity,
          height: (Get.height * 7) / 100,
          padding: CustomPadding.allInset(10.r),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100),
          child: GeneralTextWidget(
              title: "Hesabımı Sil", fontsize: 15.sp, color: Colors.red),
        ),
      );
    });
  }
}

class _SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
      return InkWell(
        onTap: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setInt("userId", 0);
          Auth.authId = 0;
          controller.userInformation.value = LoginModel();
          controller.selectedBottomSheet.value = "main";
          EasyLoading.showToast("Başarıyla çıkış yapıldı");
          Get.offAndToNamed("/main", arguments: {"userId": 0});
        },
        child: Container(
          width: double.infinity,
          height: (Get.height * 7) / 100,
          padding: CustomPadding.allInset(10.r),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GeneralTextWidget(
                  title: "Çıkış Yap", fontsize: 15.sp, color: Colors.grey),
              const Icon(
                Icons.output,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _MyProfileProperties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r), color: Colors.white),
      child: const Column(
        children: [
          _ColumnItems(
              title: "Kişisel Bilgilerim", onPressed: "updatePersonal"),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          _ColumnItems(
              title: "Gönderici Adresleri", onPressed: "customerAddress"),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          _ColumnItems(title: "Alıcı Adresleri", onPressed: "receiverAddress"),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          _ColumnItems(title: "Şifre Değiştir", onPressed: "updatePassword"),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          _ColumnItems(title: "Gönderilerim", onPressed: "myCargos"),
        ],
      ),
    );
  }
}

class _ColumnItems extends StatelessWidget {
  const _ColumnItems({
    required this.title,
    required this.onPressed,
  });
  final String title;
  final String onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller) {
        return InkWell(
          onTap: () {
            clickController(onPressed,controller);
          },
          child: ListTile(
            contentPadding: CustomPadding.onlyHorizontalInset(10),
            title: GeneralTextWidget(
                title: title,
                fontsize: 14.sp,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      }
    );
  }
}

class _MyProfileColumnItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Container(
            margin: CustomPadding.onlyHorizontalInset(10),
            child: GeneralTextWidget(
                title: "SEÇENEKLER",
                fontsize: 15.sp,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          _MyProfileProperties(),
          SizedBox(height: 10.h),
          _DeleteUserButton(service: Services(),),
          SizedBox(height: 10.h),
          _SignOutButton()
        ],
      ),
    );
  }
}

void clickController(String title,PartnerController controller) {
  if (title.contains("updatePersonal")) {
    Get.toNamed(title);
  } else if (title.contains("customerAddress")) {
    Get.toNamed("/addressPage",
        arguments: {"incoming": "customer", "process": "information"});
  } else if (title.contains("receiverAddress")) {
    Get.toNamed("/addressPage",
        arguments: {"incoming": "receiver", "process": "information"});
  } else if (title.contains("updatePassword")) {
    Get.toNamed(title);
  } else {
    controller.selectedBottomSheet.value = "myCargos";
  }
}

Future<void> deleteCustomer({required PartnerController controller}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt("userId", 0);
  Auth.authId = 0;
  controller.userInformation.value = LoginModel();
}
