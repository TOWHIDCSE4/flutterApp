

class ReportReservationMotelRes {
  ReportReservationMotelRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String ?msgCode;
  String ?msg;
  ReportReservationMotel? data;

  factory ReportReservationMotelRes.fromJson(Map<String, dynamic> json) => ReportReservationMotelRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ReportReservationMotel.fromJson(json["data"]),
  );
}

class ReportReservationMotel {
  ReportReservationMotel({
    this.charts,
    this.typeChart,
    this.totalReservationMotel,
    this.totalReservationMotelConsulted,
    this.totalReservationMotelNotConsult,
  });

  List<ChartReservationMotel>? charts;
  String? typeChart;
  int? totalReservationMotel;
  int? totalReservationMotelConsulted;
  int? totalReservationMotelNotConsult;

  factory ReportReservationMotel.fromJson(Map<String, dynamic> json) => ReportReservationMotel(
    charts: json["charts"] == null ? null : List<ChartReservationMotel>.from(json["charts"].map((x) => ChartReservationMotel.fromJson(x))),
    typeChart: json["type_chart"],
    totalReservationMotel: json["total_reservation_motel"],
    totalReservationMotelConsulted: json["total_reservation_motel_consulted"],
    totalReservationMotelNotConsult: json["total_reservation_motel_not_consult"],
  );
}

class ChartReservationMotel {
  ChartReservationMotel({
    this.time,
    this.totalReservationMotel,
    this.totalReservationMotelConsulted,
    this.totalReservationMotelNotConsult,
  });

  DateTime? time;
  int? totalReservationMotel;
  int? totalReservationMotelConsulted;
  int? totalReservationMotelNotConsult;

  factory ChartReservationMotel.fromJson(Map<String, dynamic> json) => ChartReservationMotel(
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    totalReservationMotel: json["total_reservation_motel"],
    totalReservationMotelConsulted: json["total_reservation_motel_consulted"],
    totalReservationMotelNotConsult: json["total_reservation_motel_not_consult"],
  );
}
