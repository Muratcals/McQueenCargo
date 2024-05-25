import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/call_courier_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CargoDetail/CallCourierDetail/call_courier_detail_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class CallCourierDetailPage extends StatefulWidget {
  const CallCourierDetailPage({super.key});

  @override
  State<CallCourierDetailPage> createState() => _CallCourierDetailPageState();
}

class _CallCourierDetailPageState extends State<CallCourierDetailPage>
    with CallCourierDetailMixin, TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CargoDetailAppBar(context: context, cargoId: cargoId),
      body: CargoDetailDesign(service: service, cargoId: cargoId),
    );
  }
}

class CargoDetailDesign extends StatefulWidget {
  const CargoDetailDesign({
    super.key,
    required this.service,
    required this.cargoId,
  });

  final Services service;
  final int cargoId;

  @override
  State<CargoDetailDesign> createState() => _CargoDetailDesignState();
}

class _CargoDetailDesignState extends State<CargoDetailDesign> {
  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
      future: widget.service.getOneCallCourier(cargoId: widget.cargoId),
      child: (model) {
        CallCourierModel callCourierModel = model;
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            color: Colors.grey.shade100,
            margin: CustomPadding.onlyHorizontalInset(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 5.h),
                CargoInformation(model: callCourierModel)
              ],
            ),
          ),
        );
      },
      onError: () =>setState(() {
        
      }),
    );
  }
}

class CargoDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CargoDetailAppBar({
    Key? key,
    required this.context,
    required this.cargoId,
  }) : super(key: key);

  final BuildContext context;
  final int cargoId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      toolbarHeight: 30.h,
      centerTitle: true,
      title: GeneralTextWidget(
          title: "Gönderi Detay", fontsize: 14.sp, color: Colors.white),
      actions: [
        IconButton(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return QrImageDesign(cargoId: cargoId);
                },
              );
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ))
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(30.h);
}

class QrImageDesign extends StatelessWidget {
  const QrImageDesign({
    super.key,
    required this.cargoId,
  });

  final int cargoId;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: (Get.height * 40) / 100,
          margin: CustomPadding.onlyHorizontalInset(25),
          child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              flexibleSpace: const AppbarFlexibleSpace(),
              toolbarHeight: 30.h,
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
              ],
              title: GeneralTextWidget(
                  title: "Kargo Bilgileri",
                  fontsize: 14.sp,
                  color: Colors.white),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  "Gelen kargocuya bu qr kodu okutarak kargo bilgilerinizi verebilirsiniz",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 13.sp),
                ),
                SizedBox(height: 5.h),
                Container(
                  alignment: Alignment.center,
                  child: QrImageView(
                    data: cargoId.toString(),
                    size: 150.r,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CargoInformation extends StatelessWidget {
  const CargoInformation({super.key,required this.model});
final CallCourierModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CargoDetailColumnItem(title: "Gönderici Adı Soyadı", subTitle: "${model.customerName} ${model.customerSurname}", icon: Icons.person_2_outlined),
        CargoDetailColumnItem(title: "Alıcı Adı Soyadı", subTitle: model.receiverNameSurname.toString(), icon: Icons.person_2_outlined),
        CargoDetailColumnItem(title: "Gönderi Tarihi", subTitle: DateFormat("dd.MM.yyyy HH:mm")
                .format(model.cargoRealeseDate ?? DateTime.now()), icon: Icons.calendar_month),
        const CargoDetailColumnItem(title: "Planlanan Teslim Tarihi", subTitle: "", icon: Icons.calendar_month),
        BottomColumItems(model: model)
      ],
    );
  }
}

class CargoDetailColumnItem extends StatelessWidget {
  const CargoDetailColumnItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        padding: CustomPadding.allInset(15),
        margin: CustomPadding.onlyVerticalInset(5),
        child: CargoInformationWidget(
            title: title, subTitle: subTitle, icon: icon),
      );
}

class CargoInformationWidget extends StatelessWidget {
  const CargoInformationWidget({
    super.key,required this.icon,
      required this.title,
      required this.subTitle 
  });
final IconData icon;
final String subTitle;
final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralTextWidget(
                  title: title, fontsize: 12.sp, color: Colors.black),
              SizedBox(height: 5.h),
              GeneralTextWidget(
                  title: subTitle,
                  fontsize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)
            ],
          ),
        ),
        SizedBox(width: 5.w),
        PersonIcon(
            icon: icon,
            arrow: title == "Alıcı Adı Soyadı" || title == "Teslim Şubesi"
                ? Icons.north_west
                : Icons.south_east,
            iconVisible:
                title == "Gönderi Tarihi" || title == "Planlanan Teslim Tarihi"
                    ? 0
                    : 1)
      ],
    );
  }
}

class PersonIcon extends StatelessWidget {
   PersonIcon({
    super.key,
    required this.icon, required this.arrow ,this.iconVisible
  });

   final IconData icon;
final IconData arrow;
int? iconVisible = 1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: CustomPadding.allInset(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Icon(
            icon,
            size: 25.r,
          ),
        ),
        Positioned(
          left: 22.w,
          top: 14.h,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.red,
              border: Border.all(color: Colors.grey),
            ),
            child: iconVisible == 1
                ? Icon(
                    arrow,
                    color: Colors.white,
                    size: 13.r,
                  )
                : null,
          ),
        )
      ],
    );
  }
}

class BottomColumItems extends StatelessWidget {
  const BottomColumItems({super.key, required this.model});
  final CallCourierModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: CustomPadding.allInset(15),
      margin: CustomPadding.onlyVerticalInset(5),
      child: Column(
        children: [
          BottomRowItems(model: model),
          SizedBox(height: 5.h),
          Divider(color: Colors.grey, height: 2.h),
          SizedBox(height: 5.h),
          BottomRowItems2(model: model)
        ],
      ),
    );
  }
}

class BottomRowItems extends StatelessWidget {
  const BottomRowItems({super.key, required this.model});
  final CallCourierModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomColumnItems(
            title: "Ödeme Tipi", subTitle: model.paymentTypeName ?? ""),
        const BottomColumnItems(title: "Kargo Adedi", subTitle: "1", center: 1),
      ],
    );
  }
}

class BottomRowItems2 extends StatelessWidget {
  const BottomRowItems2({super.key, required this.model});
  final CallCourierModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomColumnItems(
            title: "Kargo Tipi", subTitle: model.cargoParcelTypeName ?? ""),
        BottomColumnItems(
            title: "Kargo Desisi",
            subTitle: (model.cargoDesi ?? 1).toString(),
            center: 1),
      ],
    );
  }
}

class BottomColumnItems extends StatelessWidget {
 const BottomColumnItems(
      {super.key,
      required this.title,
      required this.subTitle,
      this.center = 0});
  final String title;
  final String subTitle;
  final int? center;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          center == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        GeneralTextWidget(title: title, fontsize: 12.sp, color: Colors.grey),
        GeneralTextWidget(
            title: subTitle,
            fontsize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold)
      ],
    );
  }
}
