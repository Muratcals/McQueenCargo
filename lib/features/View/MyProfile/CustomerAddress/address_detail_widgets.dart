import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerAddressWidget {
  AppBar appBar() {
    return AppBar(
      title: textWidget(
          title: "Adres Detayı", fontsize: 15.sp, color: Colors.white),
      centerTitle: true,
      toolbarHeight: 27.h,
      leading: appBarIcon(),
      flexibleSpace: appbarFlexibleSpace(),
    );
  }

  Container columnTitle(AddressModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: Row(
        children: [
          Icon(
            Icons.home,
            color: Colors.grey,
            size: 50.r,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    title: model.title!,
                    fontsize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 5),
                textWidget(
                    title: "${model.districtName}/${model.provinceName}",
                    fontsize: 12.sp,
                    color: Colors.grey)
              ],
            ),
          )
        ],
      ),
    );
  }

  Container customerAddressIformationColumn(AddressModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          columnItems(title: "Adres Tipi", subTitle: model.title),
          columnItems(title: "Mahalle", subTitle: model.neighbourhoodName),
          columnItems(title: "Cadde/Sokak", subTitle: model.street),
          columnItems(title: "Bina No", subTitle: model.buildingNo),
          columnItems(title: "Daire No", subTitle: model.apartmentNumber),
          columnItems(title: "İlçe", subTitle: model.districtName),
          columnItems(title: "İl", subTitle: model.provinceName),
          columnItems(title: "Adres Tarifi", subTitle: model.description),
          fullAddress(model)
        ],
      ),
    );
  }

  Widget fullAddress(AddressModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120.w,
              child: textWidget(
                  title: "Tam Adres", fontsize: 14.sp, color: Colors.grey)),
          Expanded(
            child: Text(
              "${model.neighbourhoodName} ${model.street} No: ${model.buildingNo} D: ${model.apartmentNumber}",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Container columnItems({required String title, String? subTitle}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 150.w,
              child: textWidget(
                  title: title, fontsize: 14.sp, color: Colors.grey)),
          Expanded(
            child: Text(
              subTitle ?? "",
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
