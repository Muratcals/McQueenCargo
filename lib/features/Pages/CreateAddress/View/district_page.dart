import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/Controller/create_address_cubit/create_address_cubit.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Model/district_model.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';
import 'package:mc_queen_cargo/features/Services/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class DistrictPage extends StatefulWidget {
  const DistrictPage(
      {super.key, required this.incoming, required this.neighbourhoodKey});
  final String incoming;
  final GlobalKey<FormFieldState> neighbourhoodKey;

  @override
  State<DistrictPage> createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  final Services service = Services();

  Future<List<NeighbourhoodModel>> getNeighbourhoodList(int districtId) async {
    Services service = Services();
    return await service.getNeighbourhoodList(districtId);
  }

  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
      future: service.getDistrictList(),
      child: (model) {
        List<DistrictModel> districtList = model;
        return DropdownButtonFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: "İlçe",
            labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
            contentPadding: CustomPadding.onlyHorizontalInset(10),
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          validator: (value) {
            if (value == null) {
              return "Boş Geçilmez";
            }
            return null;
          },
          items: districtList
              .map(
                (e) => DropdownMenuItem(
                  value: e.id,
                  child: GeneralTextWidget(
                      title: e.districtName ?? "", fontsize: 13.sp),
                ),
              )
              .toList(),
          onChanged: (value) async {
            var neighbourhoodList = await getNeighbourhoodList(value ?? 0);
            context.read<CreateAddressCubit>().changeList(neighbourhoodList);
            widget.neighbourhoodKey.currentState!.reset();
            if (widget.incoming.contains("customer")) {
              context
                  .read<CreateAddressCubit>()
                  .changeCustomerAddress(districtId: value ?? 0);
            } else {
              context.read<CreateAddressCubit>().changeReceiverAddress(districtId:value ?? 0 );
            }
          },
        );
      },
      onError: () => setState(() {}),
    );
  }
}
