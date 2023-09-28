import 'package:gohomy/model/report_post_violation.dart';

class ReportViolationPostRes {
  ReportViolationPostRes({
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
  ReportPostViolation? data;

  factory ReportViolationPostRes.fromJson(Map<String, dynamic> json) =>
      ReportViolationPostRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : ReportPostViolation.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}
