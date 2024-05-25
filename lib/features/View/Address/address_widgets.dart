part of '../Address/address_page.dart';

class _CustomerAddresslistItems extends StatelessWidget {
  const _CustomerAddresslistItems({required this.item, required this.process, required this.setStatePage});
  final  AddressModel item;
      final  String process;
      final  Function(int state) setStatePage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (process.contains("getCourier")) {
          Get.back(result: item);
        } else {
          var result = await Get.toNamed("/customerAddressInformationPage",
              arguments: {"addressId": item.id});
          if (result != null) {
            setStatePage(result);
          }
        }
      },
      child: Container(
        margin: CustomPadding.onlyHorizontalInset(5),
        padding: CustomPadding.symmetricInset(10, 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.home,
                color: Colors.grey.shade600,
                size: 40,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GeneralTextWidget(
                      title: item.title ?? "",
                      fontsize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  GeneralTextWidget(
                      title: "${item.districtName}/${item.provinceName}",
                      fontsize: 13.sp,
                      color: Colors.grey.shade500),
                  SizedBox(height: 3.h),
                  GeneralTextWidget(
                      color: Colors.grey.shade700,
                      title:
                          "${item.neighbourhoodName} ${item.street} No:${item.buildingNo} D:${item.apartmentNumber}",
                      fontsize: 13.sp)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ReceiverAddresslistItems extends StatelessWidget {
  const _ReceiverAddresslistItems({ required this.item, required this.process, required this.setStatePage});

      final ReceiverAddressModel item;
      final String process;
      final Function(dynamic state) setStatePage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (process.contains("getCourier")) {
          Get.back(result: item);
        } else {
          var result = await Get.toNamed("/receiverAddressInformationPage",
              arguments: {"addressId": item.id});
          if (result != null) {
            setStatePage(result);
          }
        }
      },
      child: Container(
        margin: CustomPadding.onlyHorizontalInset(5),
        padding: CustomPadding.symmetricInset(10, 5),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.home,
                color: Colors.grey.shade600,
                size: 40,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GeneralTextWidget(
                      title: item.title!,
                      fontsize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  GeneralTextWidget(
                      title: "${item.districtName}/${item.provinceName}",
                      fontsize: 12.sp,
                      color: Colors.grey.shade500),
                  SizedBox(height: 5.h),
                  GeneralTextWidget(
                      color: Colors.grey.shade700,
                      title:
                          "${item.neighbourhoodName} ${item.street} No:${item.buildingNo} D:${item.apartmentNumber}",
                      fontsize: 12.sp)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarBottomItem extends StatelessWidget {
  const _AppBarBottomItem({required this.incoming, required this.reload});

  final String incoming;
  final Function() reload;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      builder: (controller) {
        return Container(
          alignment: Alignment.center,
          margin: CustomPadding.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey.shade500, width: 1.w),
            ),
          ),
          child: TextButton(
            onPressed: () async {
              await Get.toNamed("createAddressPage", arguments: incoming);
              reload();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.orange,
                ),
                GeneralTextWidget(
                    title: incoming.contains("customer")
                        ? "Gönderici Adresi Ekle"
                        : "Alıcı Adresi Ekle",
                    fontsize: 14.sp,
                    color: Colors.orange)
              ],
            ),
          ),
        );
      }
    );
  }
}
