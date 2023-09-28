import 'package:gohomy/model/service.dart';

class ServiceRes {
  ServiceRes({
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
  Service? data;

  factory ServiceRes.fromJson(Map<String, dynamic> json) => ServiceRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Service.fromJson(json["data"]),
      );
}
