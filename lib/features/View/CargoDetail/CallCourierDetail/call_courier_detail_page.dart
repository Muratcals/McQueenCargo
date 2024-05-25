import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/call_courier_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/CargoDetail/CallCourierDetail/call_courier_detail_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      appBar: cargoDetailAppBar(),
      body: cargoDetailDesign(),
    );
  }

  AtomicFutureBuilder cargoDetailDesign() {
    return AtomicFutureBuilder(
      future: service.getOneCallCourier(cargoId: cargoId),
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
                cargoInformation(model: callCourierModel)
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar cargoDetailAppBar() {
    return AppBar(
      leading: AppBarIcon(),
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
                  return qrImageDesign();
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

  PopScope qrImageDesign() {
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

  Column cargoInformation({required CallCourierModel model}) {
    return Column(
      children: [
        cargoDetailColumnItem(
            title: "Gönderici Adı Soyadı",
            subTitle: "${model.customerName} ${model.customerSurname}",
            icon: Icons.person_2_outlined),
        cargoDetailColumnItem(
            title: "Alıcı Adı Soyadı",
            subTitle: model.receiverNameSurname.toString(),
            icon: Icons.person_2_outlined),
        cargoDetailColumnItem(
            title: "Gönderi Tarihi",
            subTitle: DateFormat("dd.MM.yyyy HH:mm")
                .format(model.cargoRealeseDate ?? DateTime.now()),
            icon: Icons.calendar_month),
        cargoDetailColumnItem(
            title: "Planlanan Teslim Tarihi",
            subTitle: "",
            icon: Icons.calendar_month),
        bottomColumItems(model: model)
      ],
    );
  }

  Container cargoDetailColumnItem(
          {required String title,
          required String subTitle,
          required IconData icon}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        padding: CustomPadding.allInset(15),
        margin: CustomPadding.onlyVerticalInset(5),
        child: cargoInformationWidget(
            title: title, subTitle: subTitle, icon: icon),
      );

  Row cargoInformationWidget(
      {required String title,
      required String subTitle,
      required IconData icon}) {
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
        personIcon(
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

  Stack personIcon(
      {required IconData icon, required IconData arrow, int iconVisible = 1}) {
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

  Container bottomColumItems({required CallCourierModel model}) {
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
          bottomRowItems(model: model),
          SizedBox(height: 5.h),
          Divider(color: Colors.grey, height: 2.h),
          SizedBox(height: 5.h),
          bottomRowItems2(model: model)
        ],
      ),
    );
  }

  Row bottomRowItems({required CallCourierModel model}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bottomColumnItems(
            title: "Ödeme Tipi", subTitle: model.paymentTypeName ?? ""),
        bottomColumnItems(title: "Kargo Adedi", subTitle: "1", center: 1),
      ],
    );
  }

  Row bottomRowItems2({required CallCourierModel model}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bottomColumnItems(
            title: "Kargo Tipi", subTitle: model.cargoParcelTypeName ?? ""),
        bottomColumnItems(
            title: "Kargo Desisi",
            subTitle: (model.cargoDesi ?? 1).toString(),
            center: 1),
      ],
    );
  }

  Column bottomColumnItems(
      {required String title, required String subTitle, int center = 0}) {
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
