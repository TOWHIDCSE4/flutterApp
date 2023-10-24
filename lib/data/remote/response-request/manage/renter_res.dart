import 'dart:convert';

import '../../../../model/renter.dart';

RenterRes renterResFromJson(String str) => RenterRes.fromJson(json.decode(str));

String renterResToJson(RenterRes data) => json.encode(data.toJson());

class RenterRes {
  RenterRes({
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
  Renter? data;

  factory RenterRes.fromJson(Map<String, dynamic> json) => RenterRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Renter.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? null : data!.toJson(),
  };
}


