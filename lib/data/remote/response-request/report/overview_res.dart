// To parse this JSON data, do
//
//     final overViewRes = overViewResFromJson(jsonString);

import 'dart:convert';

import '../../../../model/chart.dart';

OverViewRes overViewResFromJson(String str) =>
    OverViewRes.fromJson(json.decode(str));

String overViewResToJson(OverViewRes data) => json.encode(data.toJson());

class OverViewRes {
  OverViewRes({
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
  OverView? data;

  factory OverViewRes.fromJson(Map<String, dynamic> json) => OverViewRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : OverView.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class OverView {
  OverView({
    this.charts,
    this.typeChart,
    this.totalDiscount,
    this.totalMoneyService,
    this.totalMoneyMotel,
    this.totalFinal,
  });

  List<Chart>? charts;
  String? typeChart;
  double? totalDiscount;
  double? totalMoneyService;
  double? totalMoneyMotel;
  double? totalFinal;

  factory OverView.fromJson(Map<String, dynamic> json) => OverView(
        charts: json["charts"] == null
            ? null
            : List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
        typeChart: json["type_chart"],
        totalDiscount: json["total_discount"] == null
            ? null
            : json["total_discount"].toDouble(),
        totalMoneyService: json["total_money_service"] == null
            ? null
            : json["total_money_service"].toDouble(),
        totalMoneyMotel: json["total_money_motel"] == null
            ? null
            : json["total_money_motel"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "charts": charts == null
            ? null
            : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_discount": totalDiscount,
        "total_money_service":
            totalMoneyService,
        "total_money_motel": totalMoneyMotel,
        "total_final": totalFinal,
      };
}
