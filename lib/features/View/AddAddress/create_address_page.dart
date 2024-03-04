import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/district_model.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';
import 'package:mc_queen_cargo/features/Model/province_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/AddAddress/create_address_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part  '../AddAddress/create_address_widgets.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({super.key});

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage>
    with CreateAddressMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar(incoming: incoming)) ,
        body: AtomicFutureBuilder(
          future: Future.wait([
            service.getProvinceList(partnerController.accessToken.value),
            service.getDistrictList(partnerController.accessToken.value)
          ]),
          child: (model) {
            provinceList = model[0];
            districtList = model[1];
            return StackProgressWidget(
              visibility: visibilty,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    margin: CustomPadding.symmetricInset(15, 10),
                    child: Column(
                      children: [
                        _AddressTitle(incoming: incoming),
                        SizedBox(height: 10.h),
                        _AddressProvince(districtList: districtList, provinceList: provinceList,
                            neighbourhoodList: neighbourhoodList, incoming: incoming,neighbourhoodKey:  neighbourhoodKey),
                        SizedBox(height: 10.h),
                        _Neighbourhood(
                            neighbourhoodList: neighbourhoodList, incoming: incoming, neighbourhoodKey: neighbourhoodKey),
                        SizedBox(height: 10.h),
                        _Street(incoming: incoming),
                        SizedBox(height: 10.h),
                        _ApartmentAndFloorNo(incoming: incoming),
                        SizedBox(height: 10.h),
                        _AddressDescription(incoming: incoming),
                        SizedBox(height: 10.h),
                        incoming.contains("receiver")
                            ? _ReceiverInformation()
                            : Container(),
                        AtomicOrangeButton(
                          onPressed: () async {
                            visibilty.value = true;
                            await saveButtonProcess();
                          },
                          title: "Kaydet",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    super.key,
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: AppbarFlexibleSpace(),
      leading: AppBarIcon(),
      centerTitle: true,
      toolbarHeight: 30.h,
      title: GeneralTextWidget(
          title: incoming.contains("receiver")
              ? "Alıcı Adresi Ekle"
              : "Gönderici Adresi Ekle",
          fontsize: 14.sp,
          color: Colors.white),
    );
  }
}
