import 'package:get/get.dart';
import 'package:mc_queen_cargo/features/Pages/CreateAddress/View/create_address_page.dart';
import 'package:mc_queen_cargo/features/Pages/Address/address_page.dart';
import 'package:mc_queen_cargo/features/Pages/CargoDetail/CallCourierDetail/call_courier_detail_page.dart';
import 'package:mc_queen_cargo/features/Pages/CargoDetail/cargo_detail_page.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceDetail/View/price_detail_page.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/PriceInformation/price_information_page.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ParcelSending/package_sending_page.dart';
import 'package:mc_queen_cargo/features/Pages/CargoPriceCalculate/ShipmentType/shipment_type_page.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/AddionatialService/additiona_service_page.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/Approve/approve_page.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/SelectedPostType/selected_post_type_page.dart';
import 'package:mc_queen_cargo/features/Pages/GetCourier/view/get_courier_page.dart';
import 'package:mc_queen_cargo/features/Pages/Login/login_page.dart';
import 'package:mc_queen_cargo/features/Pages/Main/main_page.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/CustomerAddress/address_detail_page.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/ReceiverAddress/address_detail_page.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/UpdatePassword/update_password_page.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/UpdatePersonal/update_personal_page.dart';
import 'package:mc_queen_cargo/features/Pages/MyProfile/my_profile_page.dart';
import 'package:mc_queen_cargo/features/Pages/Register/ContactInformation/contact_information_page.dart';
import 'package:mc_queen_cargo/features/Pages/Register/Password/password_page.dart';
import 'package:mc_queen_cargo/features/Pages/Register/PersonalInformation/personal_information_page.dart';
import 'package:mc_queen_cargo/features/Pages/Register/register_page.dart';
import 'package:mc_queen_cargo/features/Pages/Splash/splash_screen_page.dart';

class GenerateRoute {
  static const String home = "/";
  static const String main = "/main";
  static const String loginPage = "/loginPage";
  static const String registerPage = "/registerPage";
  static const String personalInformationPage = "/personalInformationPage";
  static const String passwordPage = "/passwordPage";
  static const String contactInformationPage = "/contactInformationPage";
  static const String getCourierPage = "/getCourierPage";
  static const String addressPage = "/addressPage";
  static const String customerAddressInformationPage =
      "/customerAddressInformationPage";
  static const String receiverAddressInformationPage =
      "/receiverAddressInformationPage";
  static const String myProfilePage = "/myProfilePage";
  static const String updatePersonal = "/updatePersonal";
  static const String updatePassword = "/updatePassword";
  static const String shipmentType = "/shipmentType";
  static const String parcelSending = "/parcelSending";
  static const String priceDetail = "/priceDetail";
  static const String priceInformation = "/priceInformation";
  static const String selectedPostType = "/selectedPostType";
  static const String additionalServicePage = "/additionalServicePage";
  static const String approvePage = "/approvePage";
  static const String createAddressPage = "/createAddressPage";
  static const String cargoDetailPage = "/cargoDetailPage";
  static const String callCourierDetailPage = "/callCourierDetailPage";

  static List<GetPage> getPages() {
    return [
      GetPage(
          name: home,
          page: () => const SplashScreen(),
          transition: Transition.rightToLeft),
      GetPage(
          name: main,
          page: () => const MainPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: loginPage,
          page: () => const LoginPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: registerPage,
          page: () => const RegisterPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: personalInformationPage,
          page: () => const PersonalInformationPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: passwordPage,
          page: () => const PasswordPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: contactInformationPage,
          page: () => const ContactInformationPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: getCourierPage,
          page: () => const GetCourierPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: addressPage,
          page: () => const AddressPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: customerAddressInformationPage,
          page: () => const CustomerAddresssInformationPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: receiverAddressInformationPage,
          page: () => const ReceiverAddressInformationPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: myProfilePage,
          page: () => const MyProfilePage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: updatePersonal,
          page: () => const UpdatePersonalPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: updatePassword,
          page: () => const UpdatePasswordPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: shipmentType,
          page: () => const ShipmentTypePage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: parcelSending,
          page: () => const PackageSendingPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: priceDetail,
          page: () => const PriceDetailPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: priceInformation,
          page: () => const PriceInformationPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: selectedPostType,
          page: () => const SelectedPostType(),
          transition: Transition.rightToLeft),
      GetPage(
          name: additionalServicePage,
          page: () => const AdditionalServicePage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: approvePage,
          page: () => const ApprovePage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: createAddressPage,
          page: () => const CreateAddressPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: cargoDetailPage,
          page: () => const CargoDetailPage(),
          transition: Transition.rightToLeft),
      GetPage(
          name: callCourierDetailPage,
          page: () => const CallCourierDetailPage(),
          transition: Transition.rightToLeft),
    ];
  }
}
