// To parse this JSON data, do
//
//     final checkAppleRes = checkAppleResFromJson(jsonString);

import 'dart:convert';

CheckAppleRes checkAppleResFromJson(String str) => CheckAppleRes.fromJson(json.decode(str));

String checkAppleResToJson(CheckAppleRes data) => json.encode(data.toJson());

class CheckAppleRes {
  CheckAppleRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  bool? data;

  factory CheckAppleRes.fromJson(Map<String, dynamic> json) => CheckAppleRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data,
  };
}
