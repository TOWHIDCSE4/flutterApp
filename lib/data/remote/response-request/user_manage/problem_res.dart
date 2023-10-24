import '../../../../model/problem.dart';

class ProblemRes {
  ProblemRes({
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
  Problem? data;

  factory ProblemRes.fromJson(Map<String, dynamic> json) => ProblemRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Problem.fromJson(json["data"]),
  );
}
