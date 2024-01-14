import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/ReceiverAddress/address_detail_mixin.dart';

class ReceiverAddressInformationPage extends StatefulWidget {
  const ReceiverAddressInformationPage({super.key});

  @override
  State<ReceiverAddressInformationPage> createState() =>
      _ReceiverAddressInformationPageState();
}

class _ReceiverAddressInformationPageState
    extends State<ReceiverAddressInformationPage>
    with ReceiverAddressInformationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: widgets.appBar(),
        body: AtomicFutureBuilder(
          future: getAddress(),
          child: (getModel) {
            ReceiverAddressModel model = getModel;
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: CustomPadding.symmetricInset(15, 10),
                    padding: CustomPadding.allInset(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widgets.columnTitle(model),
                        widgets.receiverAddressInformation(model),
                      ],
                    ),
                  ),
                  deleteAddressButton()
                ],
              ),
            );
          },
        ));
  }

  Container deleteAddressButton() {
    return Container(
        margin: CustomPadding.onlyHorizontalInset(50),
        child: AtomicOrangeButton(
            onPressed: () async {
              await deleteAddress().then((value) {
                EasyLoading.showToast(value);
                Get.back(result: 1);
              }).onError((error, stackTrace) {
                EasyLoading.showToast(error.toString());
              });
            },
            title: "Adresi Sil"));
  }
}
