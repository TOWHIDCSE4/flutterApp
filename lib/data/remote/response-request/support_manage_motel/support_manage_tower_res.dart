import '../../../../model/support_manage_tower.dart';

class SupportManageTowerRes {
  SupportManageTowerRes({
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
  SupportManageTower? data;

  factory SupportManageTowerRes.fromJson(Map<String, dynamic> json) => SupportManageTowerRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : SupportManageTower.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? null : data!.toJson(),
  };
}