import '../../../../model/potential_user.dart';

class PotentialUserRes {
  PotentialUserRes({
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
  PotentialUser? data;

  factory PotentialUserRes.fromJson(Map<String, dynamic> json) =>
      PotentialUserRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data:
            json["data"] == null ? null : PotentialUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}
