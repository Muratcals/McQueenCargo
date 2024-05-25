part of 'home_page.dart';

class _SearchCargoTextForm extends StatefulWidget {
  const _SearchCargoTextForm({
    required this.service,
  });
  final Services service;

  @override
  State<_SearchCargoTextForm> createState() => _SearchCargoTextFormState();
}

class _SearchCargoTextFormState extends State<_SearchCargoTextForm> {
  late String trackingNo;
  @override
  void initState() {
    super.initState();
    trackingNo = "";
  }

  Future<void> onPressed() async {
    if (trackingNo.isEmpty) {
      EasyLoading.showToast("Lütfen bir kargo numarası giriniz");
    } else {
      await widget.service
          .getTrackingCargo(
              trackingNo: trackingNo, incoming: "Cargo")
          .then((value) {
        setState(() {
          trackingNo = "";
        });
        Get.toNamed("cargoDetailPage",
            arguments: {"cargoId": value.id});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: (MediaQuery.sizeOf(context).height * 9) / 100,
          left: 10.w,
          right: 10.w),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.black)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Gönderi Ara",
          hintStyle: TextStyle(
              color: Colors.black, fontFamily: "times", fontSize: 13.sp),
          suffixIcon: IconButton(
              onPressed: () async {
                await onPressed();
              },
              icon: const Icon(Icons.search)),
        ),
        onChanged: (newValue) {
          trackingNo = newValue;
        },
      ),
    );
  }

  
}

class _ProfilIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.onlyHorizontalInset(
        10,
      ),
      child: InkWell(
        onTap: () {
          if (Auth.authId != 0) {
            context.read<SelectedBottomSheet>().changeValue("myProfile");
          } else {
            Get.toNamed("/loginPage");
          }
        },
        child: const CircleAvatar(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CustomPadding.symmetricInset(15, 5),
      child: InkWell(
          onTap: () async {
            if (title == "Giriş Yap / Üye Ol") {
              await Get.toNamed("/loginPage");
            }
          },
          child: GeneralTextWidget(
              title: title, fontsize: 14.sp, color: Colors.white)),
    );
  }
}

class _HomePageAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (MediaQuery.sizeOf(context).height * 13) / 100,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.blue.shade700
          ],
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _LoginButtonWidget(
              title: Auth.authId != 0
                  ? "HOŞGELDİN ${AuthInformation.auth.name}"
                  : "Giriş Yap / Üye Ol"),
          _ProfilIconWidget()
        ],
      ),
    );
  }
}
