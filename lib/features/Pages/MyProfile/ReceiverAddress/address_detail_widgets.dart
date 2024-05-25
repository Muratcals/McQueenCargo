part of 'address_detail_page.dart';

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GeneralTextWidget(
          title: "Adres Detayı", fontsize: 15.sp, color: Colors.white),
      centerTitle: true,
      toolbarHeight: 27.h,
      leading: const AppBarIcon(),
      flexibleSpace: const AppbarFlexibleSpace(),
    );
  }
}

class _CustomerAddressIformationColumn extends StatelessWidget {
  const _CustomerAddressIformationColumn({required this.model});
  final ReceiverAddressModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          _ColumnItems(title: "Adres Tipi", subTitle: model.title),
          _ColumnItems(title: "Mahalle", subTitle: model.neighbourhoodName),
          _ColumnItems(title: "Cadde/Sokak", subTitle: model.street),
          _ColumnItems(title: "Bina No", subTitle: model.buildingNo),
          _ColumnItems(title: "Daire No", subTitle: model.apartmentNumber),
          _ColumnItems(title: "İlçe", subTitle: model.districtName),
          _ColumnItems(title: "İl", subTitle: model.provinceName),
          _ColumnItems(title: "Adres Tarifi", subTitle: model.description),
          _FullAddressText(model: model)
        ],
      ),
    );
  }
}

class _FullAddressText extends StatelessWidget {
  const _FullAddressText({required this.model});
  final ReceiverAddressModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120.w,
              child: GeneralTextWidget(
                  title: "Tam Adres", fontsize: 14.sp, color: Colors.grey)),
          Expanded(
            child: Text(
              "${model.neighbourhoodName} ${model.street} No: ${model.buildingNo} Kat: ${model.apartmentNumber} D: ${model.apartmentNumber}",
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
}

class _ColumnItems extends StatelessWidget {
  const _ColumnItems({required this.title, this.subTitle});
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 150.w,
              child: GeneralTextWidget(
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

class _ColumnTitle extends StatelessWidget {
  const _ColumnTitle({required this.model});
  final ReceiverAddressModel model;

  @override
  Widget build(BuildContext context) {
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
                GeneralTextWidget(
                    title: model.title!,
                    fontsize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 5),
                GeneralTextWidget(
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
}

class _ReceiverAddressInformation extends StatelessWidget {
  const _ReceiverAddressInformation({required this.model});
  final ReceiverAddressModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ReceiverAddressColumnItems(
          model: model,
        ),
        _CustomerAddressIformationColumn(model: model)
      ],
    );
  }
}

class _ReceiverAddressColumnItems extends StatelessWidget {
  const _ReceiverAddressColumnItems({required this.model});
  final ReceiverAddressModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          _ColumnItems(title: "Alıcı Adı", subTitle: model.nameSurname),
          _ColumnItems(
              title: "Alıcı GSM Numarası", subTitle: model.numberPhone),
          _ColumnItems(title: "Alıcı E-Posta", subTitle: model.email),
        ],
      ),
    );
  }
}

class _AddressDetailList extends StatelessWidget {
  const _AddressDetailList({required this.model, required this.onPressedButton});
  final ReceiverAddressModel model;
  final Function() onPressedButton;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: CustomPadding.symmetricInset(15, 10),
            padding: CustomPadding.allInset(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ColumnTitle(model: model),
                _ReceiverAddressInformation(model: model),
              ],
            ),
          ),
          _DeleteAddressButton(
            onPressedButton: () => onPressedButton(),
          )
        ],
      ),
    );
    
  }
}

class _DeleteAddressButton extends StatelessWidget {
  const _DeleteAddressButton({required this.onPressedButton});
  final Function() onPressedButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(50),
      child: AtomicOrangeButton(
          onPressed: () async {
            await onPressedButton();
          },
          title: "Adresi Sil"),
    );
  }
}