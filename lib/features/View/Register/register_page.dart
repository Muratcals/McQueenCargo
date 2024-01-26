import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/Register/register_mixin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: widgets.registerAppBar(),
          body: StackProgressWidget(
            visibility: visibilty,
            child: Container(
              margin: CustomPadding.onlyHorizontalInset(50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widgets.registerPageColumnItems(
                      "1", "Kişisel Bilgiler", incoming),
                  SizedBox(height: 20.h),
                  widgets.registerPageColumnItems("2", "E-Posta", incoming),
                  SizedBox(height: 20.h),
                  widgets.registerPageColumnItems(
                      "3", "Cep Telefonu", incoming),
                  SizedBox(height: 20.h),
                  AtomicOrangeButton(
                      onPressed: () async {
                        await buttonProcess();
                      },
                      title: incoming.contains("entry")
                          ? "Başla"
                          : "Üyeliği İşlemini Tamamla")
                ],
              ),
            ),
          )),
    );
  }

  Future<void> buttonProcess() async {
    if (incoming.contains("entry")) {
      Get.toNamed("/personalInformationPage");
    } else {
      visibilty.value = true;
      await service
          .createCustomer(
              controller.customerModel, controller.accessToken.value)
          .then((value) {
        Get.offAllNamed("/loginPage");
      }).onError((error, stackTrace) {});
      visibilty.value = false;
    }
  }
}
