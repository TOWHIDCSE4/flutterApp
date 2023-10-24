import 'package:gohomy/model/request_withdrawals.dart';

class RequestWithdrawalsRes {
  RequestWithdrawalsRes({
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
  RequestWithdrawals? data;

  factory RequestWithdrawalsRes.fromJson(Map<String, dynamic> json) =>
      RequestWithdrawalsRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : RequestWithdrawals.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}
