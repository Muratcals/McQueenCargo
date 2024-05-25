// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/post_courier_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/AddionatialService/ProcurementService/procurement_page.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/AddionatialService/additional_service_mixin.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/get_courier_information.dart';
import 'package:mc_queen_cargo/features/Constants/GetCourierCubit/post_courier_cubit.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class AdditionalServicePage extends StatefulWidget {
  const AdditionalServicePage({super.key});

  @override
  State<AdditionalServicePage> createState() => _AdditionalServicePageState();
}

class _AdditionalServicePageState extends State<AdditionalServicePage>
    with AdditionalServiceMixin {
  @override
  Widget build(BuildContext context) {
    PostCourierModel courierModel = context.read<GetCourierPostCubit>().state;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 30.h,
        flexibleSpace: const AppbarFlexibleSpace(),
        leading: const AppBarIcon(),
        title: GeneralTextWidget(
            title: "Ek Hizmet Seçimi", fontsize: 14.sp, color: Colors.white),
      ),
      body: AtomicFutureBuilder(
        future: Future.wait([
          service.getCustomerAddress(
              addressId: courierModel.customerMobilAdressId ?? 0),
          service.getReceiverAddress(addressId: courierModel.receiverId ?? 0)
        ]),
        child: (model) {
          AddressModel customerAddressModel = model[0];
          ReceiverAddressModel receiverAddressModel = model[1];
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: CustomPadding.symmetricInset(15, 5),
              child: Column(
                children: [
                  CourierInformation(
                      customerAddressModel: customerAddressModel,
                      receiverAddressModel: receiverAddressModel,
                      type: type,
                      transportPrice: price,
                      transportService: "STANDART"),
                  Container(
                    padding: EdgeInsets.all(15.r),
                    child: GeneralTextWidget(
                        title: "Lütfen ek hizmet seçimlerini yapınız",
                        fontsize: 16.sp),
                  ),
                  SelectedCargoPrice(
                    procurementPrice: procurementPrice,
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralTextWidget(
                          title: "TESLİMAT HİZMETLERİ", fontsize: 15.sp),
                      ProcumentService(
                        type: type,
                        onPressed: (updatePrice, index) {
                          addionatialServicePrice =
                              addionatialServicePrice + updatePrice;
                          deliveryIndex = index;
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  nextButton()
                ],
              ),
            ),
          );
        },
        onError: () => setState(() {
          
        }),
      ),
    );
  }

  Widget nextButton() {
    return AtomicOrangeButton(
        onPressed: () async {
          context.read<GetCourierPostCubit>().state.cargoDesi = weight;
          context.read<GetCourierPostCubit>().state.cargoTypeId = 1;
          context.read<GetCourierPostCubit>().state.paymentTypeId = 2;
          await Get.toNamed(GenerateRoute.approvePage, arguments: {
            "type": type,
            "price": addionatialServicePrice,
            "deliveryIndex": deliveryIndex
          });
        },
        title: "Devam");
  }
}

class SelectedCargoPrice extends StatelessWidget {
  const SelectedCargoPrice({
    Key? key,
    required this.procurementPrice,
  }) : super(key: key);
  final double procurementPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.symmetricInset(5, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r), color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Radio.adaptive(
            value: 0,
            activeColor: Colors.green,
            groupValue: 0,
            onChanged: (value) {},
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralTextWidget(
                    title: "ADRESTEN ALIM",
                    fontsize: 15.sp,
                    fontWeight: FontWeight.bold),
                GeneralTextWidget(
                    title: "$procurementPrice TL",
                    fontsize: 16.sp,
                    color: Colors.green)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
