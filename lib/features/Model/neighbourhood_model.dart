// To parse this JSON data, do
//
//     final neighbourhoodModel = neighbourhoodModelFromJson(jsonString);

import 'dart:convert';

NeighbourhoodModel neighbourhoodModelFromJson(String str) => NeighbourhoodModel.fromJson(json.decode(str));

String neighbourhoodModelToJson(NeighbourhoodModel data) => json.encode(data.toJson());

class NeighbourhoodModel {
    int? id;
    String? neighbourhoodName;
    int? districtId;

    NeighbourhoodModel({
        this.id,
        this.neighbourhoodName,
        this.districtId,
    });

    factory NeighbourhoodModel.fromJson(Map<String, dynamic> json) => NeighbourhoodModel(
        id: json["id"],
        neighbourhoodName: json["neighbourhoodName"],
        districtId: json["districtId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "neighbourhoodName": neighbourhoodName,
        "districtId": districtId,
    };
    
}
