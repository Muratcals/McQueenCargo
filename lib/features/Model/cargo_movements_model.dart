// To parse this JSON data, do
//
//     final cargoMovementsModel = cargoMovementsModelFromJson(jsonString);

import 'dart:convert';

List<CargoMovementsModel> cargoMovementsModelFromJson(String str) => List<CargoMovementsModel>.from(json.decode(str).map((x) => CargoMovementsModel.fromJson(x)));

String cargoMovementsModelToJson(List<CargoMovementsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CargoMovementsModel {
    int? id;
    int? cargoId;
    String? cargoTrackingNo;
    dynamic callCourierId;
    int? branchId;
    String? cargoBranchName;
    int? cargoStatusId;
    String? cargoStatusName;
    DateTime? date;

    CargoMovementsModel({
        this.id,
        this.cargoId,
        this.cargoTrackingNo,
        this.callCourierId,
        this.branchId,
        this.cargoBranchName,
        this.cargoStatusId,
        this.cargoStatusName,
        this.date,
    });

    factory CargoMovementsModel.fromJson(Map<String, dynamic> json) => CargoMovementsModel(
        id: json["id"],
        cargoId: json["cargoId"],
        cargoTrackingNo: json["cargoTrackingNo"],
        callCourierId: json["callCourierId"],
        branchId: json["branchId"],
        cargoBranchName: json["cargoBranchName"],
        cargoStatusId: json["cargoStatusId"],
        cargoStatusName: json["cargoStatusName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cargoId": cargoId,
        "cargoTrackingNo": cargoTrackingNo,
        "callCourierId": callCourierId,
        "branchId": branchId,
        "cargoBranchName": cargoBranchName,
        "cargoStatusId": cargoStatusId,
        "cargoStatusName": cargoStatusName,
        "date": date?.toIso8601String(),
    };
}
