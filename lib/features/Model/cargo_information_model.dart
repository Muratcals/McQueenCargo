// To parse this JSON data, do
//
//     final cargoInformationModel = cargoInformationModelFromJson(jsonString);

import 'dart:convert';

CargoInformationModel cargoInformationModelFromJson(String str) =>
    CargoInformationModel.fromJson(json.decode(str));

String cargoInformationModelToJson(CargoInformationModel data) =>
    json.encode(data.toJson());

class CargoInformationModel {
  int? id;
  int? customerMobilId;
  dynamic customerId;
  String? customerName;
  String? customerSurname;
  int? customerMobilAdressId;
  int? cargoDepartureBranchId;
  String? cargoDepartureBranchName;
  int? cargoArrivalBranchId;
  String? cargoArrivalBranchName;
  int? receiverId;
  String? receiverNameSurname;
  int? receiverCountryId;
  String? receiverCountryName;
  int? receiverProvinceId;
  String? receiverProvinceName;
  int? receiverDistrictId;
  String? receiverDistrictName;
  int? receiverNeighbourhoodId;
  String? receiverNeighbourhoodName;
  String? receiverStreet;
  String? receiverBuildingNo;
  int? floor;
  String? receiverApartmentNumber;
  int? cargoParcelTypeId;
  String? cargoParcelTypeName;
  int? paymentTypeId;
  String? paymentTypeName;
  int? cargoTransportationConditionsId;
  String? cargoTransportationConditionsName;
  int? cargoStatusId;
  String? cargoStatusName;
  int? cargoTypeId;
  String? cargoTypeName;
  double? cargoDesi;
  DateTime? cargoReleaseDate;
  DateTime? cargoEstimatedDeliveryDate;
  DateTime? cargoDeliveryDate;
  double? price;
  String? cargoTrackingNo;

  CargoInformationModel({
    this.id,
    this.customerMobilId,
    this.customerId,
    this.customerName,
    this.customerSurname,
    this.customerMobilAdressId,
    this.cargoDepartureBranchId,
    this.cargoDepartureBranchName,
    this.cargoArrivalBranchId,
    this.cargoArrivalBranchName,
    this.receiverId,
    this.receiverNameSurname,
    this.receiverCountryId,
    this.receiverCountryName,
    this.receiverProvinceId,
    this.receiverProvinceName,
    this.receiverDistrictId,
    this.receiverDistrictName,
    this.receiverNeighbourhoodId,
    this.receiverNeighbourhoodName,
    this.receiverStreet,
    this.receiverBuildingNo,
    this.floor,
    this.receiverApartmentNumber,
    this.cargoParcelTypeId,
    this.cargoParcelTypeName,
    this.paymentTypeId,
    this.paymentTypeName,
    this.cargoTransportationConditionsId,
    this.cargoTransportationConditionsName,
    this.cargoStatusId,
    this.cargoStatusName,
    this.cargoTypeId,
    this.cargoTypeName,
    this.cargoDesi,
    this.cargoReleaseDate,
    this.cargoEstimatedDeliveryDate,
    this.cargoDeliveryDate,
    this.price,
    this.cargoTrackingNo,
  });

