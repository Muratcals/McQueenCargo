import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Widgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/Pages/Address/address_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchable_listview/searchable_listview.dart';

part 'address_widgets.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> with AddressMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _AppBar(
        incoming: incoming,
        reload: () => setState(() {}),
      ),
      body: Container(
        margin: CustomPadding.only(top: 10, left: 10, right: 10),
        child: AtomicFutureBuilder(
          future: incoming.contains("customer")
              ? getCustomerAddress(customerId: Auth.authId)
              : getReceiverAddress(customerId: Auth.authId),
          child: (model) {
            incoming.contains("customer")
                ? customerAddressList = model
                : receiverAddressList = model;
            return addressPageList();
          },
          onError: () => setState(() {}),
        ),
      ),
    );
  }

  SearchableList<dynamic> addressPageList() {
    return SearchableList(
      autoFocusOnSearch: false,
      inputDecoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffix: const GeneralTextWidget(title: "", fontsize: 12),
        hintText: "Arayın",
        contentPadding: EdgeInsets.symmetric(vertical: 0.r),
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      initialList: incoming.contains("customer")
          ? customerAddressList
          : receiverAddressList,
      filter: (query) {
        return filter(query);
      },
      builder: (displayedList, itemIndex, item) {
        return Column(
          children: [
            incoming.contains("customer")
                ? _CustomerAddresslistItems(
                    item: customerAddressList[itemIndex],
                    process: process,
                    setStatePage: (state) {
                      if (state == 1) {
                        setState(() {});
                      }
                    },
                  )
                : _ReceiverAddresslistItems(
                    item: receiverAddressList[itemIndex],
                    process: process,
                    setStatePage: (state) {
                      if (state == 1) {
                        setState(() {});
                      }
                    },
                  ),
            SizedBox(height: 10.h)
          ],
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.incoming, required this.reload});

  final String incoming;
  final VoidCallback reload;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
      title: GeneralTextWidget(
          title: incoming.contains("customer")
              ? "Gönderici Adresi Seçimi"
              : "Alıcı Adresi Seçimi",
          fontsize: 14.sp,
          color: Colors.white),
      bottom: PreferredSize(
        preferredSize:
            Size((MediaQuery.of(context).size.height * 90) / 100, 30.h),
        child: _AppBarBottomItem(
          incoming: incoming,
          reload: reload,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.h);
}
