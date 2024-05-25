part of 'create_address_page.dart';

class _AddressProvince extends StatelessWidget {
  const _AddressProvince({
    required this.incoming,
    required this.neighbourhoodKey,
  });
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
            child: _Province(incoming: incoming),
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Container(
            margin: CustomPadding.only(left: 15),
            child: DistrictPage(
              neighbourhoodKey: neighbourhoodKey,
              incoming: incoming,
            ),
          ),
        )
      ],
    );
  }
}

class _Neighbourhood extends StatelessWidget {
  const _Neighbourhood({
    required this.incoming,
    required this.neighbourhoodKey,
  });

  final String incoming;
  final GlobalKey<FormFieldState> neighbourhoodKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NeighbourhoodController, List<NeighbourhoodModel>>(
      builder: (context, state) {
        return DropdownButtonFormField(
            key: neighbourhoodKey,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "Mahalle",
              labelStyle:
                  TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
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
            items: state
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
                context
                    .read<CustomerAddressController>()
                    .changeNeighbourhoodId(value ?? 0);
              } else {
                context
                    .read<ReceiverAddressController>()
                    .changeNeighbourhoodId(value ?? 0);
              }
            });
      },
    );
  }
}

class _Province extends StatelessWidget {
  _Province({
    required this.incoming,
  });
  final Services service = Services();
  final String incoming;

  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
        future: service.getProvinceList(),
        child: (model) {
          List<ProvinceModel> provinceList = model;
          return DropdownButtonFormField(
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "İl",
              labelStyle:
                  TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
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
                context
                    .read<CustomerAddressController>()
                    .changeProvinceId(value ?? 0);
              } else {
                context
                    .read<ReceiverAddressController>()
                    .changeProvinceId(value ?? 0);
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
          context
              .read<CustomerAddressController>()
              .changeTitle(newValue?.trim() ?? "");
        } else {
          context
              .read<ReceiverAddressController>()
              .changeTitle(newValue?.trim() ?? "");
        }
      },
    );
  }
}

class _Street extends StatelessWidget {
  const _Street({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
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
          context
              .read<CustomerAddressController>()
              .changeStreetId(newValue?.trim() ?? "");
        } else {
          context
              .read<ReceiverAddressController>()
              .changeStreetId(newValue?.trim() ?? "");
        }
      },
      fontSize: 15.sp,
    );
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
        Expanded(child: _FolorNo(incoming: incoming)),
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
          context
              .read<CustomerAddressController>()
              .changebuildingNo(newValue?.trim() ?? "");
        } else {
          context
              .read<ReceiverAddressController>()
              .changebuildingNo(newValue?.trim() ?? "");
        }
      },
      fontSize: 13.sp,
    );
  }
}

class _FolorNo extends StatelessWidget {
  const _FolorNo({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
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
            context
                .read<CustomerAddressController>()
                .changeFloor(int.parse(newValue?.trim() ?? "0"));
          } else {
            context
                .read<ReceiverAddressController>()
                .changeFloor(int.parse(newValue?.trim() ?? "0"));
          }
        },
        fontSize: 13.sp,
      ),
    );
  }
}

class _ApartmentNo extends StatelessWidget {
  const _ApartmentNo({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
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
          context
              .read<CustomerAddressController>()
              .changeApartmenNumber(newValue ?? "");
        } else {
          context
              .read<ReceiverAddressController>()
              .changeApartmenNumber(newValue ?? "");
        }
      },
      fontSize: 13.sp,
    );
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
        context
            .read<ReceiverAddressController>()
            .changeEmail(newValue?.trim() ?? "");
      },
    );
  }
}

class _ReceiverPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        context
            .read<ReceiverAddressController>()
            .changeNumberPhone(newValue?.trim() ?? "");
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
}

class _ReceiverName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        context
            .read<ReceiverAddressController>()
            .changeName(newValue?.trim() ?? "");
      },
    );
  }
}

class _AddressDescription extends StatelessWidget {
  const _AddressDescription({
    required this.incoming,
  });

  final String incoming;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerAddressController, AddressModel>(
        builder: (context, state) {
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
            context
                .read<CustomerAddressController>()
                .changeDescription(newValue?.trim() ?? "");
          } else {
            context
                .read<ReceiverAddressController>()
                .changeDescription(newValue?.trim() ?? "");
          }
        },
      );
    });
  }
}
