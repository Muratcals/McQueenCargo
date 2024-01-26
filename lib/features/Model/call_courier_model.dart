// To parse this JSON data, do
//
//     final getCourierModel = getCourierModelFromJson(jsonString);

import 'dart:convert';

CallCourierModel getCourierModelFromJson(String str) =>
    CallCourierModel.fromJson(json.decode(str));

String getCourierModelToJson(CallCourierModel data) =>
    json.encode(data.toJson());

class CallCourierModel {
  int? id;
  int? customerMobilId;
  String? customerName;
  String? customerSurname;
  int? customerMobilAdressId;
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
  int? cargoTypeId;
  String? cargoTypeName;
  bool? callCourierOk;
  double? cargoDesi;
  DateTime? cargoRealeseDate;
  double? price;

  CallCourierModel({
    this.id,
    this.customerMobilId,
    this.customerName,
    this.customerSurname,
    this.customerMobilAdressId,
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
    this.cargoTypeId,
    this.cargoTypeName,
    this.callCourierOk,
    this.cargoDesi,
    this.cargoRealeseDate,
    this.price,
  });

  factory CallCourierModel.fromJson(Map<String, dynamic> json) =>
      CallCourierModel(
        id: json["id"],
        customerMobilId: json["customerMobilId"],
        customerName: json["customerName"],
        customerSurname: json["customerSurname"],
        customerMobilAdressId: json["customerMobilAdressId"],
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
        cargoTypeId: json["cargoTypeId"],
        cargoTypeName: json["cargoTypeName"],
        callCourierOk: json["callCourierOk"],
        cargoDesi: json["cargoDesi"],
        cargoRealeseDate: json["cargoRealeseDate"] == null
            ? null
            : DateTime.parse(json["cargoRealeseDate"]),
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerMobilId": customerMobilId,
        "customerName": customerName,
        "customerSurname": customerSurname,
        "customerMobilAdressId": customerMobilAdressId,
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
        "cargoTypeId": cargoTypeId,
        "cargoTypeName": cargoTypeName,
        "callCourierOk": callCourierOk,
        "cargoDesi": cargoDesi,
        "cargoRealeseDate": cargoRealeseDate?.toIso8601String(),
        "price": price,
      };
}
