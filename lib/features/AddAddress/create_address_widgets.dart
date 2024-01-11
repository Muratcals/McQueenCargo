import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_textformfield.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/Model/district_model.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';
import 'package:mc_queen_cargo/features/Model/province_model.dart';
import 'package:mc_queen_cargo/features/Service/services.dart';
import 'package:mc_queen_cargo/features/UI/csutom_edge_insets.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAddressWidgets {
  PartnerController controller = Get.find();

  Row addressProvince(
    List<DistrictModel> districtList,
    List<ProvinceModel> provinceList,
    RxList<NeighbourhoodModel> neighbourhoodList,
    String incoming,
    GlobalKey<FormFieldState> neighbourhoodKey,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: CustomPadding.only(right: 10),
            child: province(provinceList, incoming),
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Container(
            margin: CustomPadding.only(left: 15),
            child: district(
                districtList, neighbourhoodList, incoming, neighbourhoodKey),
          ),
        )
      ],
    );
  }

  DropdownButtonFormField district(
      List<DistrictModel> districtList,
      RxList<NeighbourhoodModel> neighbourhoodList,
      String incoming,
      GlobalKey<FormFieldState> neighbourhoodKey) {
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
              child: textWidget(title: e.districtName ?? "", fontsize: 13.sp),
            ),
          )
          .toList(),
      onChanged: (value) async {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.districtId = value;
          neighbourhoodKey.currentState?.reset();
          neighbourhoodList.value = [];
          await getNeighbourhoodList(neighbourhoodList, value);
        } else {
          controller.receiverAddressModel.value.districtId = value;
          neighbourhoodKey.currentState?.reset();
          neighbourhoodList.value = [];
          await getNeighbourhoodList(neighbourhoodList, value);
        }
      },
    );
  }

  Widget neighbourhood(RxList<NeighbourhoodModel> neighbourhoodList,
      String incoming, GlobalKey<FormFieldState> neighbourhoodKey) {
    return Obx(
      () => DropdownButtonFormField(
        key: neighbourhoodKey,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "Mahalle",
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
        items: neighbourhoodList
            .map(
              (e) => DropdownMenuItem(
                value: e.id,
                child: textWidget(
                    title: e.neighbourhoodName ?? "", fontsize: 13.sp),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (incoming.contains("customer")) {
            controller.customerAddressModel.value.neighbourhoodId = value;
          } else {
            controller.receiverAddressModel.value.neighbourhoodId = value;
          }
        },
      ),
    );
  }

  DropdownButtonFormField province(
      List<ProvinceModel> provinceList, String incoming) {
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "İl",
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
      items: provinceList
          .map(
            (e) => DropdownMenuItem(
              value: e.id,
              child: textWidget(title: e.provinceName ?? "", fontsize: 13.sp),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.provinceId = value;
        } else {
          controller.receiverAddressModel.value.provinceId = value;
        }
      },
    );
  }

  AtomicTextFormField addressTitle(String incoming) {
    return AtomicTextFormField(
      title: "Adres Adı",
      fontColor: Colors.grey.shade600,
      fontSize: 14.sp,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilemez";
        }
        return null;
      },
      onSaved: (newValue) {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.title = newValue?.trim();
        } else {
          controller.receiverAddressModel.value.title = newValue?.trim();
        }
      },
    );
  }

  Widget street(String incoming) {
    return AtomicTextFormField(
      title: "Sokak",
      fontColor: Colors.grey.shade600,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilemez";
        }
        return null;
      },
      onSaved: (newValue) {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.street = newValue?.trim();
        } else {
          controller.receiverAddressModel.value.street = newValue?.trim();
        }
      },
      fontSize: 15.sp,
    );
  }

  Widget apartmentAndFloorNo(String incoming) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: buildingNo(incoming)),
        Expanded(child: floorNo(incoming)),
        Expanded(child: apartmentNo(incoming))
      ],
    );
  }

  AtomicTextFormField buildingNo(String incoming) {
    return AtomicTextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      title: "Bina No",
      fontColor: Colors.grey.shade600,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilmez";
        }
        return null;
      },
      onSaved: (newValue) {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.buildingNo = newValue?.trim();
        } else {
          controller.receiverAddressModel.value.buildingNo = newValue?.trim();
        }
      },
      fontSize: 13.sp,
    );
  }

  Container floorNo(String incoming) {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(10),
      child: AtomicTextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        title: "Kat",
        fontColor: Colors.grey.shade600,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value?.isEmpty == true) {
            return "Boş Geçilmez";
          }
          return null;
        },
        onSaved: (newValue) {
          if (incoming.contains("customer")) {
            controller.customerAddressModel.value.floor =
                int.parse(newValue?.trim() ?? "");
          } else {
            controller.receiverAddressModel.value.floor =
                int.parse(newValue?.trim() ?? "");
          }
        },
        fontSize: 13.sp,
      ),
    );
  }

  AtomicTextFormField apartmentNo(String incoming) {
    return AtomicTextFormField(
      title: "Daire No",
      fontColor: Colors.grey.shade600,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilmez";
        }
        return null;
      },
      onSaved: (newValue) {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.apartmentNumber =
              newValue?.trim();
        } else {
          controller.receiverAddressModel.value.apartmentNumber =
              newValue?.trim();
        }
      },
      fontSize: 13.sp,
    );
  }

  Widget addressDescription(String incoming) {
    return AtomicTextFormField(
      title: "Adres Tarifi",
      fontColor: Colors.grey.shade600,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilmez";
        }
        return null;
      },
      onSaved: (newValue) {
        if (incoming.contains("customer")) {
          controller.customerAddressModel.value.description = newValue?.trim();
        } else {
          controller.receiverAddressModel.value.description = newValue?.trim();
        }
      },
    );
  }

  Widget receiverName() {
    return AtomicTextFormField(
      title: "Alıcı Adı Soyadı",
      fontColor: Colors.grey.shade600,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilmez";
        }
        return null;
      },
      onSaved: (newValue) {
        controller.receiverAddressModel.value.nameSurname = newValue?.trim();
      },
    );
  }

  TextFormField receiverPhoneNumber() {
    return TextFormField(
      onSaved: (newValue) {
        controller.receiverAddressModel.value.numberPhone = newValue?.trim();
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: CustomPadding.onlyHorizontalInset(10),
        labelText: "Alıcı GSM numarası",
        labelStyle:
            TextStyle(color: Colors.grey, fontFamily: "Arial", fontSize: 14.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      maxLength: 11,
      validator: (value) {
        if (value?.isNotEmpty == true) {
          if (value!.length < 11) {
            return "Lütfen 11 haneli bir telefon numarası giriniz";
          }
        } else {
          return "Boş Geçilemez";
        }
        return null;
      },
    );
  }

  Widget receiverMail() {
    return AtomicTextFormField(
      title: "Alıcı E-Posta",
      fontColor: Colors.grey.shade600,
      validator: (value) {
        if (value?.isEmpty == true) {
          return "Boş Geçilmez";
        }
        return null;
      },
      onSaved: (newValue) {
        controller.receiverAddressModel.value.email = newValue?.trim();
      },
    );
  }

  Column receiverInformation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        receiverName(),
        SizedBox(height: 10.h),
        receiverPhoneNumber(),
        SizedBox(height: 10.h),
        receiverMail(),
        SizedBox(height: 10.h),
      ],
    );
  }

  Future<void> getNeighbourhoodList(
      RxList<NeighbourhoodModel> neighbourhoodList, int districtId) async {
    Services service = Services();
    neighbourhoodList.value = await service.getNeighbourhoodList(
        districtId, controller.accessToken.value);
  }
}
