part of 'price_detail_page.dart';

class _ColumnItemsAppBar extends StatelessWidget {
  const _ColumnItemsAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo.shade200,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
      padding: CustomPadding.allInset(15),
      child: GeneralTextWidget(
        title: "TAMAMLAYICI / EK HİZMETLER",
        fontsize: 14.sp,
        color: Colors.white,
      ),
    );
  }
}

class _FinishButton extends StatelessWidget {
  const _FinishButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 1.5,
      child: AtomicOrangeButton(
          onPressed: () async {
            Get.until((route) => Get.currentRoute == "/main");
            // Get.offAllNamed("/main", arguments: {"userId": 0});
          },
          title: "Bitir"),
    );
  }
}
