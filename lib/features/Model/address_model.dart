import 'dart:convert';

import 'package:equatable/equatable.dart';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

// ignore: must_be_immutable
class AddressModel extends Equatable {
  int? id;
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
  String? apartmentNumber;
  int? floor;
  String? title;
  String? description;
  int? customerMobilId;

  AddressModel(
      {this.id,
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
      this.apartmentNumber,
      this.floor,
      this.title,
      this.description,
      this.customerMobilId});

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
      id: json["id"],
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
      apartmentNumber: json["apartmentNumber"],
      floor: json["floor"],
      title: json["title"],
      customerMobilId: json["customerMobilId"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "apartmentNumber": apartmentNumber,
        "floor": floor,
        "title": title,
        "customerMobilId": customerMobilId,
        "description": description
      };

  @override
  List<Object?> get props => [
        id,
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
        apartmentNumber,
        floor,
        title,
        description,
        customerMobilId,
      ];

  AddressModel copyWith({
    int? id,
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
    String? apartmentNumber,
    int? floor,
    String? title,
    String? description,
    int? customerMobilId,
  }) {
    return AddressModel(
        id: id ?? this.id,
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
        apartmentNumber: apartmentNumber ?? this.apartmentNumber,
        floor: floor ?? this.floor,
        title: title ?? this.title,
        description: description ?? this.description,
        customerMobilId: customerMobilId ?? this.customerMobilId);
  }
}
