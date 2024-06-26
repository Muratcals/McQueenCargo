// To parse this JSON data, do
//
//     final getCoruierModel = getCoruierModelFromJson(jsonString);

import 'dart:convert';

PostCourierModel postCourierModelFromJson(String str) =>
    PostCourierModel.fromJson(json.decode(str));

String postCourierModelToJson(PostCourierModel data) =>
    json.encode(data.toJson());

class PostCourierModel {
  int? customerMobilId; // kullanıcı Id
  int? customerMobilAdressId; // kullanıcı adres id
  int? receiverId; // alıcı adres id
  int? paymentTypeId; // kim ödeyecek o default 2 
  int? cargoParcelTypeId; // 5 kağıt 6 koli
  int? cargoTransportationConditionsId; // kırılabilir
  int? cargoTypeId; // gün içi teslimat default 1
  double? cargoDesi; // agırlık
  DateTime? cargoRealeseDate; // tarih
  double? price; // fiyat
  bool? callCourierOk; // default false;

  PostCourierModel(
      {this.customerMobilId,
      this.customerMobilAdressId,
      this.receiverId,
      this.paymentTypeId,
      this.cargoParcelTypeId,
      this.cargoTransportationConditionsId,
      this.cargoTypeId,
      this.cargoDesi,
      this.cargoRealeseDate,
      this.price,
      this.callCourierOk});

  factory PostCourierModel.fromJson(Map<String, dynamic> json) =>
      PostCourierModel(
          customerMobilId: json["customerMobilId"],
          customerMobilAdressId: json["customerMobilAdressId"],
          receiverId: json["receiverId"],
          paymentTypeId: json["paymentTypeId"],
          cargoParcelTypeId: json["cargoParcelTypeID"],
          cargoTransportationConditionsId:
              json["cargoTransportationConditionsId"],
          cargoTypeId: json["cargoTypeId"],
          cargoDesi: json["cargoDesi"],
          cargoRealeseDate: json["cargoRealeseDate"] == null
              ? null
              : DateTime.parse(json["cargoRealeseDate"]),
          price: json["price"],
          callCourierOk: json["callCourierOk"]);

  Map<String, dynamic> toJson() => {
        "customerMobilId": customerMobilId,
        "customerMobilAdressId": customerMobilAdressId,
        "receiverId": receiverId,
        "paymentTypeId": paymentTypeId,
        "cargoParcelTypeID": cargoParcelTypeId,
        "cargoTransportationConditionsId": cargoTransportationConditionsId,
        "cargoTypeId": cargoTypeId,
        "cargoDesi": cargoDesi,
        "cargoRealeseDate": cargoRealeseDate?.toIso8601String(),
        "price": price,
        "callCourierOk": callCourierOk
      };

      List<Object?> get props => [
        customerMobilId, // kullanıcı Id
  customerMobilAdressId, // kullanıcı adres id
  receiverId, // alıcı adres id
  paymentTypeId, // kim ödeyecek o default 2 
  cargoParcelTypeId, // 5 kağıt 6 koli
  cargoTransportationConditionsId, // kırılabilir
  cargoTypeId, // gün içi teslimat default 1
   cargoDesi, // agırlık
   cargoRealeseDate, // tarih
   price, // fiyat
   callCourierOk,
        customerMobilId,
      ];

  PostCourierModel copyWith({
      int? customerMobilId, // kullanıcı Id
  int? customerMobilAdressId, // kullanıcı adres id
  int? receiverId, // alıcı adres id
  int? paymentTypeId, // kim ödeyecek o default 2 
  int? cargoParcelTypeId, // 5 kağıt 6 koli
  int? cargoTransportationConditionsId, // kırılabilir
  int? cargoTypeId, // gün içi teslimat default 1
  double? cargoDesi, // agırlık
  DateTime? cargoRealeseDate, // tarih
  double? price, // fiyat
  bool? callCourierOk, // default false;
  }) {
    return PostCourierModel(
        customerMobilId: this.customerMobilId = customerMobilId ?? this.customerMobilId,
        customerMobilAdressId: this.customerMobilAdressId = customerMobilAdressId ?? this.customerMobilAdressId,
        receiverId: this.receiverId = receiverId ?? this.receiverId,
        cargoParcelTypeId: this.cargoParcelTypeId = cargoParcelTypeId ?? this.cargoParcelTypeId,
        paymentTypeId: this.paymentTypeId = paymentTypeId ?? this.paymentTypeId,
        cargoTransportationConditionsId: this.cargoTransportationConditionsId = cargoTransportationConditionsId ?? this.cargoTransportationConditionsId,
        cargoTypeId: this.cargoTypeId = cargoTypeId ?? this.cargoTypeId,
        cargoDesi: this.cargoDesi =
            cargoDesi ?? this.cargoDesi,
        cargoRealeseDate: this.cargoRealeseDate =
            cargoRealeseDate ?? this.cargoRealeseDate,
        price: this.price = price ?? this.price,
        callCourierOk: this.callCourierOk = callCourierOk ?? this.callCourierOk);
  }
}
