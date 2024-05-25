// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ReceiverAddressModel receiverAddressModelFromJson(String str) =>
    ReceiverAddressModel.fromJson(json.decode(str));

String receiverAddressModelToJson(ReceiverAddressModel data) =>
    json.encode(data.toJson());

class ReceiverAddressModel extends Equatable {
  int? id;
  String? nameSurname;
  String? email;
  String? numberPhone;
  int? countryId;
  String? countryName;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  int? neighbourhoodId;
  String? neighbourhoodName;
  String? street;
  String? buildingNo;
  int? floor;
  String? apartmentNumber;
  String? title;
  String? description;
  int? customerMobilId;

  ReceiverAddressModel({
    this.id,
    this.nameSurname,
    this.email,
    this.numberPhone,
    this.countryId,
    this.countryName,
    this.provinceId,
    this.provinceName,
    this.districtId,
    this.districtName,
    this.neighbourhoodId,
    this.neighbourhoodName,
    this.street,
    this.buildingNo,
    this.floor,
    this.apartmentNumber,
    this.title,
    this.description,
    this.customerMobilId,
  });

  ReceiverAddressModel copyWith(
      {int? id,
      String? nameSurname,
      String? email,
      String? numberPhone,
      int? countryId,
      String? countryName,
      int? provinceId,
      String? provinceName,
      int? districtId,
      String? districtName,
      int? neighbourhoodId,
      String? neighbourhoodName,
      String? street,
      String? buildingNo,
      int? floor,
      String? apartmentNumber,
      String? title,
      String? description,
      int? customerMobilId}) {
    return ReceiverAddressModel(
      id: id ?? this.id,
      nameSurname: nameSurname ?? this.nameSurname,
      email: email ?? this.email,
      numberPhone: numberPhone ?? this.numberPhone,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
      provinceId: provinceId ?? this.provinceId,
      provinceName: provinceName ?? this.provinceName,
      districtId: districtId ?? this.districtId,
      districtName: districtName ?? this.districtName,
      neighbourhoodId: neighbourhoodId ?? this.neighbourhoodId,
      neighbourhoodName: neighbourhoodName ?? this.neighbourhoodName,
      street: street ?? this.street,
      buildingNo: buildingNo ?? this.buildingNo,
      floor: floor ?? this.floor,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      customerMobilId: customerMobilId ?? this.customerMobilId,
    );
  }

  factory ReceiverAddressModel.fromJson(Map<String, dynamic> json) =>
      ReceiverAddressModel(
          id: json["id"],
          nameSurname: json["nameSurname"],
          email: json["email"],
          numberPhone: json["numberPhone"],
          countryId: json["countryId"],
          countryName: json["countryName"],
          provinceId: json["provinceId"],
          provinceName: json["provinceName"],
          districtId: json["districtId"],
          districtName: json["districtName"],
          neighbourhoodId: json["neighbourhoodId"],
          neighbourhoodName: json["neighbourhoodName"],
          street: json["street"],
          buildingNo: json["buildingNo"],
          floor: json["floor"],
          apartmentNumber: json["apartmentNumber"],
          title: json["title"],
          customerMobilId: json["customerMobilId"],
          description: json["description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameSurname": nameSurname,
        "email": email,
        "numberPhone": numberPhone,
        "countryId": countryId,
        "countryName": countryName,
        "provinceId": provinceId,
        "provinceName": provinceName,
        "districtId": districtId,
        "districtName": districtName,
        "neighbourhoodId": neighbourhoodId,
        "neighbourhoodName": neighbourhoodName,
        "street": street,
        "buildingNo": buildingNo,
        "floor": floor,
        "apartmentNumber": apartmentNumber,
        "title": title,
        "description": description,
        "customerMobilId": customerMobilId,
      };

  @override
  List<Object?> get props => [
        id,
        nameSurname,
        email,
        numberPhone,
        countryId,
        countryName,
        provinceId,
        provinceName,
        districtId,
        districtName,
        neighbourhoodId,
        neighbourhoodName,
        street,
        buildingNo,
        floor,
        apartmentNumber,
        title,
        description,
        customerMobilId,
      ];
}
