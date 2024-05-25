part of  '../SelectedPostType/selected_post_type_page.dart';

class _SelectedPostBody extends StatelessWidget {
  _SelectedPostBody(
      {required this.service,
      required this.type,
      required this.price,
      required this.weight,
      required this.selectedValue});

  final Services service;
  final String type;
  double weight;
  double price;
  RxInt selectedValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(builder: (controller) {
      return AtomicFutureBuilder(
        future: Future.wait([
          service.getCustomerAddress(
              addressId:
                  controller.getCourierModel.value.customerMobilAdressId ?? 0),
          service.getReceiverAddress(
              addressId: controller.getCourierModel.value.receiverId ?? 0)
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
                    type: type),
                _SelectedPriceText(),
                _SelectedCargoPrice(
                  price: price,
                  selectedValue: selectedValue,
                ),
                _NextButton(
                    price: price,
                    selectedValue: selectedValue,
                    type: type,
                    weight: weight)
              ],
            ),
          );
        },
      );
    });
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
    required this.selectedValue,
    required this.price,
  });

  final RxInt selectedValue;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
              groupValue: selectedValue.value,
              onChanged: (value) {
                selectedValue.value = value ?? 0;
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
                      title: "Tüm türkiye geneline standart taşıma hizmetidir.",
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
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.selectedValue,
    required this.price,
    required this.type,
    required this.weight,
  });

  final RxInt selectedValue;
  final double price;
  final String type;
  final double weight;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller) {
        return Obx(
          () => Container(
            margin: CustomPadding.onlyVerticalInset(20),
            child: selectedValue.value == 0
                ? AtomicOrangeButton(
                    onPressed: () async {
                      await Get.toNamed("additionalServicePage", arguments: {
                        "price": price,
                        "type": type,
                        "weight": weight,
                      });
                      controller.packageProcurementServices.clear();
                      controller.packageProcurementServices.addAll([
                        AdditionalServiceModel(
                            name: "Adresten Alım", price: 24.46),
                        AdditionalServiceModel(
                            name: "Şubeye Teslim", price: 0.0)
                      ]);
                    },
                    title: "Devam Et")
                : Container(),
          ),
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
