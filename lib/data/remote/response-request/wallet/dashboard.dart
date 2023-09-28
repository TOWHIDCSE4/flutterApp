import '../../../../model/dashboard.dart';

class DashboardRes {
  DashboardRes({
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
  Dashboard? data;

  factory DashboardRes.fromJson(Map<String, dynamic> json) => DashboardRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Dashboard.fromJson(json["data"]),
  );
}

class GraphRes {
  GraphRes({
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
  List<Graph>? data;

  factory GraphRes.fromJson(Map<String, dynamic> json) => GraphRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : List<Graph>.from(
        json["data"].map((x) => Graph.fromJson(x))),
  );
}
