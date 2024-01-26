// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? id;
  String? name;
  String? surname;
  String? tcNo;
  String? numberPhone;
  String? password;
  String? email;
  DateTime? birthDate;

  LoginModel({
    this.id,
    this.name,
    this.surname,
    this.tcNo,
    this.numberPhone,
    this.password,
    this.email,
    this.birthDate,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      name: json["name"],
      surname: json["surname"],
      tcNo: json["tcNo"],
      numberPhone: json["numberPhone"],
      password: json["password"],
      email: json["email"],
      birthDate:
          json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "tcNo": tcNo,
        "numberPhone": numberPhone,
        "password": password,
        "email": email,
        "birthDate": birthDate?.toIso8601String(),
        "createdDate": "",
      };
}
