part of 'approve_page.dart';

class _CargoSaveButton extends StatelessWidget {
  const _CargoSaveButton({required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AtomicOrangeButton(onPressed: onPressed, title: "Onayla");
  }
}

class _InformationText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(
      "Seçimize göre tahmini gönderi bedeli üst sınırdan hesaplanacak, gerçek fiyat ise şubede kargonuzun ölçüm tartım işlemleri gerçekleştikten sonra belirlenecektir.",
      style: TextStyle(color: Colors.red, fontSize: 12.sp),
      textAlign: TextAlign.center,
    );
  }
}

class _ApproveColumnItems extends StatelessWidget {
  const _ApproveColumnItems({
    required this.type,
    required this.deliveryIndex,
    required this.price,
    required this.tax,
    required this.sumPrice,
  });

  final String type;
  final int deliveryIndex;
  final double price;
  final double tax;
  final double sumPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: Colors.grey, height: 1.h),
        SizedBox(height: 10.h),
        _AdditionalServices(
            type: type, deliveryIndex: deliveryIndex),
        SizedBox(height: 10.h),
        Divider(color: Colors.grey, height: 1.h),
        SizedBox(height: 5.h),
        _PriceInformation(price: price, tax: tax, sumPrice: sumPrice),
        SizedBox(height: 10.h),
        Divider(color: Colors.grey, height: 1.h),
        SizedBox(height: 5.h),
        _PaymentType(),
      ],
    );
  }
}

class _PaymentType extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralTextWidget(
            title: "Ödeme", fontsize: 13.sp, fontWeight: FontWeight.bold),
        SizedBox(height: 5.h),
        Row(
          children: [
            Icon(
              Icons.wallet,
              size: 20.r,
            ),
            SizedBox(width: 5.w),
            GeneralTextWidget(
                title: "Nakit Ödeme",
                fontsize: 13.sp,
                color: Colors.grey.shade700)
          ],
        )
      ],
    );
  }
}

class _PriceInformation extends StatelessWidget {
  const _PriceInformation({
    required this.price,
    required this.tax,
    required this.sumPrice,
  });

  final double price;
  final double tax;
  final double sumPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralTextWidget(
            title: "Fiyat Bilgisi",
            fontsize: 13.sp,
            fontWeight: FontWeight.bold),
        SizedBox(height: 5.h),
        _PriceInformationColumnItems(
            title: "Toplam Fiyat:  ",
            subTitle: "${price.toStringAsFixed(2)} TL"),
        SizedBox(height: 5.h),
        _PriceInformationColumnItems(
            title: "Toplam Kdv:  ", subTitle: "${tax.toStringAsFixed(2)} TL"),
        SizedBox(height: 5.h),
        _PriceInformationColumnItems(
            title: "GENEL TOPLAM:  ",
            subTitle: "${sumPrice.toStringAsFixed(2)} TL")
      ],
    );
  }
}

class _PriceInformationColumnItems extends StatelessWidget {
  const _PriceInformationColumnItems({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GeneralTextWidget(
            title: title,
            fontsize: 13.sp,
            fontWeight: title.contains("GENEL TOPLAM")
                ? FontWeight.bold
                : FontWeight.normal,
            color: Colors.grey.shade700),
        GeneralTextWidget(
            title: subTitle,
            fontsize: 13.sp,
            fontWeight: title.contains("GENEL TOPLAM")
                ? FontWeight.bold
                : FontWeight.normal,
            color: title.contains("GENEL TOPLAM")
                ? Colors.green
                : Colors.grey.shade700)
      ],
    );
  }
}

class _AdditionalServices extends StatelessWidget {
  const _AdditionalServices({
    required this.type,
    required this.deliveryIndex,
  });

  final String type;
  final int deliveryIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GeneralTextWidget(
            title: "Ek Hizmetler",
            fontsize: 13.sp,
            fontWeight: FontWeight.bold),
        SizedBox(height: 5.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const _AddionatiolServiceRowItems(title: "Adresten Alım"),
            SizedBox(width: 5.h),
            _AddionatiolServiceRowItems(
                title: type == "KOLİ - PAKET"
                    ? AdditionalServicePrice.packageDeliveryServices[deliveryIndex].name
                    : AdditionalServicePrice.fileDeliveryServices[deliveryIndex].name)
          ],
        )
      ],
    );
  }
}

class _AddionatiolServiceRowItems extends StatelessWidget {
  const _AddionatiolServiceRowItems({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 8.r,
          child: Icon(
            Icons.done,
            size: 10.r,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 3.h),
        GeneralTextWidget(title: title, fontsize: 13.sp)
      ],
    );
  }
}
