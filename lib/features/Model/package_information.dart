// To parse this JSON data, do
//
//     final cargoParcelTypeModel = cargoParcelTypeModelFromJson(jsonString);

import 'dart:convert';

List<CargoParcelTypeModel> cargoParcelTypeModelFromJson(String str) =>
    List<CargoParcelTypeModel>.from(
        json.decode(str).map((x) => CargoParcelTypeModel.fromJson(x)));

String cargoParcelTypeModelToJson(List<CargoParcelTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CargoParcelTypeModel {
  int? id;
  String? cargoParcelTypeName;
  String? maxSize;
  String? desiSize;
  double? price;
  String? information;

  CargoParcelTypeModel({
    this.id,
    this.cargoParcelTypeName,
    this.maxSize,
    this.desiSize,
    this.price,
    this.information,
  });

  factory CargoParcelTypeModel.fromJson(Map<String, dynamic> json) =>
      CargoParcelTypeModel(
        id: json["id"],
        cargoParcelTypeName: json["cargoParcelTypeName"],
        maxSize: json["maxSize"],
        desiSize: json["desiSize"],
        price: json["price"],
        information: json["information"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cargoParcelTypeName": cargoParcelTypeName,
        "maxSize": maxSize,
        "desiSize": desiSize,
        "price": price,
        "information": information,
      };
}
