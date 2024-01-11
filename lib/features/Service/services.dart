import 'package:mc_queen_cargo/features/AtomicWidgets/atomic_service_component.dart';
import 'package:mc_queen_cargo/features/Model/adress_model.dart';
import 'package:mc_queen_cargo/features/Model/authentication_model.dart';
import 'package:mc_queen_cargo/features/Model/cargo_information_model.dart';
import 'package:mc_queen_cargo/features/Model/cargo_movements_model.dart';
import 'package:mc_queen_cargo/features/Model/district_model.dart';
import 'package:mc_queen_cargo/features/Model/call_courier_model.dart';
import 'package:mc_queen_cargo/features/Model/post_courier_model.dart';
import 'package:mc_queen_cargo/features/Model/login_model.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';
import 'package:mc_queen_cargo/features/Model/package_information.dart';
import 'package:mc_queen_cargo/features/Model/province_model.dart';
import 'package:mc_queen_cargo/features/Model/receiver_address_model.dart';

class Services {
  final String baseUrl = "https://ozerhamza.online/api";

  Future<AuthenticationModel> loginAuth() async {
    try {
      var result = await ServiceProcess.postService(
          path: "$baseUrl/authentication/login",
          data: {"userName": "muratcals", "password": "C5raxmGc1-"});
      return AuthenticationModel.fromJson(result);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<AuthenticationModel> refreshToken(String oldToken) async {
    try {
      var response = await ServiceProcess.postService(
          path: "$baseUrl/authentication/refresh", data: oldToken);
      return AuthenticationModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> createCustomer(LoginModel model, String accessToken) async {
    try {
      await ServiceProcess.postService(
          path: "$baseUrl/customerMobil",
          data: loginModelToJson(model),
          accessToken: accessToken);
      return "Kullanıcı başarıyla oluşturuldu";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<LoginModel> login(
      Map<String, String> model, String accessToken) async {
    try {
      var result = await ServiceProcess.postService(
          path: "$baseUrl/customerMobil/login",
          data: model,
          accessToken: accessToken);
      return LoginModel.fromJson(result);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<LoginModel> getCustomerInformation(
      int userId, String accessToken) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/customerMobil/GetOneCustomerId",
          queryParameters: {"id": userId},
          accessToken: accessToken);
      return LoginModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CargoParcelTypeModel>> getCargoParcelTypeModel(
      String accessToken) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/cargoparceltype", accessToken: accessToken);
      return (response as List)
          .map((e) => CargoParcelTypeModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<AddressModel> getCustomerAddress(
      {int addressId = 1, required String accessToken}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/addresses/address",
          queryParameters: {"id": addressId},
          accessToken: accessToken);
      return AddressModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<AddressModel>> getAllCustomerAddress(
      {required int customerId, required String accessToken}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/addresses/customerMobil/",
          queryParameters: {"customerMobilId": customerId},
          accessToken: accessToken);
      return (response as List).map((e) => AddressModel.fromJson(e)).toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<ReceiverAddressModel> getReceiverAddress(
      {required int addressId, required String accessToken}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/receiver/id",
          queryParameters: {"id": addressId},
          accessToken: accessToken);
      return ReceiverAddressModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<ReceiverAddressModel>> getAllReceiverAddress(
      {int customerId = 1, required String accessToken}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/receiver/customerMobilId",
          queryParameters: {"customerMobilId": customerId},
          accessToken: accessToken);
      return (response as List)
          .map((e) => ReceiverAddressModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> postReceiverAddress({
    required ReceiverAddressModel model,
    required String accessToken,
  }) async {
    try {
      await ServiceProcess.postService(
          path: "$baseUrl/receiver",
          data: receiverAddressModelToJson(model),
          accessToken: accessToken);
      return "OK";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> postCustomerAddress(
      {required AddressModel model,
      required int customerId,
      required String accessToken}) async {
    try {
      await ServiceProcess.postService(
          path: "$baseUrl/addresses/CustomerMobilId",
          queryParameters: {"customerMobilId": customerId},
          data: addressModelToJson(model),
          accessToken: accessToken);
      return "OK";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> deleteReceiverAddress(
      {required int addressId, required String accessToken}) async {
    try {
      await ServiceProcess.deleteService(
          path: "$baseUrl/receiver/id",
          queryParameters: {"id": addressId},
          accessToken: accessToken);
      return "Adres başarıyla silinmiştir";
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<String> deleteCustomerAddress(
      {required int addressId, required String accessToken}) async {
    try {
      await ServiceProcess.deleteService(
          path: "$baseUrl/addresses/deleteAddress",
          queryParameters: {"id": addressId},
          accessToken: accessToken);
      return Future.value("Adres başarıyla silinmiştir");
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> deleteCustomer(
      {required int customerId, required String accessToken}) async {
    try {
      await ServiceProcess.deleteService(
          path: "$baseUrl/customerMobil/id",
          queryParameters: {"id": customerId},
          accessToken: accessToken);
      return "Kullanıcı başarıyla silinmiştir";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> updatePassword(
      {required int customerMobilId,
      required String oldPassword,
      required String newPassword,
      required String accessToken}) async {
    try {
      await ServiceProcess.putService(
          path: "$baseUrl/customerMobil/UpdatePassword",
          accessToken: accessToken,
          queryParameters: {
            "customerMobilId": customerMobilId,
            "oldPassword": oldPassword,
            "newPassword": newPassword
          });
      return "Şifreniz başarıyla güncellenmiştir";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<DistrictModel>> getDistrictList(String accessToken) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/district", accessToken: accessToken);
      return (response as List).map((e) => DistrictModel.fromJson(e)).toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<NeighbourhoodModel>> getNeighbourhoodList(
      int districtId, String accessToken) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/neighbourhood",
          queryParameters: {"DistrictId": districtId},
          accessToken: accessToken);
      return (response as List)
          .map((e) => NeighbourhoodModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<ProvinceModel>> getProvinceList(String accessToken) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/province", accessToken: accessToken);
      return (response as List).map((e) => ProvinceModel.fromJson(e)).toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> postCargo(
      {required PostCourierModel model, required String accessToken}) async {
    try {
      await ServiceProcess.postService(
          path: "$baseUrl/callcourier/CreateOneCallCourier",
          data: postCourierModelToJson(model),
          accessToken: accessToken);
      return "Kargonuz oluşturulmuştur. Kurye en yakın zamanda adresinize ulaşacaktır.";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CargoInformationModel>> getAllCargoInformation(
      {required String accessToken, required String tcNo}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/cargo/GetAllCargoWithTcNo",
          accessToken: accessToken,
          queryParameters: {"tcNo": tcNo});
      return (response as List)
          .map((e) => CargoInformationModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<CargoInformationModel> getOneCargoInformation(
      {required String accessToken, required int cargoId}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/cargo/GetOneCargoWithId",
        accessToken: accessToken,
        queryParameters: {"id": cargoId},
      );
      return CargoInformationModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CargoMovementsModel>> getCargoMovements(
      {required int cargoId, required String accessToken}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/cargomovement/CargoId",
          queryParameters: {"id": cargoId},
          accessToken: accessToken);
      return (response as List)
          .map((e) => CargoMovementsModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CallCourierModel>> getAllCourierList(
      {required String accessToken, required String tcNo}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/callcourier/TcNo",
          accessToken: accessToken,
          queryParameters: {"tcNo": tcNo});
      return (response as List)
          .map((e) => CallCourierModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<CallCourierModel> getOneCallCourier(
      {required String accessToken, required int cargoId}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/callcourier/CallCourierId",
        accessToken: accessToken,
        queryParameters: {"callCourierId": cargoId},
      );
      return CallCourierModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
    Future<CargoInformationModel> getTrackingCargo(
      {required String accessToken, required String trackingNo}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/cargo/GetOneCargoWithTrackingNo",
        accessToken: accessToken,
        queryParameters: {"trackingNo": trackingNo},
      );
      return CargoInformationModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
}
