part of 'update_personal_page.dart';

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarIcon(),
      title: GeneralTextWidget(
          title: "Kişisel Bilgiler", fontsize: 14.sp, color: Colors.white),
      centerTitle: true,
      flexibleSpace: const AppbarFlexibleSpace(),
    );
  }
}

class _ColumnItems extends StatelessWidget {
  const _ColumnItems({required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomPadding.symmetricInset(10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GeneralTextWidget(
              title: title, fontsize: 13.sp, color: Colors.grey.shade500),
          GeneralTextWidget(
              title: value,
              fontsize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500)
        ],
      ),
    );
  }
}

class _UpdatePersonalBodyItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.symmetricInset(15, 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 5.h),
          _ColumnItems(
              title: "Ad", value: AuthInformation.auth.name!),
          _ColumnItems(
              title: "Soyad",
              value: AuthInformation.auth.surname!),
          _ColumnItems(
              title: "Tc Kimlik No",
              value:
                  "${AuthInformation.auth.tcNo!.substring(0, 3)}********"),
          _ColumnItems(
              title: "E-Posta",
              value: AuthInformation.auth.email!),
          _ColumnItems(
              title: "Cep Telefon No",
              value: AuthInformation.auth.numberPhone!),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }
}