  factory CargoInformationModel.fromJson(Map<String, dynamic> json) =>
      CargoInformationModel(
        id: json["id"],
        customerMobilId: json["customerMobilId"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        customerSurname: json["customerSurname"],
        customerMobilAdressId: json["customerMobilAdressId"],
        cargoDepartureBranchId: json["cargoDepartureBranchId"],
        cargoDepartureBranchName: json["cargoDepartureBranchName"],
        cargoArrivalBranchId: json["cargoArrivalBranchId"],
        cargoArrivalBranchName: json["cargoArrivalBranchName"],
        receiverId: json["receiverId"],
        receiverNameSurname: json["receiverNameSurname"],
        receiverCountryId: json["receiverCountryId"],
        receiverCountryName: json["receiverCountryName"],
        receiverProvinceId: json["receiverProvinceId"],
        receiverProvinceName: json["receiverProvinceName"],
        receiverDistrictId: json["receiverDistrictId"],
        receiverDistrictName: json["receiverDistrictName"],
        receiverNeighbourhoodId: json["receiverNeighbourhoodId"],
        receiverNeighbourhoodName: json["receiverNeighbourhoodName"],
        receiverStreet: json["receiverStreet"],
        receiverBuildingNo: json["receiverBuildingNo"],
        floor: json["floor"],
        receiverApartmentNumber: json["receiverApartmentNumber"],
        cargoParcelTypeId: json["cargoParcelTypeID"],
        cargoParcelTypeName: json["cargoParcelTypeName"],
        paymentTypeId: json["paymentTypeId"],
        paymentTypeName: json["paymentTypeName"],
        cargoTransportationConditionsId:
            json["cargoTransportationConditionsId"],
        cargoTransportationConditionsName:
            json["cargoTransportationConditionsName"],
        cargoStatusId: json["cargoStatusId"],
        cargoStatusName: json["cargoStatusName"],
        cargoTypeId: json["cargoTypeId"],
        cargoTypeName: json["cargoTypeName"],
        cargoDesi: json["cargoDesi"],
        cargoReleaseDate: json["cargoReleaseDate"] == null
            ? null
            : DateTime.parse(json["cargoReleaseDate"]),
        cargoEstimatedDeliveryDate: json["cargoEstimatedDeliveryDate"] == null
            ? null
            : DateTime.parse(json["cargoEstimatedDeliveryDate"]),
        cargoDeliveryDate: json["cargoDeliveryDate"] == null
            ? null
            : DateTime.parse(json["cargoDeliveryDate"]),
        price: json["price"],
        cargoTrackingNo: json["cargoTrackingNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerMobilId": customerMobilId,
        "customerId": customerId,
        "customerName": customerName,
        "customerSurname": customerSurname,
        "customerMobilAdressId": customerMobilAdressId,
        "cargoDepartureBranchId": cargoDepartureBranchId,
        "cargoDepartureBranchName": cargoDepartureBranchName,
        "cargoArrivalBranchId": cargoArrivalBranchId,
        "cargoArrivalBranchName": cargoArrivalBranchName,
        "receiverId": receiverId,
        "receiverNameSurname": receiverNameSurname,
        "receiverCountryId": receiverCountryId,
        "receiverCountryName": receiverCountryName,
        "receiverProvinceId": receiverProvinceId,
        "receiverProvinceName": receiverProvinceName,
        "receiverDistrictId": receiverDistrictId,
        "receiverDistrictName": receiverDistrictName,
        "receiverNeighbourhoodId": receiverNeighbourhoodId,
        "receiverNeighbourhoodName": receiverNeighbourhoodName,
        "receiverStreet": receiverStreet,
        "receiverBuildingNo": receiverBuildingNo,
        "floor": floor,
        "receiverApartmentNumber": receiverApartmentNumber,
        "cargoParcelTypeID": cargoParcelTypeId,
        "cargoParcelTypeName": cargoParcelTypeName,
        "paymentTypeId": paymentTypeId,
        "paymentTypeName": paymentTypeName,
        "cargoTransportationConditionsId": cargoTransportationConditionsId,
        "cargoTransportationConditionsName": cargoTransportationConditionsName,
        "cargoStatusId": cargoStatusId,
        "cargoStatusName": cargoStatusName,
        "cargoTypeId": cargoTypeId,
        "cargoTypeName": cargoTypeName,
        "cargoDesi": cargoDesi,
        "cargoReleaseDate": cargoReleaseDate?.toIso8601String(),
        "cargoEstimatedDeliveryDate":
            cargoEstimatedDeliveryDate?.toIso8601String(),
        "cargoDeliveryDate": cargoDeliveryDate?.toIso8601String(),
        "price": price,
        "cargoTrackingNo": cargoTrackingNo,
      };
}
