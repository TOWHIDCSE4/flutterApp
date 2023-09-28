class ReportMotelRes {
  ReportMotelRes({
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
  ReportMotel? data;

  factory ReportMotelRes.fromJson(Map<String, dynamic> json) => ReportMotelRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportMotel.fromJson(json["data"]),
      );
}

class ReportMotel {
  ReportMotel({
    this.charts,
    this.typeChart,
    this.totalMotels,
    this.totalQuantityMotelEmpty,
    this.totalQuantityMotelHired,
  });

  List<ChartMotel>? charts;
  String? typeChart;
  int? totalMotels;
  int? totalQuantityMotelEmpty;
  int? totalQuantityMotelHired;

  factory ReportMotel.fromJson(Map<String, dynamic> json) => ReportMotel(
        charts: json["charts"] == null
            ? null
            : List<ChartMotel>.from(
                json["charts"].map((x) => ChartMotel.fromJson(x))),
        typeChart: json["type_chart"],
        totalMotels: json["total_motels"],
        totalQuantityMotelEmpty: json["total_quantity_motel_empty"],
        totalQuantityMotelHired: json["total_quantity_motel_hired"],
      );
}

class ChartMotel {
  ChartMotel({
    this.time,
    this.totalMotels,
    this.totalQuantityMotelEmpty,
    this.totalQuantityMotelHired,
  });

  DateTime? time;
  int? totalMotels;
  int? totalQuantityMotelEmpty;
  int? totalQuantityMotelHired;

  factory ChartMotel.fromJson(Map<String, dynamic> json) => ChartMotel(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalMotels: json["total_motels"],
        totalQuantityMotelEmpty: json["total_quantity_motel_empty"],
        totalQuantityMotelHired: json["total_quantity_motel_hired"],
      );
}
