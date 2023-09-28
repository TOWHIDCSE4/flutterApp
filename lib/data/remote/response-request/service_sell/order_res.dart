// To parse this JSON data, do
//
//     final orderRes = orderResFromJson(jsonString);

import 'dart:convert';

import '../../../../model/order.dart';

OrderRes orderResFromJson(String str) => OrderRes.fromJson(json.decode(str));

String orderResToJson(OrderRes data) => json.encode(data.toJson());

class OrderRes {
  OrderRes({
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
  Order? data;

  factory OrderRes.fromJson(Map<String, dynamic> json) => OrderRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Order.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? null : data!.toJson(),
  };
}

