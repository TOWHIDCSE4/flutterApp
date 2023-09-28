import 'package:gohomy/model/home_app.dart';

class HomeAppRes {
  HomeAppRes({
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
  HomeApp? data;

  factory HomeAppRes.fromJson(Map<String, dynamic> json) => HomeAppRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : HomeApp.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
      };
}
