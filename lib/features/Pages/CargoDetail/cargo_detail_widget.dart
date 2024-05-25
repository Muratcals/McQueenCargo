part of 'cargo_detail_page.dart';

class _CargoDetailDesign extends StatefulWidget {
  const _CargoDetailDesign({
    required this.service,
    required this.cargoId,
    required this.tabController,
    required this.tabIndex,
  });

  final Services service;
  final int cargoId;
  final TabController tabController;
  final RxInt tabIndex;

  @override
  State<_CargoDetailDesign> createState() => _CargoDetailDesignState();
}

class _CargoDetailDesignState extends State<_CargoDetailDesign> {
  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
      future: Future.wait([
        widget.service.getOneCargoInformation(cargoId: widget.cargoId),
        widget.service.getCargoMovements(cargoId: widget.cargoId)
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
                _CargoDetailColumn(model: cargoInformationModel),
                SizedBox(height: 5.h),
                _CargoDetailTabBar(
                    tabController: widget.tabController, tabIndex: widget.tabIndex),
                Divider(color: Colors.grey.shade800),
                Obx(() => widget.tabIndex.value == 0
                    ? _CargoInformation(model: cargoInformationModel)
                    : _CargoMovementsContainer(
                        movementsList: cargoMovementModelList))
              ],
            ),
          ),
        );
      },
      onError: () => setState(() {
        
      }),
    );
  }
}

class _CargoMovementsContainer extends StatelessWidget {
  const _CargoMovementsContainer({
    required this.movementsList,
  });

  final List<CargoMovementsModel> movementsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CargoMovementTitle(),
        _CargoMovementsListView(movementsList: movementsList),
      ],
    );
  }
}

class _CargoMovementsListView extends StatelessWidget {
  const _CargoMovementsListView({
    required this.movementsList,
  });

  final List<CargoMovementsModel> movementsList;

  @override
  Widget build(BuildContext context) {
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
              _CargoMovementsListItems(movement: movementsList[index]),
              SizedBox(height: 5.h),
              Divider(color: Colors.grey, height: 4.h),
              SizedBox(height: 5.h)
            ],
          );
        },
      ),
    );
  }
}

class _CargoInformation extends StatelessWidget {
  const _CargoInformation({required this.model});
  final CargoInformationModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CargoDetailColumnItem(
            title: "Gönderici Adı Soyadı",
            subTitle: "${model.customerName} ${model.customerSurname}",
            icon: Icons.person_2_outlined),
        _CargoDetailColumnItem(
            title: "Alıcı Adı Soyadı",
            subTitle: model.receiverNameSurname.toString(),
            icon: Icons.person_2_outlined),
        _CargoDetailColumnItem(
            title: "Gönderi Tarihi",
            subTitle: DateFormat("dd.MM.yyyy HH:mm")
                .format(model.cargoReleaseDate ?? DateTime.now()),
            icon: Icons.calendar_month),
        _CargoDetailColumnItem(
            title: "Planlanan Teslim Tarihi",
            subTitle: DateFormat("dd.MM.yyyy HH:mm")
                .format(model.cargoEstimatedDeliveryDate ?? DateTime.now()),
            icon: Icons.calendar_month),
        _CargoDetailColumnItem(
            title: "Çıkış Şubesi",
            subTitle: model.cargoDepartureBranchName ?? "",
            icon: Icons.location_pin),
        _CargoDetailColumnItem(
            title: "Teslim Şubesi",
            subTitle: model.cargoArrivalBranchName ?? "",
            icon: Icons.location_pin),
        _BottomColumItems(model: model)
      ],
    );
  }
}

class _BottomColumItems extends StatelessWidget {
  const _BottomColumItems({
    required this.model,
  });

  final CargoInformationModel model;

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
          _BottomRowItems(model: model),
          SizedBox(height: 5.h),
          Divider(color: Colors.grey, height: 2.h),
          SizedBox(height: 5.h),
          _BottomRowItems2(model: model)
        ],
      ),
    );
  }
}

