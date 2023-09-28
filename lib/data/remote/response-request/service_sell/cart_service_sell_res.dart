// To parse this JSON data, do
//
//     final cartServiceSellsRes = cartServiceSellsResFromJson(jsonString);

import 'dart:convert';

import '../../../../model/cart.dart';

CartServiceSellsRes cartServiceSellsResFromJson(String str) =>
    CartServiceSellsRes.fromJson(json.decode(str));

String cartServiceSellsResToJson(CartServiceSellsRes data) =>
    json.encode(data.toJson());

class CartServiceSellsRes {
  CartServiceSellsRes({
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
  Cart? data;

  factory CartServiceSellsRes.fromJson(Map<String, dynamic> json) =>
      CartServiceSellsRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Cart.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
}


