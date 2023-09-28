import '../../../../model/admin_discover_item.dart';

class AllAdminDiscoverItemRes {
  AllAdminDiscoverItemRes({
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
  List<AdminDiscoverItem>? data;

  factory AllAdminDiscoverItemRes.fromJson(Map<String, dynamic> json) =>
      AllAdminDiscoverItemRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : List<AdminDiscoverItem>.from(
                json["data"].map((x) => AdminDiscoverItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
