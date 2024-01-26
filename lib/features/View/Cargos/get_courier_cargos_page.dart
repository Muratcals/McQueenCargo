import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/cargo_information_model.dart';
import 'package:mc_queen_cargo/features/Model/call_courier_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/Cargos/get_courier_cargos_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GetCourierCargosPage extends StatefulWidget {
  const GetCourierCargosPage({super.key});

  @override
  State<GetCourierCargosPage> createState() => _GetCourierCargosPageState();
}

class _GetCourierCargosPageState extends State<GetCourierCargosPage>
    with GetCourierCargosMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: AtomicFutureBuilder(
        future: Future.wait([
          service.getAllCargoInformation(tcNo: tcNo, accessToken: accessToken),
          service.getAllCourierList(accessToken: accessToken, tcNo: tcNo)
        ]),
        child: (result) {
          List<CargoInformationModel> cargoList = result[0];
          List<CallCourierModel> getCourierList = result[1];
          return getCourierList.isEmpty && cargoList.isEmpty
              ? emptyList()
              : ListView.builder(
                  itemCount: getCourierList.length + cargoList.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index < getCourierList.length) {
                      return getCourierDesignWidget(getCourierList[index]);
                    } else {
                      return cargoDesignWidget(
                          cargoList[index - getCourierList.length]);
                    }
                  },
                );
        },
      ),
    );
  }

  Container emptyList() {
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

  InkWell cargoDesignWidget(CargoInformationModel model) {
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
                    textWidget(
                        title: "Gönderi Kodu",
                        fontsize: 13.sp,
                        color: Colors.black),
                    textWidget(
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

  InkWell getCourierDesignWidget(CallCourierModel model) {
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
                    textWidget(
                        title: "Kargo Adresi",
                        fontsize: 13.sp,
                        color: Colors.black),
                    textWidget(
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
