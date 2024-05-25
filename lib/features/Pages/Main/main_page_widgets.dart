part of 'main_page.dart';

class _BottomSheetPage extends StatelessWidget {
  const _BottomSheetPage();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedBottomSheet, String>(
      builder: (context, state) {
        if (state.contains("main")) {
          return const HomePage();
        } else if (state.contains("myCargos")) {
          return const GetCourierCargosPage();
        } else if (state.contains("getCourier")) {
          return const GetCourierPage();
        } else if (state.contains("calculatePrice")) {
          return const CargoPricaCalculatePage();
        } else {
          return const MyProfilePage();
        }
      },
    );
  }
}

class _MainPageDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(child: _BottomSheetPage()),
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
