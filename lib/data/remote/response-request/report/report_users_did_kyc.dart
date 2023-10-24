

class ReportStaticUsersDidKycRes {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  ReportStaticUsersDidKyc? data;

  ReportStaticUsersDidKycRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  factory ReportStaticUsersDidKycRes.fromJson(Map<String, dynamic> json) => ReportStaticUsersDidKycRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ReportStaticUsersDidKyc.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class ReportStaticUsersDidKyc {
  List<PotentialChart>? charts;
  String? typeChart;
  int? totalUsersRegistered;
  int? totalUsersDidKyc;
  int? totalUsersDidnotKyc;
  int? totalPotentialRejected;

  ReportStaticUsersDidKyc({
    this.charts,
    this.typeChart,
    this.totalUsersRegistered,
    this.totalUsersDidKyc,
    this.totalUsersDidnotKyc,
    this.totalPotentialRejected,
  });

  factory ReportStaticUsersDidKyc.fromJson(Map<String, dynamic> json) => ReportStaticUsersDidKyc(
    charts: json["charts"] == null ? [] : List<PotentialChart>.from(json["charts"]!.map((x) => PotentialChart.fromJson(x))),
    typeChart: json["type_chart"],
    totalUsersRegistered: json["total_users_registered"],
    totalUsersDidKyc: json["total_users_did_kyc"],
    totalUsersDidnotKyc: json["total_users_didnot_kyc"],
  );

  Map<String, dynamic> toJson() => {
    "charts": charts == null ? [] : List<dynamic>.from(charts!.map((x) => x.toJson())),
    "type_chart": typeChart,
    "total_users_registered": totalUsersRegistered,
    "total_users_did_kyc": totalUsersDidKyc,
    "total_users_didnot_kyc": totalUsersDidnotKyc,
  };
}

class PotentialChart {
  DateTime? time;
  int? totalUsersRegistered;
  int? totalUsersDidKyc;
  int? totalUsersDidnotKyc;

  PotentialChart({
    this.time,
    this.totalUsersRegistered,
    this.totalUsersDidKyc,
    this.totalUsersDidnotKyc,
  });

  factory PotentialChart.fromJson(Map<String, dynamic> json) => PotentialChart(
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    totalUsersRegistered: json["total_users_registered"],
    totalUsersDidKyc: json["total_users_did_kyc"],
    totalUsersDidnotKyc: json["total_users_didnot_kyc"],
  );

  Map<String, dynamic> toJson() => {
    "time": "${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}",
    "total_users_registered": totalUsersRegistered,
    "total_users_did_kyc": totalUsersDidKyc,
    "total_users_didnot_kyc": totalUsersDidnotKyc,
  };
}
