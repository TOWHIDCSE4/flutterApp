

import 'dart:convert';

import '../../../../model/user.dart';

UserRes userResFromJson(String str) => UserRes.fromJson(json.decode(str));

String userResToJson(UserRes data) => json.encode(data.toJson());

class UserRes {
  UserRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  User? data;
  String? msgCode;
  String? msg;

  factory UserRes.fromJson(Map<String, dynamic> json) => UserRes(
    code: json["code"],
    success: json["success"],
    data: json["data"] == null ? null : User.fromJson(json["data"]),
    msgCode: json["msg_code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "data": data == null ? null : data!.toJson(),
    "msg_code": msgCode,
    "msg": msg,
  };
}

