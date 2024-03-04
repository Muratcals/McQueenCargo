
part of  '../AddAddress/create_address_page.dart';

class _AddressProvince extends StatelessWidget {
  const _AddressProvince({
    required this.districtList,
    required this.provinceList,
    required this.neighbourhoodList,
    required this.incoming,
    required this.neighbourhoodKey,
  });

  final List<DistrictModel> districtList;
  final List<ProvinceModel> provinceList;
  final RxList<NeighbourhoodModel> neighbourhoodList;
  final String incoming;
  final GlobalKey<FormFieldState> neighbourhoodKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: CustomPadding.only(right: 10),
            child: _Province(provinceList: provinceList, incoming: incoming),
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Container(
            margin: CustomPadding.only(left: 15),
            child: _District(
                districtList: districtList,
                neighbourhoodList: neighbourhoodList,
                incoming: incoming,
                neighbourhoodKey: neighbourhoodKey),
          ),
        )
      ],
    );
  }
}

class _District extends StatelessWidget {
  const _District({
    required this.districtList,
    required this.neighbourhoodList,
    required this.incoming,
    required this.neighbourhoodKey,
  });

  final List<DistrictModel> districtList;
  final RxList<NeighbourhoodModel> neighbourhoodList;
  final String incoming;
  final GlobalKey<FormFieldState> neighbourhoodKey;

  Future<void> getNeighbourhoodList(
      RxList<NeighbourhoodModel> neighbourhoodList, int districtId) async {
    Services service = Services();
    PartnerController controller = Get.find();
    neighbourhoodList.value = await service.getNeighbourhoodList(
        districtId, controller.accessToken.value);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
          if (incoming.contains("customer")) {
            controller.customerAddressModel.value.districtId = value;
            neighbourhoodKey.currentState?.reset();
            neighbourhoodList.value = [];
            await getNeighbourhoodList(neighbourhoodList, value!);
          } else {
            controller.receiverAddressModel.value.districtId = value;
            neighbourhoodKey.currentState?.reset();
            neighbourhoodList.value = [];
            await getNeighbourhoodList(neighbourhoodList, value!);
          }
        },
      );
    });
  }
}

class _Neighbourhood extends StatelessWidget {
  const _Neighbourhood({
    required this.neighbourhoodList,
    required this.incoming,
    required this.neighbourhoodKey,
  });

  final RxList<NeighbourhoodModel> neighbourhoodList;
  final String incoming;
  final GlobalKey<FormFieldState> neighbourhoodKey;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetBuilder<PartnerController>(builder: (controller) {
        return DropdownButtonFormField(
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
                  child: GeneralTextWidget(
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
        );
      }),
    );
  }
}

class _Province extends StatelessWidget {
  const _Province({
    required this.provinceList,
    required this.incoming,
  });

  final List<ProvinceModel> provinceList;
  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
                child: GeneralTextWidget(
                    title: e.provinceName ?? "", fontsize: 13.sp),
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
    });
  }
}

class _AddressTitle extends StatelessWidget {
  const _AddressTitle({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _Street extends StatelessWidget {
  const _Street({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _ApartmentAndFloorNo extends StatelessWidget {
  const _ApartmentAndFloorNo({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _BuildingNo(incoming: incoming)),
        Expanded(child: _FoorNo(incoming: incoming)),
        Expanded(child: _ApartmentNo(incoming: incoming))
      ],
    );
  }
}

class _BuildingNo extends StatelessWidget {
  const _BuildingNo({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _FoorNo extends StatelessWidget {
  const _FoorNo({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _ApartmentNo extends StatelessWidget {
  const _ApartmentNo({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _ReceiverInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ReceiverName(),
        SizedBox(height: 10.h),
        _ReceiverPhoneNumber(),
        SizedBox(height: 10.h),
        _ReceiverMail(),
        SizedBox(height: 10.h),
      ],
    );
  }
}

class _ReceiverMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _ReceiverPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
          labelStyle: TextStyle(
              color: Colors.grey, fontFamily: "Arial", fontSize: 14.sp),
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
    });
  }
}

class _ReceiverName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
    });
  }
}

class _AddressDescription extends StatelessWidget {
  const _AddressDescription({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
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
            controller.customerAddressModel.value.description =
                newValue?.trim();
          } else {
            controller.receiverAddressModel.value.description =
                newValue?.trim();
          }
        },
      );
    });
  }
}
