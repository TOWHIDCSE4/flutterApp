import '../../../../model/admin_discover.dart';

class AdminDiscoverRes {
  AdminDiscoverRes({
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
  AdminDiscover? data;

  factory AdminDiscoverRes.fromJson(Map<String, dynamic> json) =>
      AdminDiscoverRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data:
            json["data"] == null ? null : AdminDiscover.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}
