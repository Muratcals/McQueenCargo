import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/Controller/create_address_cubit/create_address_cubit.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_progreess_page.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Model/province_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/View/district_page.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/create_address_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part 'create_address_widgets.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({super.key});

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage>
    with CreateAddressMixin {
  @override
  Widget build(BuildContext context) {
    return 
        BlocProvider(
          create: (context) => CreateAddressCubit(),
      
    
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey.shade50,
          appBar: PreferredSize(
              preferredSize: Size(30.w, 30.h),
              child: _AppBar(incoming: incoming)),
          body: StackProgressWidget(
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
                      _AddressProvince(
                          incoming: incoming,
                          neighbourhoodKey: neighbourhoodKey),
                      SizedBox(height: 10.h),
                      _Neighbourhood(
                          incoming: incoming,
                          neighbourhoodKey: neighbourhoodKey),
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
                      BlocBuilder<CreateAddressCubit, CreateAddressState>(
                          builder: (context, state) {
                        return  AtomicOrangeButton(
                              onPressed: () async {
                                try {
                                  visibilty.value = true;
                                  await saveButtonProcess(context);
                                } catch (e) {
                                  EasyLoading.showError(
                                      "Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz");
                                  visibilty.value = false;
                                }
                              },
                              title: "Kaydet",
                            );
                          }
                        )
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: const AppbarFlexibleSpace(),
      leading:const AppBarIcon(),
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
