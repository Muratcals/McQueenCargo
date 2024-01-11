// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  CustomerModelData? data;
  dynamic error;

  CustomerModel({
    this.data,
    this.error,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        data: json["Data"] == null
            ? null
            : CustomerModelData.fromJson(json["Data"]),
        error: json["Error"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Error": error,
      };
}

class CustomerModelData {
  String? createDate;
  String? customerName;
  String? customerLastName;
  String? tcNo;
  String? birthDate;
  String? eMail;
  String? phoneNumber;

  CustomerModelData({
    this.createDate,
    this.customerName,
    this.customerLastName,
    this.tcNo,
    this.birthDate,
    this.eMail,
    this.phoneNumber,
  });

  factory CustomerModelData.fromJson(Map<String, dynamic> json) =>
      CustomerModelData(
        createDate: json["createDate"],
        customerName: json["customerName"],
        customerLastName: json["customerLastName"],
        tcNo: json["TcNo"],
        birthDate: json["birthDate"],
        eMail: json["E-Mail"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "createDate": createDate,
        "customerName": customerName,
        "customerLastName": customerLastName,
        "TcNo": tcNo,
        "birthDate": birthDate,
        "E-Mail": eMail,
        "phoneNumber": phoneNumber,
      };
}
