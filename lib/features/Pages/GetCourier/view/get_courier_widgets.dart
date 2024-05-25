part of 'get_courier_page.dart';

class _GetCourierBody extends StatefulWidget {
  const _GetCourierBody();

  @override
  State<_GetCourierBody> createState() => _GetCourierBodyState();
}

class _GetCourierBodyState extends State<_GetCourierBody> {
  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 40.h),
          _SelectedAddressContainer(),
          SizedBox(height: 30.h),
          _BottomContainer(
            carouselController: CarouselController(),
          )
        ],
      ),
    );
  }
}

class _BottomContainer extends StatelessWidget {
  const _BottomContainer({
    required this.carouselController,
  });

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourierCubit, GetCourierState>(
      builder: (context, state) {
        return state.customerAddress != null && state.receiverAddress != null
            ? Container(
                margin: CustomPadding.onlyHorizontalInset(15),
                padding: CustomPadding.allInset(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: _BottomContainerColumn(
                  carouselController: carouselController,
                ),
              )
            : Container();
      },
    );
  }
}

class _BottomContainerColumn extends StatelessWidget {
  const _BottomContainerColumn({
    required this.carouselController,
  });

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourierCubit, GetCourierState>(
      builder: (context, state) {
        return state.customerAddress != null && state.receiverAddress != null
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    items: [
                      _SelectedDateWidget(
                          carouselController: carouselController),
                      _SelectedCargoType(),
                    ],
                    disableGesture: true,
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.9,
                        aspectRatio: 1.4,
                        initialPage: 0,
                        scrollPhysics: context
                                    .read<GetCourierCubit>()
                                    .state
                                    .selectedDate ==
                                0
                            ? const NeverScrollableScrollPhysics()
                            : null),
                  ),
                ],
              )
            : Container();
      },
    );
  }
}

class _SelectedDateWidget extends StatelessWidget {
  const _SelectedDateWidget({
    required this.carouselController,
  });

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourierCubit, GetCourierState>(
        builder: (context, state) {
      return Column(
        children: [
          Text(
            "Gönderiniz hangi tarihte göndermek istiyorsunuz",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
          ),
          SizedBox(height: 3.h),
          Divider(
            color: Colors.grey,
            height: 1.h,
          ),
          SizedBox(height: 3.h),
          Container(
            padding: CustomPadding.symmetricInset(10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      carouselController.nextPage();
                      context
                          .read<GetCourierCubit>()
                          .changeValue(selectedDate: 1);
                      context
                          .read<GetCourierPostCubit>()
                          .state
                          .cargoRealeseDate = DateTime.now();
                    },
                    child: _DateView(
                      title: "Bugün",
                      date: DateTime.now(),
                      selectedValue: 1,
                    )),
                InkWell(
                  onTap: () {
                    carouselController.nextPage();
                    context
                        .read<GetCourierCubit>()
                        .changeValue(selectedDate: 2);
                    context.read<GetCourierPostCubit>().state.cargoRealeseDate =
                        DateTime.now().add(const Duration(days: 1));
                  },
                  child: _DateView(
                    title: "Yarın",
                    date: DateTime.now().add(const Duration(days: 1)),
                    selectedValue: 2,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _SelectedAddressContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourierCubit, GetCourierState>(
      builder: (context, state) {
        return Container(
          padding: CustomPadding.allInset(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: Colors.grey, width: 0.5),
            color: Colors.white,
          ),
          margin: CustomPadding.onlyHorizontalInset(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () async {
                  var model = await Get.toNamed(GenerateRoute.addressPage,
                      arguments: {
                        "incoming": "customer",
                        "process": "getCourier"
                      });
                  if (model != null) {
                    context
                        .read<GetCourierCubit>()
                        .changeValue(addressModel: model as AddressModel);
                    context
                        .read<GetCourierPostCubit>()
                        .changeCustomerMobilAdressId(model.id ?? 0);
                  }
                },
                child: Container(
                  padding: CustomPadding.allInset(5),
                  child: _SelectedAddressColumnItem(
                      icon: "images/future_location_icon.png",
                      title: state.customerAddress?.title ??
                          "Gönderici Adresi Seçiniz",
                      district: state.customerAddress?.districtName,
                      provinceName: state.customerAddress?.provinceName),
                ),
              ),
              SizedBox(height: 5.h),
              Divider(
                color: Colors.grey,
                height: 1.h,
              ),
              SizedBox(height: 5.h),
              InkWell(
                onTap: () async {
                  var model = await Get.toNamed(GenerateRoute.addressPage,
                      arguments: {
                        "incoming": "receiver",
                        "process": "getCourier"
                      });
                  if (model != null) {
                    context.read<GetCourierCubit>().changeValue(
                        receiverAddressModel: model as ReceiverAddressModel);
                    context
                        .read<GetCourierPostCubit>()
                        .changeReceiverId(model.id ?? 0);
                  }
                },
                child: Container(
                  padding: CustomPadding.allInset(5),
                  child: _SelectedAddressColumnItem(
                      icon: "images/is_will_location_icon.png",
                      title: state.receiverAddress?.title ??
                          "Alıcı Adresi Seçiniz",
                      district: state.receiverAddress?.districtName,
                      provinceName: state.receiverAddress?.provinceName),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SelectedAddressColumnItem extends StatelessWidget {
  const _SelectedAddressColumnItem({
    required this.icon,
    required this.title,
    this.district,
    this.provinceName,
  });
  final String icon;
  final String title;
  final String? district;
  final String? provinceName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          icon,
          width: 25,
          height: 25,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GeneralTextWidget(
                title: title, fontsize: 13.sp, fontWeight: FontWeight.bold),
            district == null
                ? Container()
                : GeneralTextWidget(
                    title: "$district/$provinceName",
                    fontsize: 14.sp,
                    fontWeight: FontWeight.normal),
          ],
        ),
        const Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.chevron_right)),
        )
      ],
    );
  }
}

class _DateView extends StatelessWidget {
  _DateView({
    required this.selectedValue,
    required this.title,
    required this.date,
  });

  final int selectedValue;
  final String title;
  final DateTime date;

  final List<String> months = [
    "",
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourierCubit, GetCourierState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: Colors.green, width: 1.h),
            color: state.selectedDate == selectedValue
                ? Colors.green
                : Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: CustomPadding.symmetricInset(30, 3),
              color: Colors.white,
              child: GeneralTextWidget(
                  title: title, fontsize: 14.sp, color: Colors.grey),
            ),
            Container(
              padding: CustomPadding.onlyHorizontalInset(25),
              child: GeneralTextWidget(
                  title: months[date.month],
                  fontsize: 15.sp,
                  color: state.selectedDate == selectedValue
                      ? Colors.white
                      : Colors.green),
            ),
            GeneralTextWidget(
                title: date.day.toString(),
                fontsize: 35.sp,
                fontWeight: FontWeight.bold,
                color: state.selectedDate == selectedValue
                    ? Colors.white
                    : Colors.green),
            GeneralTextWidget(
                title: DateFormat('EEEE', "tr").format(date),
                fontsize: 13.sp,
                fontWeight: FontWeight.normal,
                color: state.selectedDate == selectedValue
                    ? Colors.white
                    : Colors.green),
            SizedBox(
              height: 4.h,
            )
          ],
        ),
      );
    });
  }
}

