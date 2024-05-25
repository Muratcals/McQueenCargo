import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Constants/additionatial_service_prica.dart';
import 'package:mc_queen_cargo/features/Model/additional_service_model.dart';
import 'package:mc_queen_cargo/features/Model/package_information.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/package_sending_widgets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PackageSendingPage extends StatefulWidget {
  const PackageSendingPage({super.key});

  @override
  State<PackageSendingPage> createState() => _PackageSendingPageState();
}

class _PackageSendingPageState extends State<PackageSendingPage> {
  late String incoming;
  Services service = Services();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = Get.arguments;
    incoming = arguments["incoming"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: appBar(),
      body: AtomicFutureBuilder(
        future: service.getCargoParcelTypeModel(),
        child: (_) {
          List<CargoParcelTypeModel> model = _;
          return PackageSendingPageWidgets(
            model: model,
            incoming: incoming,
          );
        },
        onError: () => setState(() {
          
        }),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Container(
        margin: CustomPadding.only(right: 10),
        alignment: Alignment.center,
        child: GeneralTextWidget(
            title: incoming.contains("calculate")
                ? "Paket Özeti"
                : "Gönderi Tipi Seçimi",
            fontsize: 13.sp,
            color: Colors.white),
      ),
      flexibleSpace: const AppbarFlexibleSpace(),
      centerTitle: true,
      toolbarHeight: 27.h,
      leading: const AppBarIcon(),
      actions: [
        InkWell(
          onTap: () {
            resetAdditionalService();
            Get.until((route) => Get.currentRoute == "/main");
            // Get.offAllNamed("/main", arguments: {"userId": 0});
          },
          child: Container(
              alignment: Alignment.center,
              margin: CustomPadding.only(right: 10),
              child: GeneralTextWidget(
                  title: "İptal", fontsize: 14.sp, color: Colors.white)),
        )
      ],
    );
  }

  void resetAdditionalService() {
    AdditionalServicePrice.packageProcurementServices.clear();
    AdditionalServicePrice.packageProcurementServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
    ]);
    AdditionalServicePrice.packageDeliveryServices.clear();
    AdditionalServicePrice.packageDeliveryServices.addAll([
      AdditionalServiceModel(name: "Adresten Alım", price: 24.46),
      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
    ]);
  }
}
