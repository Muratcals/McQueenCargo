
part of  '../Main/main_page.dart';

class _BottomSheetPage extends StatelessWidget {
  const _BottomSheetPage(
    this.value,
  );
  final String value;
  @override
  Widget build(BuildContext context) {
    if (value.contains("main")) {
      return const HomePage();
    } else if (value.contains("myCargos")) {
      return const GetCourierCargosPage();
    } else if (value.contains("getCourier")) {
      return const GetCourierPage();
    } else if (value.contains("calculatePrice")) {
      return const CargoPricaCalculatePage();
    } else {
      return const MyProfilePage();
    }
  }
}

class _MainPageDesign extends StatelessWidget {
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<PartnerController>(
        builder: (controller) {
          return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Obx(
              () {
                return _BottomSheetPage(controller.selectedBottomSheet.value);
              },
            ),
          ),
              );
        }
      );
    }
  }

  class _MainAppBar extends StatelessWidget {
  
    @override
    Widget build(BuildContext context) {
      return AppBar(
      title: Text(
        "McQueenCargo",
        style: TextStyle(
            color: Colors.white, fontSize: 14.sp, fontFamily: "appBar"),
      ),
      leading: Container(),
      flexibleSpace: const AppbarFlexibleSpace(),
      centerTitle: true,
      toolbarHeight: 20.h,
      elevation: 0,
    );
    }
  }
