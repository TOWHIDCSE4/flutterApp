// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import '../../../../model/profile.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Profile? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: json["data"] == null ? null : Profile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}

class DataRegister {
  DataRegister({
    this.phoneNumber,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? phoneNumber;
  String? email;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory DataRegister.fromJson(Map<String, dynamic> json) => DataRegister(
        phoneNumber: json["phone_number"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "email": email,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
