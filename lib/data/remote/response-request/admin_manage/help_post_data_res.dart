import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';

class HelpPostDataRes {
  HelpPostDataRes({
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
  HelpPostData? data;

  factory HelpPostDataRes.fromJson(Map<String, dynamic> json) =>
      HelpPostDataRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : HelpPostData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}
