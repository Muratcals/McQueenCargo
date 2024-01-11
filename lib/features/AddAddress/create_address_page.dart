import 'package:mc_queen_cargo/features/AddAddress/create_address_mixin.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        appBar: AppBar(
          flexibleSpace: appbarFlexibleSpace(),
          leading: appBarIcon(),
          centerTitle: true,
          toolbarHeight: 30.h,
          title: textWidget(
              title: incoming.contains("receiver")
                  ? "Alıcı Adresi Ekle"
                  : "Gönderici Adresi Ekle",
              fontsize: 14.sp,
              color: Colors.white),
        ),
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
                        widgets.addressTitle(incoming),
                        SizedBox(height: 10.h),
                        widgets.addressProvince(districtList, provinceList,
                            neighbourhoodList, incoming, neighbourhoodKey),
                        SizedBox(height: 10.h),
                        widgets.neighbourhood(
                            neighbourhoodList, incoming, neighbourhoodKey),
                        SizedBox(height: 10.h),
                        widgets.street(incoming),
                        SizedBox(height: 10.h),
                        widgets.apartmentAndFloorNo(incoming),
                        SizedBox(height: 10.h),
                        widgets.addressDescription(incoming),
                        SizedBox(height: 10.h),
                        incoming.contains("receiver")
                            ? widgets.receiverInformation()
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
