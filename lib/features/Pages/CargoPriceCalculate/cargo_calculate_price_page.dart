import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/Bloc/calculate_price_customer_address.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/Bloc/calculate_price_receiver_address.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CargoPricaCalculatePage extends StatefulWidget {
  const CargoPricaCalculatePage({super.key});

  @override
  State<CargoPricaCalculatePage> createState() =>
      _CargoPricaCalculatePageState();
}

class _CargoPricaCalculatePageState extends State<CargoPricaCalculatePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: CustomPadding.only(top: 50),
          color: Colors.grey.shade100,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => CalculatePriceCustomerAddressBloc()),
              BlocProvider(
                  create: (context) => CalculatePriceReceiverAddressBloc()),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SelectedCustomerAddressContainer(),
                SizedBox(height: 10.h),
                _SelectedRecevierAddressContainer(),
                _NextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedCustomerAddressContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatePriceCustomerAddressBloc, AddressModel?>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          width: 190.w,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: CustomPadding.onlyVerticalInset(10),
                child: _CheckImageWidget(
                    iconData: "images/future_location_icon.png",
                    state: state == null ? false : true),
              ),
              Divider(color: Colors.grey, height: 1.h),
              InkWell(
                onTap: () async {
                  var result = await Get.toNamed("/addressPage", arguments: {
                    "incoming": "customer",
                    "process": "getCourier"
                  });
                  if (result != null) {
                    context
                        .read<CalculatePriceCustomerAddressBloc>()
                        .changeAddress(result);
                  }
                },
                child: Container(
                  margin: CustomPadding.symmetricInset(10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GeneralTextWidget(
                          title: state == null
                              ? "Nereden?"
                              : "${state.districtName}/${state.provinceName}",
                          fontsize: 14.sp),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _SelectedRecevierAddressContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatePriceReceiverAddressBloc,
        ReceiverAddressModel?>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          width: 190.w,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: CustomPadding.onlyVerticalInset(10),
                child: _CheckImageWidget(
                    iconData: "images/is_will_location_icon.png",
                    state: state == null ? false : true),
              ),
              Divider(color: Colors.grey, height: 1.h),
              InkWell(
                onTap: () async {
                  var result = await Get.toNamed("/addressPage", arguments: {
                    "incoming": "receiver",
                    "process": "getCourier"
                  });
                  if (result != null) {
                    context
                        .read<CalculatePriceReceiverAddressBloc>()
                        .changeAddress(result);
                  }
                },
                child: Container(
                  margin: CustomPadding.symmetricInset(10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GeneralTextWidget(
                          title: state == null
                              ? "Nereye?"
                              : "${state.districtName}/${state.provinceName}",
                          fontsize: 14.sp),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CheckImageWidget extends StatelessWidget {
  const _CheckImageWidget({
    required this.iconData,
    required this.state,
  });

  final String iconData;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: Image.asset(iconData)),
        Align(
          alignment: Alignment.topRight,
          child: state
              ? SizedBox(
                  width: 15.w,
                  height: 15.h,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 10.r,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatePriceCustomerAddressBloc, AddressModel?>(
      builder: (context, customerAddress) {
        return BlocBuilder<CalculatePriceReceiverAddressBloc,
            ReceiverAddressModel?>(
          builder: (context, receiverAddress) {
            return Container(
              margin: CustomPadding.symmetricInset(50, 25),
              child: customerAddress != null && receiverAddress != null
                  ? AtomicOrangeButton(
                      onPressed: () {
                        Get.toNamed("/shipmentType");
                      },
                      title: "Devam Et")
                  : Container(),
            );
          },
        );
      },
    );
  }
}
