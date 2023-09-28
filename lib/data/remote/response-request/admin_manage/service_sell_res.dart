import 'dart:convert';


import '../../../../model/service_sell.dart';

ServiceSellRes serviceSellResFromJson(String str) =>
    ServiceSellRes.fromJson(json.decode(str));

String serviceSellResToJson(ServiceSellRes data) => json.encode(data.toJson());

class ServiceSellRes {
  ServiceSellRes({
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
  ServiceSell? data;

  factory ServiceSellRes.fromJson(Map<String, dynamic> json) => ServiceSellRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ServiceSell.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}
