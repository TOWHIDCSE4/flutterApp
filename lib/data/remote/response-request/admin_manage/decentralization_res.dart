import '../../../../model/decentralization.dart';

class DecentralizationRes {
  DecentralizationRes({
    this.code,
    this.msgCode,
    this.msg,
    this.success,
    this.data,
  });

  int? code;
  String? msgCode;
  String? msg;
  bool? success;
  Decentralization? data;

  factory DecentralizationRes.fromJson(Map<String, dynamic> json) =>
      DecentralizationRes(
        code: json["code"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : Decentralization.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg_code": msgCode,
        "msg": msg,
        "success": success,
        "data": data == null ? null : data?.toJson(),
      };
}
