import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_future_builder.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/features/View/Address/address_mixin.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchable_listview/searchable_listview.dart';

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
      appBar: AppBar(
        leading: appBarIcon(),
        toolbarHeight: 30.h,
        flexibleSpace: appbarFlexibleSpace(),
        title: textWidget(
            title: incoming.contains("customer")
                ? "Gönderici Adresi Seçimi"
                : "Alıcı Adresi Seçimi",
            fontsize: 14.sp,
            color: Colors.white),
        bottom: widgets.appBarBottomItem(incoming, () {
          setState(() {});
        }),
      ),
      body: addressPageBody(),
    );
  }

  Container addressPageBody() {
    return Container(
      margin: CustomPadding.only(top: 10, left: 10, right: 10),
      child: AtomicFutureBuilder(
        future: incoming.contains("customer")
            ? getCustomerAddress(customerId: controller.currentAuth.value)
            : getReceiverAddress(customerId: controller.currentAuth.value),
        child: (model) {
          incoming.contains("customer")
              ? customerAddressList = model
              : receiverAddressList = model;
          return addressPageList();
        },
      ),
    );
  }

  SearchableList<dynamic> addressPageList() {
    return SearchableList(
      autoFocusOnSearch: false,
      inputDecoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffix: textWidget(title: "", fontsize: 12),
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
                ? widgets.customerAddresslistItems(
                    item: customerAddressList[itemIndex],
                    process: process,
                    setStatePage: (state) {
                      if (state == 1) {
                        setState(() {});
                      }
                    },
                  )
                : widgets.receiverAddresslistItems(
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
