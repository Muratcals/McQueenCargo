import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/cargo_information_model.dart';
import 'package:mc_queen_cargo/features/Model/cargo_movements_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/CargoDetail/cargo_detail_mixin.dart';
import 'package:mc_queen_cargo/features/View/CargoDetail/cargo_state_widget.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CargoDetailPage extends StatefulWidget {
  const CargoDetailPage({super.key});

  @override
  State<CargoDetailPage> createState() => _CargoDetailPageState();
}

class _CargoDetailPageState extends State<CargoDetailPage>
    with CargoDetailMixin, TickerProviderStateMixin {
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
      future: Future.wait([
        service.getOneCargoInformation(
            cargoId: cargoId, accessToken: controller.accessToken.value),
        service.getCargoMovements(
            cargoId: cargoId, accessToken: controller.accessToken.value)
      ]),
      child: (model) {
        CargoInformationModel cargoInformationModel = model[0];
        List<CargoMovementsModel> cargoMovementModelList = model[1];
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            color: Colors.grey.shade100,
            margin: CustomPadding.onlyHorizontalInset(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                cargoDetailColumn(model: cargoInformationModel),
                SizedBox(height: 5.h),
                cargoDetailTabBar(),
                Divider(color: Colors.grey.shade800),
                Obx(() => tabIndex.value == 0
                    ? cargoInformation(model: cargoInformationModel)
                    : cargoMovementsContainer(
                        movementsList: cargoMovementModelList))
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar cargoDetailAppBar() {
    return AppBar(
      leading: appBarIcon(),
      flexibleSpace: appbarFlexibleSpace(),
      toolbarHeight: 30.h,
      centerTitle: true,
      title: textWidget(
          title: "Gönderi Detay", fontsize: 14.sp, color: Colors.white),
    );
  }

  Widget cargoMovementsContainer(
      {required List<CargoMovementsModel> movementsList}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        cargoMovementTitle(),
        cargoMovementsListView(movementsList: movementsList),
      ],
    );
  }

  Widget cargoMovementsListView(
      {required List<CargoMovementsModel> movementsList}) {
    return Container(
      padding: CustomPadding.allInset(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1)),
      height: 180.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: movementsList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              cargoMovementsListItems(movement: movementsList[index]),
              SizedBox(height: 5.h),
              Divider(color: Colors.grey, height: 4.h),
              SizedBox(height: 5.h)
            ],
          );
        },
      ),
    );
  }

  Row cargoMovementsListItems({required CargoMovementsModel movement}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: textWidget(
              title: DateFormat(
                "dd.MM.yyyy HH:mm",
              ).format(movement.date ?? DateTime.now()),
              fontsize: 13.sp,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: textWidget(
              title: (movement.cargoBranchName ?? "").toUpperCase(),
              fontsize: 13.sp,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: textWidget(
              title: movement.cargoStatusName ?? "", fontsize: 13.sp),
        ),
      ],
    );
  }

  Container cargoMovementTitle() {
    return Container(
      padding: CustomPadding.allInset(10),
      child: Row(
        children: [
          Expanded(child: textWidget(title: "İşlem Tarihi", fontsize: 12.sp)),
          Expanded(child: textWidget(title: "Birim", fontsize: 12.sp)),
          Expanded(child: textWidget(title: "İşlem Açıklama", fontsize: 12.sp)),
        ],
      ),
    );
  }

  Container cargoDetailTabBar() {
    return Container(
      padding: CustomPadding.allInset(5),
      child: TabBar(
        controller: tabController,
        tabs: [
          textWidget(title: "Gönderi Bilgileri", fontsize: 14.sp),
          textWidget(title: "Kargo Hareketleri", fontsize: 14.sp)
        ],
        onTap: (value) {
          tabIndex.value = value;
        },
      ),
    );
  }

  Widget cargoDetailColumn({required CargoInformationModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: CustomPadding.allInset(5),
          child: textWidget(
              title: "Gönderi Numarası: ${model.cargoTrackingNo}",
              fontsize: 14.sp,
              color: Colors.black),
        ),
        SizedBox(height: 5.h),
        CargoStateWidget(model: model),
      ],
    );
  }

  Column cargoInformation({required CargoInformationModel model}) {
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
                .format(model.cargoReleaseDate ?? DateTime.now()),
            icon: Icons.calendar_month),
        cargoDetailColumnItem(
            title: "Planlanan Teslim Tarihi",
            subTitle: DateFormat("dd.MM.yyyy HH:mm")
                .format(model.cargoEstimatedDeliveryDate ?? DateTime.now()),
            icon: Icons.calendar_month),
        cargoDetailColumnItem(
            title: "Çıkış Şubesi",
            subTitle: model.cargoDepartureBranchName ?? "",
            icon: Icons.location_pin),
        cargoDetailColumnItem(
            title: "Teslim Şubesi",
            subTitle: model.cargoArrivalBranchName ?? "",
            icon: Icons.location_pin),
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
              textWidget(title: title, fontsize: 12.sp, color: Colors.black),
              SizedBox(height: 5.h),
              textWidget(
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
          left: 21.w,
          top: 13.h,
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

  Container bottomColumItems({required CargoInformationModel model}) {
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

  Row bottomRowItems({required CargoInformationModel model}) {
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

  Row bottomRowItems2({required CargoInformationModel model}) {
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
        textWidget(title: title, fontsize: 12.sp, color: Colors.grey),
        textWidget(
            title: subTitle,
            fontsize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold)
      ],
    );
  }
}
