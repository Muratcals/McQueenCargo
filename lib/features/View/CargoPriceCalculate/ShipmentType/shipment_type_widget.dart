

part of '../ShipmentType/shipment_type_page.dart';

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _FileOrDocumentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 170.w,
      height: 110.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.contain,
            "images/file_icon.png",
            width: 80.w,
            height: 80.h,
          ),
          const Divider(color: Colors.grey, height: 0.5),
          Container(
            padding: EdgeInsets.all(5.r),
            child: InkWell(
              onTap: () {
                Get.toNamed("/priceInformation", arguments: {
                  "incoming": "DOSYA - EVRAK",
                  "price": 43.58,
                  "weight": 0.0
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GeneralTextWidget(
                          title: "Dosya-Evrak", fontsize: 14.sp)),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ParcelOrPackageWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 170.w,
      height: 110.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.contain,
            "images/parcel_icon.png",
            width: 80.w,
            height: 80.h,
          ),
          const Divider(color: Colors.grey, height: 0.5),
          Container(
            padding: EdgeInsets.all(5.r),
            child: InkWell(
              onTap: () {
                Get.toNamed("/parcelSending",
                    arguments: {"incoming": "calculate"});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GeneralTextWidget(
                          title: "Koli-Paket", fontsize: 14.sp)),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
