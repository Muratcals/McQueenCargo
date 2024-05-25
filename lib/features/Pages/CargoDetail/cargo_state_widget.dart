import 'package:mc_queen_cargo/features/Model/cargo_information_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CargoStateWidget extends StatefulWidget {
  const CargoStateWidget({super.key, required this.model});
  final CargoInformationModel model;

  @override
  State<CargoStateWidget> createState() => _CargoStateWidgetState();
}

class _CargoStateWidgetState extends State<CargoStateWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: CustomPadding.symmetricInset(20, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.blue.shade900),
        height: (Get.height * 22) / 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralTextWidget(
                title: widget.model.cargoStatusName ?? "",
                fontsize: 14.sp,
                color: Colors.white),
            SizedBox(height: 10.h),
            Row(
              children: [
                _CargoMovementWidget(widget: widget, index: 1, icon: "images/lifter.png"),
                _SpaceWidget(),
                _CargoMovementWidget(widget: widget, index: 2, icon: "images/delivery.png"),
                _SpaceWidget(),
                _CargoMovementWidget(widget: widget, index: 5, icon: "images/post_office.png"),
                _SpaceWidget(),
                _CargoMovementWidget(widget: widget, index: 6, icon: "images/courier.png"),
                _SpaceWidget(),
                _CargoMovementWidget(widget: widget, index: 7, icon: "images/delivery_service.png")
              ],
            ),
            _BottomLineWidget(widget: widget)
          ],
        ),
      ),
    );
  }
}

class _SpaceWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ((Get.width - 120) / 4),
    );
  }
}

class _BottomLineWidget extends StatelessWidget {
  const _BottomLineWidget({
    required this.widget,
  });

  final CargoStateWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CargoStateContainer(),
        _LineWidget(widget: widget, index: 2),
        _CargoStateContainer(),
        _LineWidget(widget: widget, index: 5),
        _CargoStateContainer(),
        _LineWidget(widget: widget, index: 6),
        _CargoStateContainer(),
        _LineWidget(widget: widget, index: 7),
        _CargoStateContainer(),
      ],
    );
  }
}

class _LineWidget extends StatelessWidget {
  const _LineWidget({
    required this.widget,
    required this.index,
  });

  final CargoStateWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.h,
      width: ((Get.width - 40) / 4),
      color: widget.model.cargoStatusId! >= index ? Colors.red : Colors.white,
      margin: CustomPadding.only(top: 8),
    );
  }
}

class _CargoStateContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.only(top: 8),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 10.r,
        child: Icon(
          Icons.done,
          size: 10.r,
          color: Colors.red,
        ),
      ),
    );
  }
}

class _CargoMovementWidget extends StatelessWidget {
  const _CargoMovementWidget({
    required this.widget,
    required this.index,
    required this.icon,
  });

  final CargoStateWidget widget;
  final int index;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.rotate(
          angle: 45 * (3.14 / 180),
          child: Container(
            width: 40.w,
            height: 40.w,
            padding: CustomPadding.allInset(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: widget.model.cargoStatusId == index
                  ? Colors.red
                  : Colors.white,
            ),
            child: Transform.rotate(
              angle: 315 * (3.14 / 180),
              child: Image.asset(
                icon,
                color: widget.model.cargoStatusId == index
                    ? Colors.white
                    : Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
