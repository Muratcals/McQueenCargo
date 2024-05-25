import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/Approve/approve_mixin.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/get_courier_information.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Constants/GetCourierCubit/post_courier_cubit.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
part 'approve_widget.dart';

class ApprovePage extends StatefulWidget {
  const ApprovePage({super.key});

  @override
  State<ApprovePage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> {
  RxBool visibility = false.obs;
  @override
  Widget build(BuildContext context) {
    return StackProgressWidget(
      visibility: visibility,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          flexibleSpace: const AppbarFlexibleSpace(),
          leading: const AppBarIcon(),
          toolbarHeight: 30.h,
          centerTitle: true,
          title: GeneralTextWidget(
              title: "Onayla", fontsize: 14.sp, color: Colors.white),
        ),
        body: const ApprovePageBody(),
      ),
    );
  }
}

class ApprovePageBody extends StatefulWidget {
  const ApprovePageBody({super.key});

  @override
  State<ApprovePageBody> createState() => _ApprovePageBodyState();
}

class _ApprovePageBodyState extends State<ApprovePageBody> with ApproveMixin {
  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
      future: Future.wait([
        service.getCustomerAddress(
            addressId: context
                    .read<GetCourierPostCubit>()
                    .state
                    .customerMobilAdressId ??
                0),
        service.getReceiverAddress(
            addressId:
                context.read<GetCourierPostCubit>().state.receiverId ?? 0)
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
      onError: () => setState(() {}),
    );
  }
}