class _SelectedCargoType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourierCubit, GetCourierState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 20.h,
              child: Text(
                "Lütfen gönderi tipini seçiniz",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5.h),
            Divider(
              color: Colors.grey,
              height: 1.h,
            ),
            SizedBox(height: 5.h),
            Container(
              padding: CustomPadding.symmetricInset(5, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        if (state.selectedDate == null) {
                          EasyLoading.showToast("Lütfen bir tarih seçiniz");
                        } else {
                          context
                              .read<GetCourierPostCubit>()
                              .state
                              .cargoParcelTypeId = 5;
                          context
                              .read<GetCourierPostCubit>()
                              .state
                              .customerMobilId = Auth.authId;
                          Get.toNamed(GenerateRoute.selectedPostType,
                              arguments: {
                                "price": 43.58 - (43.58 * 25) / 100,
                                "type": "DOSYA - EVRAK",
                                "weight": 2.0
                              });
                        }
                      },
                      child: const _CargoType(
                          icon: "images/file_icon.png", title: "Dosya-Evrak")),
                  InkWell(
                      onTap: () {
                        if (state.selectedDate == null) {
                          EasyLoading.showToast("Lütfen bir tarih seçiniz");
                        } else {
                          context
                              .read<GetCourierPostCubit>()
                              .state
                              .cargoParcelTypeId = 6;
                          context
                              .read<GetCourierPostCubit>()
                              .state
                              .customerMobilId = Auth.authId;
                          Get.toNamed(GenerateRoute.parcelSending, arguments: {
                            "incoming": "getCourier",
                          });
                        }
                      },
                      child: const _CargoType(
                          icon: "images/parcel_icon.png", title: "Koli-Paket")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CargoType extends StatelessWidget {
  const _CargoType({required this.icon, required this.title});
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          width: 80.w,
          height: 60.h,
        ),
        Container(
          padding: CustomPadding.onlyHorizontalInset(
            15,
          ),
          child: GeneralTextWidget(
            title: title,
            fontsize: 15.sp,
          ),
        ),
        SizedBox(
          height: 4.h,
        )
      ],
    );
  }
}
