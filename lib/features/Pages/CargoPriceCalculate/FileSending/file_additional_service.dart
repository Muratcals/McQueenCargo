import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/additional_service_cubit.dart';

class FileAdditionalService extends StatefulWidget {
  const FileAdditionalService(
      {super.key,
      required this.selectedProcurement,
      required this.selecteddelivery});

  final Function(double procurementPrice) selectedProcurement;
  final Function(double deliveryPrice) selecteddelivery;

  @override
  State<FileAdditionalService> createState() => _FileAdditionalServiceState();
}

class _FileAdditionalServiceState extends State<FileAdditionalService> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdditionalServiceCubit(),
      child: Container(
        margin: CustomPadding.onlyHorizontalInset(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            GeneralTextWidget(title: "Alım Hizmetleri", fontsize: 16.sp),
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0;
                      i < AdditionalServicePrice.fileProcurementServices.length;
                      i++)
                    ProcurementServiceRowItems(
                        widget: widget,
                        model:
                            AdditionalServicePrice.fileProcurementServices[i],
                        index: i)
                ],
              ),
            ),
            SizedBox(height: 5.h),
            GeneralTextWidget(title: "Teslimat Hizmetleri", fontsize: 16.sp),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              child: Row(
                children: [
                  for (int i = 0;
                      i < AdditionalServicePrice.fileDeliveryServices.length;
                      i++)
                    DeliveryServiceRowItems(
                        widget: widget,
                        model: AdditionalServicePrice.fileDeliveryServices[i],
                        index: i)
                ],
              ),
            ),
          ],
        ),
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

  final FileAdditionalService widget;
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

class ProcurementServiceRowItems extends StatelessWidget {
  const ProcurementServiceRowItems({
    super.key,
    required this.widget,
    required this.model,
    required this.index,
  });

  final FileAdditionalService widget;
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

  final FileAdditionalService widget;
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
        ProcurementSelectedButtonController(widget: widget, index: index),
      ],
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

  final FileAdditionalService widget;
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
        DeliverySelectedButtonController(widget: widget, index: index),
      ],
    );
  }
}

class ProcurementSelectedButtonController extends StatelessWidget {
  const ProcurementSelectedButtonController({
    super.key,
    required this.widget,
    required this.index,
  });

  final FileAdditionalService widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalServiceCubit, AdditionalServiceState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            double procurementPrice =
                AdditionalServicePrice.fileProcurementServices[index].price -
                    AdditionalServicePrice
                        .fileProcurementServices[state.selectedProcurement]
                        .price;
            widget.selectedProcurement(procurementPrice);
            context.read<AdditionalServiceCubit>().changes(index);
          },
          child: Container(
            color: state.selectedProcurement != index
                ? Colors.white
                : Colors.green,
            padding: EdgeInsets.symmetric(vertical: 3.h),
            alignment: Alignment.center,
            child: GeneralTextWidget(
                title: state.selectedProcurement != index ? "+" : "✓",
                fontsize: 14.sp,
                color: state.selectedProcurement != index
                    ? Colors.black
                    : Colors.white),
          ),
        );
      },
    );
  }
}

class DeliverySelectedButtonController extends StatelessWidget {
  const DeliverySelectedButtonController({
    super.key,
    required this.widget,
    required this.index,
  });

  final FileAdditionalService widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalServiceCubit, AdditionalServiceState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            double deliveryPrice =
                AdditionalServicePrice.fileDeliveryServices[index].price -
                    AdditionalServicePrice
                        .fileDeliveryServices[state.selectedDelivery].price;
            widget.selecteddelivery(deliveryPrice);
            context.read<AdditionalServiceCubit>().changed(index);
          },
          child: Container(
            color:
                state.selectedDelivery != index ? Colors.white : Colors.green,
            padding: EdgeInsets.symmetric(vertical: 3.h),
            alignment: Alignment.center,
            child: GeneralTextWidget(
                title: state.selectedDelivery != index ? "+" : "✓",
                fontsize: 14.sp,
                color: state.selectedDelivery != index
                    ? Colors.black
                    : Colors.white),
          ),
        );
      },
    );
  }
}
