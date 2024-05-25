import 'package:mc_queen_cargo/features/Authorazation/auth_id.dart';
import 'package:mc_queen_cargo/features/Service/atomic_service_component.dart';
import 'package:mc_queen_cargo/features/Model/address_model.dart';
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
  final String baseUrl = "https://api.ozerhamza.com.tr/api";

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

  Future<String> createCustomer(LoginModel model) async {
    try {
      await ServiceProcess.postService(
        path: "$baseUrl/customerMobil",
        data: loginModelToJson(model),
      );
      return "Kullanıcı başarıyla oluşturuldu";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<LoginModel> login(
      Map<String, String> model, String? incoming) async {
    try {
      var result = await ServiceProcess.postService(
          path: "$baseUrl/customerMobil/login",
          data: model,
          incoming: incoming);
      return LoginModel.fromJson(result);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<LoginModel> getCustomerInformation(int userId) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/customerMobil/GetOneCustomerId",
        queryParameters: {"id": userId},
      );
      return LoginModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CargoParcelTypeModel>> getCargoParcelTypeModel() async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/cargoparceltype",
      );
      return (response as List)
          .map((e) => CargoParcelTypeModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<AddressModel> getCustomerAddress(
      {int addressId = 1}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/addresses/address",
        queryParameters: {"id": addressId},
      );
      return AddressModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<AddressModel>> getAllCustomerAddress(
      {required int customerId}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/addresses/customerMobil/",
        queryParameters: {"customerMobilId": customerId},
      );
      return (response as List).map((e) => AddressModel.fromJson(e)).toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<ReceiverAddressModel> getReceiverAddress(
      {required int addressId, }) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/receiver/id",
        queryParameters: {"id": addressId},
      );
      return ReceiverAddressModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<ReceiverAddressModel>> getAllReceiverAddress(
      {int customerId = 1, }) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/receiver/customerMobilId",
        queryParameters: {"customerMobilId": customerId},
      );
      return (response as List)
          .map((e) => ReceiverAddressModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> postReceiverAddress({
    required ReceiverAddressModel model,
  }) async {
    try {
      await ServiceProcess.postService(
        path: "$baseUrl/receiver",
        data: receiverAddressModelToJson(model),
      );
      return "OK";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> postCustomerAddress(
      {required AddressModel model,
      }) async {
    try {
      await ServiceProcess.postService(
        path: "$baseUrl/addresses/CustomerMobilId",
        queryParameters: {"customerMobilId": Auth.authId},
        data: addressModelToJson(model),
      );
      return "OK";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> deleteReceiverAddress(
      {required int addressId, }) async {
    try {
      await ServiceProcess.deleteService(
        path: "$baseUrl/receiver/id",
        queryParameters: {"id": addressId},
      );
      return "Adres başarıyla silinmiştir";
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<String> deleteCustomerAddress(
      {required int addressId, }) async {
    try {
      await ServiceProcess.deleteService(
        path: "$baseUrl/addresses/deleteAddress",
        queryParameters: {"id": addressId},
      );
      return Future.value("Adres başarıyla silinmiştir");
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> deleteCustomer(
      ) async {
    try {
      await ServiceProcess.deleteService(
        path: "$baseUrl/customerMobil/id",
        queryParameters: {"id": Auth.authId},
      );
      return "Kullanıcı başarıyla silinmiştir";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> updatePassword(
      {
       oldPassword,
       newPassword,
      }) async {
    try {
      await ServiceProcess.putService(
          path: "$baseUrl/customerMobil/UpdatePassword",
          queryParameters: {
            "customerMobilId": Auth.authId,
            "oldPassword": oldPassword,
            "newPassword": newPassword
          });
      return "Şifreniz başarıyla güncellenmiştir";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<DistrictModel>> getDistrictList() async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/district",
      );
      return (response as List).map((e) => DistrictModel.fromJson(e)).toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<NeighbourhoodModel>> getNeighbourhoodList(
      int districtId) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/neighbourhood",
        queryParameters: {"DistrictId": districtId},
      );
      return (response as List)
          .map((e) => NeighbourhoodModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<ProvinceModel>> getProvinceList() async {
    try {
      var response = await ServiceProcess.getService(path: "$baseUrl/province");
      return (response as List).map((e) => ProvinceModel.fromJson(e)).toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<String> postCargo(
      {required PostCourierModel model, }) async {
    try {
      await ServiceProcess.postService(
        path: "$baseUrl/callcourier/CreateOneCallCourier",
        data: postCourierModelToJson(model),
      );
      return "Kargonuz oluşturulmuştur. Kurye en yakın zamanda adresinize ulaşacaktır.";
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CargoInformationModel>> getAllCargoInformation(
      { tcNo}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/cargo/GetAllCargoWithTcNo",
          queryParameters: {"tcNo": tcNo});
      return (response as List)
          .map((e) => CargoInformationModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<CargoInformationModel> getOneCargoInformation(
      {required int cargoId}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/cargo/GetOneCargoWithId",
        queryParameters: {"id": cargoId},
      );
      return CargoInformationModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CargoMovementsModel>> getCargoMovements(
      {required int cargoId}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/cargomovement/CargoId",
        queryParameters: {"id": cargoId},
      );
      return (response as List)
          .map((e) => CargoMovementsModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<List<CallCourierModel>> getAllCourierList(
      {required String tcNo}) async {
    try {
      var response = await ServiceProcess.getService(
          path: "$baseUrl/callcourier/TcNo", queryParameters: {"tcNo": tcNo});
      return (response as List)
          .map((e) => CallCourierModel.fromJson(e))
          .toList();
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<CallCourierModel> getOneCallCourier(
      {required int cargoId, String? incoming}) async {
    try {
      var response = await ServiceProcess.getService(
        path: "$baseUrl/callcourier/CallCourierId",
        queryParameters: {"callCourierId": cargoId},
      );
      return CallCourierModel.fromJson(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<CargoInformationModel> getTrackingCargo(
      {required String trackingNo, String? incoming}) async {
    var response = await ServiceProcess.getService(
        path: "$baseUrl/cargo/GetOneCargoWithTrackingNo",
        queryParameters: {"trackingNo": trackingNo},
        incoming: incoming);
    return CargoInformationModel.fromJson(response);
  }
}
