import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mc_queen_cargo/features/Controller/partner_controller.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/AddionatialService/additiona_service_page.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/Approve/approve_page.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/SelectedPostType/selected_post_type_page.dart';
import 'package:mc_queen_cargo/features/View/GetCourier/get_courier_page.dart';
import 'package:mc_queen_cargo/features/View/AddAddress/View/create_address_page.dart';
import 'package:mc_queen_cargo/features/View/Address/address_page.dart';
import 'package:mc_queen_cargo/features/View/CargoDetail/CallCourierDetail/call_courier_detail_page.dart';
import 'package:mc_queen_cargo/features/View/CargoDetail/cargo_detail_page.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/PriceDetail/View/price_detail_page.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/PriceInformation/price_information_page.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ParcelSending/package_sending_page.dart';
import 'package:mc_queen_cargo/features/View/CargoPriceCalculate/ShipmentType/shipment_type_page.dart';
import 'package:mc_queen_cargo/features/View/Login/login_controller.dart';
import 'package:mc_queen_cargo/features/View/Login/login_page.dart';
import 'package:mc_queen_cargo/features/View/Main/main_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/CustomerAddress/address_detail_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/ReceiverAddress/address_detail_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/UpdatePassword/update_password_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/UpdatePersonal/update_personal_page.dart';
import 'package:mc_queen_cargo/features/View/MyProfile/my_profile_page.dart';
import 'package:mc_queen_cargo/features/View/Register/ContactInformation/contact_information_page.dart';
import 'package:mc_queen_cargo/features/View/Register/Password/password_page.dart';
import 'package:mc_queen_cargo/features/View/Register/PersonalInformation/personal_information_page.dart';
import 'package:mc_queen_cargo/features/View/Register/register_page.dart';
import 'package:mc_queen_cargo/features/View/Splash/splash_screen_page.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCpaVwdQqugEk-f0BVApOvIR8WdRag1CeI",
              appId: "1:639272645378:android:0acf4236e5d6c14c97c81b",
              messagingSenderId: "639272645378",
              projectId: "mcqueencargo-858dd"))
      : Firebase.initializeApp();
  Get.put(PartnerController());
  Get.put(LoginController());
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with MainAppMixin {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 420),
      child: Obx(
          () => visibility.value ? _DefaultWidget() : _NotConnectionWidget()),
    );
  }
}

class _DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('tr'), Locale('en')],
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      getPages: [
        GetPage(
            name: "/",
            page: () => const SplashScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/main",
            page: () => const MainPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/loginPage",
            page: () => const LoginPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/registerPage",
            page: () => const RegisterPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/personalInformationPage",
            page: () => const PersonalInformationPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/passwordPage",
            page: () => const PasswordPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/contactInformationPage",
            page: () => const ContactInformationPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/getCourierPage",
            page: () => const GetCourierPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/addressPage",
            page: () => const AddressPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/customerAddressInformationPage",
            page: () => const CustomerAddresssInformationPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/receiverAddressInformationPage",
            page: () => const ReceiverAddressInformationPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/myProfilePage",
            page: () => const MyProfilePage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/updatePersonal",
            page: () => const UpdatePersonalPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/updatePassword",
            page: () => const UpdatePasswordPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/shipmentType",
            page: () => const ShipmentTypePage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/parcelSending",
            page: () => const PackageSendingPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/priceDetail",
            page: () => const PriceDetailPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/priceInformation",
            page: () => const PriceInformationPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/getCourierShipmentType",
            page: () => const SelectedPostType(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/additionalServicePage",
            page: () => const AdditionalServicePage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/approvePage",
            page: () => const ApprovePage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/createAddressPage",
            page: () => const CreateAddressPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/cargoDetailPage",
            page: () => const CargoDetailPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/getCourierPage",
            page: () => const CreateAddressPage(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/callCourierDetailPage",
            page: () => const CallCourierDetailPage(),
            transition: Transition.rightToLeft),
      ],
      onInit: () async {
        debugPrint(await FirebaseMessaging.instance.getToken());
        await FirebaseMessaging.instance.requestPermission();
      },
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.orange.shade400),
          ),
        ),
      ),
    );
  }
}

class _NotConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace:const AppbarFlexibleSpace(),
          title: GeneralTextWidget(
              title: "Bağlantı bulunamadı",
              fontsize: 14.sp,
              color: Colors.white),
          centerTitle: true,
          toolbarHeight: 30.h,
        ),
        body: Center(
            child: GeneralTextWidget(
                title: "İnternet bağlantınızı kontrol ediniz",
                fontsize: 14.sp)),
      ),
    );
  }
}
