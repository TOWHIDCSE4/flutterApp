

import 'dart:convert';

import '../../../../model/reservation_motel.dart';

ReservationMotelRes reservationMotelResFromJson(String str) => ReservationMotelRes.fromJson(json.decode(str));

String reservationMotelResToJson(ReservationMotelRes data) => json.encode(data.toJson());

class ReservationMotelRes {
  ReservationMotelRes({
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
  ReservationMotel? data;

  factory ReservationMotelRes.fromJson(Map<String, dynamic> json) => ReservationMotelRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ReservationMotel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
  };
}


