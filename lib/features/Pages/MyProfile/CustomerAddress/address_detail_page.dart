import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_orange_button.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/CustomerAddress/address_detail_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

part 'address_detail_widgets.dart';

class CustomerAddresssInformationPage extends StatefulWidget {
  const CustomerAddresssInformationPage({super.key});

  @override
  State<CustomerAddresssInformationPage> createState() =>
      _CustomerAddresssInformationPageState();
}

class _CustomerAddresssInformationPageState
    extends State<CustomerAddresssInformationPage>
    with CustomerAddressInformationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(preferredSize: Size(30.w, 30.h), child: _AppBar()),
      body: AtomicFutureBuilder(
        future: getCustomerAddress(),
        child: (getModel) {
          AddressModel model = getModel;
          return _AddressDetailList(
            model: model,
            onPressedButton: () => onPressedButton(),
          );
        },
        onError: () => setState(() {}),
      ),
    );
  }
}
