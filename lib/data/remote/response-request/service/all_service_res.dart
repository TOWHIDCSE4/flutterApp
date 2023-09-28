import 'package:gohomy/model/service.dart';

class AllServiceRes {
  AllServiceRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  List<Service>? data;
  String? msgCode;
  String? msg;

  factory AllServiceRes.fromJson(Map<String, dynamic> json) => AllServiceRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<Service>.from(json["data"].map((x) => Service.fromJson(x))),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg_code": msgCode,
        "msg": msg,
      };
}
