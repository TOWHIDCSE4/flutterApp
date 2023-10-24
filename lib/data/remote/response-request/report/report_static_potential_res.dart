

class ReportStaticPotentialRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportStaticPotential? data;

    ReportStaticPotentialRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportStaticPotentialRes.fromJson(Map<String, dynamic> json) => ReportStaticPotentialRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportStaticPotential.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ReportStaticPotential {
    List<PotentialChart>? charts;
    String? typeChart;
    int? totalPotentials;
    int? totalPotentialNotConsultant;
    int? totalPotentialConsulting;
    int? totalPotentialRejected;

    ReportStaticPotential({
        this.charts,
        this.typeChart,
        this.totalPotentials,
        this.totalPotentialNotConsultant,
        this.totalPotentialConsulting,
        this.totalPotentialRejected,
    });

    factory ReportStaticPotential.fromJson(Map<String, dynamic> json) => ReportStaticPotential(
        charts: json["charts"] == null ? [] : List<PotentialChart>.from(json["charts"]!.map((x) => PotentialChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalPotentials: json["total_potentials"],
        totalPotentialNotConsultant: json["total_potential_not_consultant"],
        totalPotentialConsulting: json["total_potential_consulting"],
        totalPotentialRejected: json["total_potential_rejected"],
    );

    Map<String, dynamic> toJson() => {
        "charts": charts == null ? [] : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_potentials": totalPotentials,
        "total_potential_not_consultant": totalPotentialNotConsultant,
        "total_potential_consulting": totalPotentialConsulting,
        "total_potential_rejected": totalPotentialRejected,
    };
}

class PotentialChart {
    DateTime? time;
    int? totalPotentials;
    int? totalPotentialNotConsultant;
    int? totalPotentialConsulting;
    int? totalPotentialRejected;

    PotentialChart({
        this.time,
        this.totalPotentials,
        this.totalPotentialNotConsultant,
        this.totalPotentialConsulting,
        this.totalPotentialRejected,
    });

    factory PotentialChart.fromJson(Map<String, dynamic> json) => PotentialChart(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalPotentials: json["total_potentials"],
        totalPotentialNotConsultant: json["total_potential_not_consultant"],
        totalPotentialConsulting: json["total_potential_consulting"],
        totalPotentialRejected: json["total_potential_rejected"],
    );

    Map<String, dynamic> toJson() => {
        "time": "${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}",
        "total_potentials": totalPotentials,
        "total_potential_not_consultant": totalPotentialNotConsultant,
        "total_potential_consulting": totalPotentialConsulting,
        "total_potential_rejected": totalPotentialRejected,
    };
}
