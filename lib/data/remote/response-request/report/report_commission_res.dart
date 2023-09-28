class ReportCommissionRes {
  ReportCommissionRes({
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
  ReportCommission? data;

  factory ReportCommissionRes.fromJson(Map<String, dynamic> json) =>
      ReportCommissionRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : ReportCommission.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class ReportCommission {
  ReportCommission({
    this.charts,
    this.typeChart,
    this.totalMoneyCommissionAdminReceived,
    this.totalMoneyCommissionAdminPaidCollaborator,
    this.totalMoneyCommissionAdminRevenue,
  });

  List<Chart>? charts;
  String? typeChart;
  double? totalMoneyCommissionAdminReceived;
  double? totalMoneyCommissionAdminPaidCollaborator;
  double? totalMoneyCommissionAdminRevenue;

  factory ReportCommission.fromJson(Map<String, dynamic> json) =>
      ReportCommission(
        charts: json["charts"] == null
            ? null
            : List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
        typeChart: json["type_chart"],
        totalMoneyCommissionAdminReceived:
            json["total_money_commission_admin_received"] == null
                ? null
                : json["total_money_commission_admin_received"].toDouble(),
        totalMoneyCommissionAdminPaidCollaborator:
            json["total_money_commission_admin_paid_collaborator"] == null
                ? null
                : json["total_money_commission_admin_paid_collaborator"]
                    .toDouble(),
        totalMoneyCommissionAdminRevenue:
            json["total_money_commission_admin_revenue"] == null
                ? null
                : json["total_money_commission_admin_revenue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "charts": charts == null
            ? null
            : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_money_commission_admin_received":
            totalMoneyCommissionAdminReceived,
        "total_money_commission_admin_paid_collaborator":
            totalMoneyCommissionAdminPaidCollaborator,
        "total_money_commission_admin_revenue":
            totalMoneyCommissionAdminRevenue,
      };
}

class Chart {
  Chart({
    this.time,
    this.totalMoneyCommissionAdminReceived,
    this.totalMoneyCommissionAdminPaidCollaborator,
    this.totalMoneyCommissionAdminRevenue,
  });

  DateTime? time;
  double? totalMoneyCommissionAdminReceived;
  double? totalMoneyCommissionAdminPaidCollaborator;
  double? totalMoneyCommissionAdminRevenue;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalMoneyCommissionAdminReceived:
            json["total_money_commission_admin_received"] == null
                ? null
                : json["total_money_commission_admin_received"].toDouble(),
        totalMoneyCommissionAdminPaidCollaborator:
            json["total_money_commission_admin_paid_collaborator"] == null
                ? null
                : json["total_money_commission_admin_paid_collaborator"]
                    .toDouble(),
        totalMoneyCommissionAdminRevenue:
            json["total_money_commission_admin_revenue"] == null
                ? null
                : json["total_money_commission_admin_revenue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null
            ? null
            : "${time?.year.toString().padLeft(4, '0')}-${time?.month.toString().padLeft(2, '0')}-${time?.day.toString().padLeft(2, '0')}",
        "total_money_commission_admin_received":
            totalMoneyCommissionAdminReceived,
        "total_money_commission_admin_paid_collaborator":
            totalMoneyCommissionAdminPaidCollaborator,
        "total_money_commission_admin_revenue":
            totalMoneyCommissionAdminRevenue,
      };
}
