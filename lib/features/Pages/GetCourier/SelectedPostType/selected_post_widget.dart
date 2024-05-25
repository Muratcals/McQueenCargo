part of 'selected_post_type_page.dart';

class _SelectedPostBody extends StatefulWidget {
  _SelectedPostBody(
      {required this.service,
      required this.type,
      required this.price,
      required this.weight});

  final Services service;
  final String type;
  double weight;
  double price;

  @override
  State<_SelectedPostBody> createState() => _SelectedPostBodyState();
}

class _SelectedPostBodyState extends State<_SelectedPostBody> {
  @override
  Widget build(BuildContext context) {
    return AtomicFutureBuilder(
      future: Future.wait([
        widget.service.getCustomerAddress(
            addressId: context
                    .read<GetCourierPostCubit>()
                    .state
                    .customerMobilAdressId ??
                0),
        widget.service.getReceiverAddress(
            addressId:
                context.read<GetCourierPostCubit>().state.receiverId ?? 0)
      ]),
      child: (model) {
        AddressModel customerAddressModel = model[0];
        ReceiverAddressModel receiverAddressModel = model[1];
        return Container(
          margin: CustomPadding.symmetricInset(15, 5),
          child: Column(
            children: [
              CourierInformation(
                  customerAddressModel: customerAddressModel,
                  receiverAddressModel: receiverAddressModel,
                  type: widget.type),
              _SelectedPriceText(),
              _SelectedCargoPrice(
                price: widget.price,
              ),
              _NextButton(
                  price: widget.price, type: widget.type, weight: widget.weight)
            ],
          ),
        );
      },
      onError: () => setState(() {}),
    );
  }
}

class _SelectedPriceText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      child: GeneralTextWidget(
          title: "Gönderinizi nasıl göndermemizi istersiniz", fontsize: 16.sp),
    );
  }
}

class _SelectedCargoPrice extends StatelessWidget {
  const _SelectedCargoPrice({
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedPostTypeCubit, SelectedPostTypeState>(
      builder: (context, state) {
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
                groupValue: state.selectedValue,
                onChanged: (value) {
                  context
                      .read<SelectedPostTypeCubit>()
                      .changeState(selectedValue: value);
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralTextWidget(
                        title: "STANDART",
                        fontsize: 14.sp,
                        fontWeight: FontWeight.bold),
                    GeneralTextWidget(
                        title:
                            "Tüm türkiye geneline standart taşıma hizmetidir.",
                        fontsize: 12.sp,
                        color: Colors.grey),
                  ],
                ),
              ),
              Container(
                padding: CustomPadding.onlyHorizontalInset(10),
                child: GeneralTextWidget(
                    title: "${price.toStringAsFixed(2)} TL",
                    fontsize: 17.sp,
                    color: Colors.green),
              )
            ],
          ),
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.price,
    required this.type,
    required this.weight,
  });

  final double price;
  final String type;
  final double weight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedPostTypeCubit, SelectedPostTypeState>(
      builder: (context, state) {
        return Container(
          margin: CustomPadding.onlyVerticalInset(20),
          child: state.selectedValue == 0
              ? AtomicOrangeButton(
                  onPressed: () async {
                    await Get.toNamed(GenerateRoute.additionalServicePage,
                        arguments: {
                          "price": price,
                          "type": type,
                          "weight": weight,
                        });
                    AdditionalServicePrice.packageProcurementServices.clear();
                    AdditionalServicePrice.packageProcurementServices.addAll([
                      AdditionalServiceModel(
                          name: "Adresten Alım", price: 24.46),
                      AdditionalServiceModel(name: "Şubeye Teslim", price: 0.0)
                    ]);
                    AdditionalServicePrice.packageDeliveryServices.clear();
                    AdditionalServicePrice.packageDeliveryServices.addAll([
                      AdditionalServiceModel(
                          name: "Adrese Teslimat", price: 24.46),
                      AdditionalServiceModel(name: "Şubeye Teslim", price: 6.27)
                    ]);
                  },
                  title: "Devam Et")
              : Container(),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: AppBarIcon(),
      toolbarHeight: 30.h,
      flexibleSpace: const AppbarFlexibleSpace(),
      title:
          GeneralTextWidget(title: title, fontsize: 14.sp, color: Colors.white),
    );
  }
}
