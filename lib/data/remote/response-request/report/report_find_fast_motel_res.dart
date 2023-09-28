class ReportFindFastMotelRes {
  ReportFindFastMotelRes({
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
  ReportFindFastMotel? data;

  factory ReportFindFastMotelRes.fromJson(Map<String, dynamic> json) => ReportFindFastMotelRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ReportFindFastMotel.fromJson(json["data"]),
  );
}

class ReportFindFastMotel {
  ReportFindFastMotel({
    this.charts,
    this.typeChart,
    this.totalFindFastMotel,
    this.totalFindFastMotelConsulted,
    this.totalFindFastMotelNotConsult,
  });

  List<ChartFindFastMotel>? charts;
  String? typeChart;
  int? totalFindFastMotel;
  int ?totalFindFastMotelConsulted;
  int? totalFindFastMotelNotConsult;

  factory ReportFindFastMotel.fromJson(Map<String, dynamic> json) => ReportFindFastMotel(
    charts: json["charts"] == null ? null : List<ChartFindFastMotel>.from(json["charts"].map((x) => ChartFindFastMotel.fromJson(x))),
    typeChart: json["type_chart"],
    totalFindFastMotel: json["total_find_fast_motel"],
    totalFindFastMotelConsulted: json["total_find_fast_motel_consulted"],
    totalFindFastMotelNotConsult: json["total_find_fast_motel_not_consult"],
  );
}

class ChartFindFastMotel {
  ChartFindFastMotel({
    this.time,
    this.totalFindFastMotel,
    this.totalFindFastMotelConsulted,
    this.totalFindFastMotelNotConsult,
  });

  DateTime ?time;
  int? totalFindFastMotel;
  int? totalFindFastMotelConsulted;
  int? totalFindFastMotelNotConsult;

  factory ChartFindFastMotel.fromJson(Map<String, dynamic> json) => ChartFindFastMotel(
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    totalFindFastMotel: json["total_find_fast_motel"],
    totalFindFastMotelConsulted: json["total_find_fast_motel_consulted"],
    totalFindFastMotelNotConsult: json["total_find_fast_motel_not_consult"],
  );
}