class _BottomRowItems2 extends StatelessWidget {
  const _BottomRowItems2({
    required this.model,
  });

  final CargoInformationModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BottomColumnItems(
            title: "Kargo Tipi", subTitle: model.cargoParcelTypeName ?? ""),
        _BottomColumnItems(
            title: "Kargo Desisi",
            subTitle: (model.cargoDesi ?? 1).toString(),
            isCenter: 1),
      ],
    );
  }
}

class _BottomRowItems extends StatelessWidget {
  const _BottomRowItems({
    required this.model,
  });

  final CargoInformationModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BottomColumnItems(
            title: "Ödeme Tipi", subTitle: model.paymentTypeName ?? ""),
        const _BottomColumnItems(
          title: "Kargo Adedi",
          subTitle: "1",
          isCenter: 1,
        ),
      ],
    );
  }
}

class _BottomColumnItems extends StatelessWidget {
  const _BottomColumnItems(
      {required this.title, required this.subTitle, this.isCenter});

  final String title;
  final String subTitle;
  final int? isCenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCenter == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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

class _CargoDetailColumnItem extends StatelessWidget {
  const _CargoDetailColumnItem({
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        padding: CustomPadding.allInset(15),
        margin: CustomPadding.onlyVerticalInset(5),
        child: _CargoInformationWidget(
            title: title, subTitle: subTitle, icon: icon),
      );
}

class _CargoInformationWidget extends StatelessWidget {
  const _CargoInformationWidget({
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final String title;
  final String subTitle;
  final IconData icon;

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
        _PersonIcon(
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

class _PersonIcon extends StatelessWidget {
  const _PersonIcon({
    required this.icon,
    required this.arrow,
    required this.iconVisible,
  });

  final IconData icon;
  final IconData arrow;
  final int iconVisible;

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
}

class _CargoDetailColumn extends StatelessWidget {
  const _CargoDetailColumn({
    required this.model,
  });

  final CargoInformationModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: CustomPadding.allInset(5),
          child: GeneralTextWidget(
              title: "Gönderi Numarası: ${model.cargoTrackingNo}",
              fontsize: 14.sp,
              color: Colors.black),
        ),
        SizedBox(height: 5.h),
        CargoStateWidget(model: model),
      ],
    );
  }
}

class _CargoDetailTabBar extends StatelessWidget {
  const _CargoDetailTabBar({
    required this.tabController,
    required this.tabIndex,
  });

  final TabController tabController;
  final RxInt tabIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.allInset(5),
      child: TabBar(
        controller: tabController,
        tabs: [
          GeneralTextWidget(title: "Gönderi Bilgileri", fontsize: 14.sp),
          GeneralTextWidget(title: "Kargo Hareketleri", fontsize: 14.sp)
        ],
        onTap: (value) {
          tabIndex.value = value;
        },
      ),
    );
  }
}

class _CargoMovementTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.allInset(10),
      child: Row(
        children: [
          Expanded(
              child: GeneralTextWidget(title: "İşlem Tarihi", fontsize: 12.sp)),
          Expanded(child: GeneralTextWidget(title: "Birim", fontsize: 12.sp)),
          Expanded(
              child:
                  GeneralTextWidget(title: "İşlem Açıklama", fontsize: 12.sp)),
        ],
      ),
    );
  }
}

class _CargoMovementsListItems extends StatelessWidget {
  const _CargoMovementsListItems({
    required this.movement,
  });

  final CargoMovementsModel movement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GeneralTextWidget(
              title: DateFormat(
                "dd.MM.yyyy HH:mm",
              ).format(movement.date ?? DateTime.now()),
              fontsize: 13.sp,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: GeneralTextWidget(
              title: (movement.cargoBranchName ?? "").toUpperCase(),
              fontsize: 13.sp,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: GeneralTextWidget(
              title: movement.cargoStatusName ?? "", fontsize: 13.sp),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      toolbarHeight: 30.h,
      centerTitle: true,
      title: GeneralTextWidget(
          title: "Gönderi Detay", fontsize: 14.sp, color: Colors.white),
    );
  }
}
