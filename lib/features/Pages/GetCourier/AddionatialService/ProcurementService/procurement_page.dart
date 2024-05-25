import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/AddionatialService/ProcurementService/Cubit/procurement_cubit.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/AddionatialService/ProcurementService/Cubit/procurement_state.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProcumentService extends StatefulWidget {
  const ProcumentService({
    super.key,
    required this.onPressed,
    required this.type,
  });
  final Function(double updatePrice, int index) onPressed;
  final String type;

  @override
  State<ProcumentService> createState() => _ProcumentServiceState();
}

class _ProcumentServiceState extends State<ProcumentService> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProcurementCubit(),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<ProcurementCubit, ProcurementState>(
          builder: (context, state) {
            return Row(
              children: [
                for (int i = 0;
                    i <
                        AdditionalServicePrice
                            .packageProcurementServices.length;
                    i++)
                  widget.type.contains("KOLİ - PAKET")
                      ? ProcurementServiceRowItems(
                          widget: widget,
                          model:
                              AdditionalServicePrice.packageDeliveryServices[i],
                          index: i)
                      : DeliveryServiceRowItems(
                          widget: widget,
                          model: AdditionalServicePrice.fileDeliveryServices[i],
                          index: i)
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProcurementServiceRowItems extends StatelessWidget {
  const ProcurementServiceRowItems({
    super.key,
    required this.widget,
    required this.model,
    required this.index,
  });

  final ProcumentService widget;
  final AdditionalServiceModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.sizeOf(context).width / 2) - 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.white),
      margin: CustomPadding.only(top: 5, bottom: 5, right: 15),
      padding: CustomPadding.only(top: 5),
      child:
          ProcurementServicesWidget(widget: widget, model: model, index: index),
    );
  }
}

class ProcurementServicesWidget extends StatelessWidget {
  const ProcurementServicesWidget({
    super.key,
    required this.widget,
    required this.model,
    required this.index,
  });

  final ProcumentService widget;
  final AdditionalServiceModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                model.icon,
                color: Colors.orange,
                size: 25.r,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralTextWidget(
                    title: model.name, fontsize: 13.sp, color: Colors.grey),
                GeneralTextWidget(
                    title: model.price.toString(),
                    fontsize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)
              ],
            )
          ],
        ),
        SizedBox(height: 3.h),
        Divider(color: Colors.grey, height: 1.h),
        BlocBuilder<ProcurementCubit, ProcurementState>(
          builder: (context, state) {
            return ProcurementSelectedButtonController(
              widget: widget,
              index: index,
              state: state,
            );
          },
        ),
      ],
    );
  }
}

class ProcurementSelectedButtonController extends StatelessWidget {
  const ProcurementSelectedButtonController({
    super.key,
    required this.widget,
    required this.index,
    required this.state,
  });

  final ProcumentService widget;
  final int index;
  final ProcurementState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var price =
            AdditionalServicePrice.packageProcurementServices[index].price -
                AdditionalServicePrice
                    .packageProcurementServices[state.selectedProcurement]
                    .price;
        widget.onPressed(price, index);
        context.read<ProcurementCubit>().changeSelectedProcurement(index);
      },
      child: Container(
        color: state.selectedProcurement != index ? Colors.white : Colors.green,
        padding: CustomPadding.onlyVerticalInset(3),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: state.selectedProcurement != index ? "+" : "✓",
            fontsize: 14.sp,
            color: state.selectedProcurement != index
                ? Colors.black
                : Colors.white),
      ),
    );
  }
}

class DeliveryServiceRowItems extends StatelessWidget {
  const DeliveryServiceRowItems({
    super.key,
    required this.widget,
    required this.model,
    required this.index,
  });

  final ProcumentService widget;
  final AdditionalServiceModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.sizeOf(context).width / 2) - 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.white),
      margin: CustomPadding.only(top: 5, bottom: 5, right: 15),
      padding: CustomPadding.only(top: 5),
      child: DeliveryServicesWidget(widget: widget, model: model, index: index),
    );
  }
}

class DeliveryServicesWidget extends StatelessWidget {
  const DeliveryServicesWidget({
    super.key,
    required this.widget,
    required this.model,
    required this.index,
  });

  final ProcumentService widget;
  final AdditionalServiceModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                model.icon,
                color: Colors.orange,
                size: 25.r,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralTextWidget(
                    title: model.name, fontsize: 13.sp, color: Colors.grey),
                GeneralTextWidget(
                    title: model.price.toString(),
                    fontsize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)
              ],
            )
          ],
        ),
        SizedBox(height: 3.h),
        Divider(color: Colors.grey, height: 1.h),
        BlocBuilder<ProcurementCubit, ProcurementState>(
          builder: (context, state) {
            return DeliverySelectedButtonController(
              widget: widget,
              index: index,
              state: state,
            );
          },
        ),
      ],
    );
  }
}

class DeliverySelectedButtonController extends StatelessWidget {
  const DeliverySelectedButtonController({
    super.key,
    required this.widget,
    required this.index,
    required this.state,
  });

  final ProcumentService widget;
  final int index;
  final ProcurementState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        double deliveryPrice =
            AdditionalServicePrice.fileDeliveryServices[index].price -
                AdditionalServicePrice
                    .fileDeliveryServices[state.selectedDelivery].price;
        widget.onPressed(deliveryPrice, index);
        context.read<ProcurementCubit>().changeSelectedDelivery(index);
      },
      child: Container(
        color: state.selectedDelivery != index ? Colors.white : Colors.green,
        padding: CustomPadding.onlyVerticalInset(3),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: state.selectedDelivery != index ? "+" : "✓",
            fontsize: 14.sp,
            color:
                state.selectedDelivery != index ? Colors.black : Colors.white),
      ),
    );
  }
}
