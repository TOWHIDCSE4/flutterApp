import 'dart:convert';

import 'package:gohomy/model/contract.dart';

ContractRes contractResFromJson(String str) =>
    ContractRes.fromJson(json.decode(str));

String contractResToJson(ContractRes data) => json.encode(data.toJson());

class ContractRes {
  ContractRes({
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
  Contract? data;

  factory ContractRes.fromJson(Map<String, dynamic> json) => ContractRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Contract.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
}
