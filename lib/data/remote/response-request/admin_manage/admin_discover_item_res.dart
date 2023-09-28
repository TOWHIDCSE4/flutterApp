import 'package:gohomy/model/admin_discover_item.dart';

class AdminDiscoverItemRes {
  AdminDiscoverItemRes({
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
  AdminDiscoverItem? data;

  factory AdminDiscoverItemRes.fromJson(Map<String, dynamic> json) =>
      AdminDiscoverItemRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : AdminDiscoverItem.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}
