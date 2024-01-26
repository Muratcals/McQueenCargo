// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
    int? id;
    String? districtName;
    int? provinceId;

    DistrictModel({
        this.id,
        this.districtName,
        this.provinceId,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json["id"],
        districtName: json["districtName"],
        provinceId: json["provinceId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "districtName": districtName,
        "provinceId": provinceId,
    };
}
