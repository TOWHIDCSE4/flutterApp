import 'dart:convert';

import 'package:gohomy/model/find_fast_motel.dart';

FindFastMotelRes findFastMotelResFromJson(String str) =>
    FindFastMotelRes.fromJson(json.decode(str));

String findFastMotelResToJson(FindFastMotelRes data) =>
    json.encode(data.toJson());

class FindFastMotelRes {
  FindFastMotelRes({
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
  FindFastMotel? data;

  factory FindFastMotelRes.fromJson(Map<String, dynamic> json) =>
      FindFastMotelRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data:
            json["data"] == null ? null : FindFastMotel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
}
