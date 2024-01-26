// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
    int? id;
    String? provinceName;
    int? countryId;

    ProvinceModel({
        this.id,
        this.provinceName,
        this.countryId,
    });

    factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        id: json["id"],
        provinceName: json["provinceName"],
        countryId: json["countryId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "provinceName": provinceName,
        "countryId": countryId,
    };
}
