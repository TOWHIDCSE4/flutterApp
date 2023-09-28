class ReportRenterRes {
  ReportRenterRes({
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
  ReportRenter? data;

  factory ReportRenterRes.fromJson(Map<String, dynamic> json) => ReportRenterRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ReportRenter.fromJson(json["data"]),
  );

}

class ReportRenter {
  ReportRenter({
    this.charts,
    this.typeChart,
    this.totalRenter,
  });

  List<ChartRenter>? charts;
  String? typeChart;
  int? totalRenter;

  factory ReportRenter.fromJson(Map<String, dynamic> json) => ReportRenter(
    charts: json["charts"] == null ? null : List<ChartRenter>.from(json["charts"].map((x) => ChartRenter.fromJson(x))),
    typeChart: json["type_chart"],
    totalRenter: json["total_renter"],
  );
}

class ChartRenter {
  ChartRenter({
    this.time,
    this.totalRenter,
  });

  DateTime? time;
  int? totalRenter;

  factory ChartRenter.fromJson(Map<String, dynamic> json) => ChartRenter(
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    totalRenter: json["total_renter"],
  );

}
