

class ReportPotentialToRenterRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportPotentialToRenter? data;

    ReportPotentialToRenterRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportPotentialToRenterRes.fromJson(Map<String, dynamic> json) => ReportPotentialToRenterRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportPotentialToRenter.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ReportPotentialToRenter {
    List<PotentialToRenterChart>? charts;
    String? typeChart;
    int? totalPotentialToRenter;

    ReportPotentialToRenter({
        this.charts,
        this.typeChart,
        this.totalPotentialToRenter,
    });

    factory ReportPotentialToRenter.fromJson(Map<String, dynamic> json) => ReportPotentialToRenter(
        charts: json["charts"] == null ? [] : List<PotentialToRenterChart>.from(json["charts"]!.map((x) => PotentialToRenterChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalPotentialToRenter: json["total_potential_to_renter"],
    );

    Map<String, dynamic> toJson() => {
        "charts": charts == null ? [] : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_potential_to_renter": totalPotentialToRenter,
    };
}

class PotentialToRenterChart {
    DateTime? time;
    int? totalPotentialToRenter;

    PotentialToRenterChart({
        this.time,
        this.totalPotentialToRenter,
    });

    factory PotentialToRenterChart.fromJson(Map<String, dynamic> json) => PotentialToRenterChart(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalPotentialToRenter: json["total_potential_to_renter"],
    );

    Map<String, dynamic> toJson() => {
        "time": "${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}",
        "total_potential_to_renter": totalPotentialToRenter,
    };
}
