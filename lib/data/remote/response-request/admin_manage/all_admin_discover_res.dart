import '../../../../model/admin_discover.dart';

class AllAdminDiscoverRes {
  AllAdminDiscoverRes({
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
  List<AdminDiscover>? data;

  factory AllAdminDiscoverRes.fromJson(Map<String, dynamic> json) =>
      AllAdminDiscoverRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : List<AdminDiscover>.from(
                json["data"].map((x) => AdminDiscover.fromJson(x))),
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
