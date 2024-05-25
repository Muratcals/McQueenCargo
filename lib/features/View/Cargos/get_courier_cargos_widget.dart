part of '../Cargos/get_courier_cargos_page.dart';

class _CargosPageBody extends StatelessWidget {
  const _CargosPageBody({
    required this.service,
    required this.tcNo,
  });

  final Services service;
  final String tcNo;

  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
      future: Future.wait([
        service.getAllCargoInformation(tcNo: tcNo),
        service.getAllCourierList(tcNo: tcNo)
      ]),
      child: (result) {
        List<CargoInformationModel> cargoList = result[0];
        List<CallCourierModel> getCourierList = result[1];
        return getCourierList.isEmpty && cargoList.isEmpty
            ? _EmptyListView()
            : ListView.builder(
                itemCount: getCourierList.length + cargoList.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index < getCourierList.length) {
                    return _GetCourierDesignView(model: getCourierList[index]);
                  } else {
                    return _CargoDesignView(model: cargoList[index - getCourierList.length]);
                  }
                },
              );
      },
    );
  }
}

class _GetCourierDesignView extends StatelessWidget {
  const _GetCourierDesignView({
    required this.model,
  });

  final CallCourierModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/callCourierDetailPage", arguments: {"cargoId": model.id});
      },
      child: Container(
        margin: CustomPadding.symmetricInset(10, 5),
        padding: CustomPadding.symmetricInset(10, 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                "images/box_icon.png",
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: CustomPadding.allInset(10),
                child: Column(
                  children: [
                    GeneralTextWidget(
                        title: "Kargo Adresi",
                        fontsize: 13.sp,
                        color: Colors.black),
                    GeneralTextWidget(
                        title:
                            "${model.receiverDistrictName}/${model.receiverProvinceName}",
                        fontsize: 13.sp,
                        color: Colors.black)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                  padding: CustomPadding.allInset(5),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "Kurye Çağırıldı",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  )),
            ),
            const Expanded(
                flex: 1,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

class _CargoDesignView extends StatelessWidget {
  const _CargoDesignView({
    required this.model,
  });

  final CargoInformationModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("cargoDetailPage", arguments: {"cargoId": model.id});
      },
      child: Container(
        margin: CustomPadding.symmetricInset(10, 5),
        padding: CustomPadding.symmetricInset(10, 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                "images/box_icon.png",
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: CustomPadding.allInset(10),
                child: Column(
                  children: [
                    GeneralTextWidget(
                        title: "Gönderi Kodu",
                        fontsize: 13.sp,
                        color: Colors.black),
                    GeneralTextWidget(
                        title: model.cargoTrackingNo ?? "",
                        fontsize: 13.sp,
                        color: Colors.black)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                  padding: CustomPadding.allInset(5),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    model.cargoStatusName ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  )),
            ),
            const Expanded(
                flex: 1, child: Icon(Icons.chevron_right, color: Colors.white))
          ],
        ),
      ),
    );
  }
}

class _EmptyListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.only(
          top: (Get.height * 17) / 100, left: 20.w, right: 20.w),
      child: Column(
        children: [
          Image.asset(
            "images/box_icon.png",
            color: Colors.grey,
            fit: BoxFit.contain,
            width: 150.w,
            height: 60.h,
          ),
          Text(
            "Daha önce yapılmış bir gönderi veya kargo sorgulaması bulunamadı",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
