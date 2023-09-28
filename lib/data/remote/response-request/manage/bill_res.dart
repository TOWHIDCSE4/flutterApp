import 'dart:convert';

import '../../../../model/bill.dart';

BillRes billResFromJson(String str) => BillRes.fromJson(json.decode(str));

String billResToJson(BillRes data) => json.encode(data.toJson());

class BillRes {
  BillRes({
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
  Bill? data;

  factory BillRes.fromJson(Map<String, dynamic> json) => BillRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Bill.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? null : data!.toJson(),
  };
}

