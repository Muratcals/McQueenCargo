// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
    String? street;
    String? buildingNo;
    String? apartmentNumber;
    String? postCode;
    String? title;
    int? countryId;
    int? provinceId;
    int? districtId;
    int? neighbourhoodId;
    int? customerId;

    AddressModel({
        this.street,
        this.buildingNo,
        this.apartmentNumber,
        this.postCode,
        this.title,
        this.countryId,
        this.provinceId,
        this.districtId,
        this.neighbourhoodId,
        this.customerId,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        buildingNo: json["buildingNo"],
        apartmentNumber: json["apartmentNumber"],
        postCode: json["postCode"],
        title: json["title"],
        countryId: json["countryId"],
        provinceId: json["provinceId"],
        districtId: json["districtId"],
        neighbourhoodId: json["neighbourhoodId"],
        customerId: json["customerId"],
    );

    Map<String, dynamic> toJson() => {
        "street": street,
        "buildingNo": buildingNo,
        "apartmentNumber": apartmentNumber,
        "postCode": postCode,
        "title": title,
        "countryId": countryId,
        "provinceId": provinceId,
        "districtId": districtId,
        "neighbourhoodId": neighbourhoodId,
        "customerId": customerId,
    };
}
