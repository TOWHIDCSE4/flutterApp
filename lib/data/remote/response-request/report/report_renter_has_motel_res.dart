

class ReportRenterHasMotelRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportRenterHasMotel? data;

    ReportRenterHasMotelRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportRenterHasMotelRes.fromJson(Map<String, dynamic> json) => ReportRenterHasMotelRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportRenterHasMotel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ReportRenterHasMotel {
    List<RenterHasMotelChart>? charts;
    String? typeChart;
    int? totalPotentialHasContract;

    ReportRenterHasMotel({
        this.charts,
        this.typeChart,
        this.totalPotentialHasContract,
    });

    factory ReportRenterHasMotel.fromJson(Map<String, dynamic> json) => ReportRenterHasMotel(
        charts: json["charts"] == null ? [] : List<RenterHasMotelChart>.from(json["charts"]!.map((x) => RenterHasMotelChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalPotentialHasContract: json["total_potential_has_contract"],
    );

    Map<String, dynamic> toJson() => {
        "charts": charts == null ? [] : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_potential_has_contract": totalPotentialHasContract,
    };
}

class RenterHasMotelChart {
    DateTime? time;
    int? totalPotentialHasContract;

    RenterHasMotelChart({
        this.time,
        this.totalPotentialHasContract,
    });

    factory RenterHasMotelChart.fromJson(Map<String, dynamic> json) => RenterHasMotelChart(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalPotentialHasContract: json["total_potential_has_contract"],
    );

    Map<String, dynamic> toJson() => {
        "time": "${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}",
        "total_potential_has_contract": totalPotentialHasContract,
    };
}
