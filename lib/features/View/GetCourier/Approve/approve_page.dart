import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/Approve/approve_mixin.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_information.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

part '../Approve/approve_widget.dart';

class ApprovePage extends StatefulWidget {
  const ApprovePage({super.key});

  @override
  State<ApprovePage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> with ApproveMixin {
  RxBool visibility = false.obs;
  @override
  Widget build(BuildContext context) {
    return StackProgressWidget(
      visibility: visibility,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          flexibleSpace: const AppbarFlexibleSpace(),
          leading: AppBarIcon(),
          toolbarHeight: 30.h,
          centerTitle: true,
          title: GeneralTextWidget(
              title: title, fontsize: 14.sp, color: Colors.white),
        ),
        body: ApprovePageBody(
          type: type,
          price: price,
          deliveryIndex: deliveryIndex,
          service: service,
          tax: tax,
          sumPrice: sumPrice,
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}

class ApprovePageBody extends StatelessWidget {
  ApprovePageBody(
      {super.key,
      required this.type,
      required this.price,
      required this.deliveryIndex,
      required this.service,
      required this.tax,
      required this.sumPrice,
      required this.onPressed});
  String type;
  double price;
  int deliveryIndex;
  Services service;
  double tax;
  double sumPrice;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
      return AtomicFutureBuilder(
        future: Future.wait([
          service.getCustomerAddress(
              addressId:
                  controller.getCourierModel.value.customerMobilAdressId ?? 0),
          service.getReceiverAddress(
              addressId: controller.getCourierModel.value.receiverId ?? 0)
        ]),
        child: (model) {
          AddressModel customerAddressModel = model[0];
          ReceiverAddressModel receiverAddressModel = model[1];
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: CustomPadding.symmetricInset(15, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CourierInformation(
                      customerAddressModel: customerAddressModel,
                      receiverAddressModel: receiverAddressModel,
                      type: type,
                      transportService: "STANDART"),
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: _ApproveColumnItems(
                        type: type,
                        controller: controller,
                        deliveryIndex: deliveryIndex,
                        price: price,
                        tax: tax,
                        sumPrice: sumPrice),
                  ),
                  SizedBox(height: 10.h),
                  _InformationText(),
                  SizedBox(height: 10.h),
                  _CargoSaveButton(
                    onPressed: () => onPressed(),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
