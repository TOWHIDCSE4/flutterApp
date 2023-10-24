

class ReportStaticContractRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportStaticContract? data;

    ReportStaticContractRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportStaticContractRes.fromJson(Map<String, dynamic> json) => ReportStaticContractRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportStaticContract.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ReportStaticContract {
    List<ContractChart>? charts;
    String? typeChart;
    int? totalContract;
    int? totalContractPending;
    int? totalContractActive;
    int? totalContractTermination;

    ReportStaticContract({
        this.charts,
        this.typeChart,
        this.totalContract,
        this.totalContractPending,
        this.totalContractActive,
        this.totalContractTermination,
    });

    factory ReportStaticContract.fromJson(Map<String, dynamic> json) => ReportStaticContract(
        charts: json["charts"] == null ? [] : List<ContractChart>.from(json["charts"]!.map((x) => ContractChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalContract: json["total_contract"],
        totalContractPending: json["total_contract_pending"],
        totalContractActive: json["total_contract_active"],
        totalContractTermination: json["total_contract_termination"],
    );

    Map<String, dynamic> toJson() => {
        "charts": charts == null ? [] : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_contract": totalContract,
        "total_contract_pending": totalContractPending,
        "total_contract_active": totalContractActive,
        "total_contract_termination": totalContractTermination,
    };
}

class ContractChart {
    DateTime? time;
    int? totalContract;
    int? totalContractPending;
    int? totalContractActive;
    int? totalContractTermination;

    ContractChart({
        this.time,
        this.totalContract,
        this.totalContractPending,
        this.totalContractActive,
        this.totalContractTermination,
    });

    factory ContractChart.fromJson(Map<String, dynamic> json) => ContractChart(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalContract: json["total_contract"],
        totalContractPending: json["total_contract_pending"],
        totalContractActive: json["total_contract_active"],
        totalContractTermination: json["total_contract_termination"],
    );

    Map<String, dynamic> toJson() => {
        "time": "${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}",
        "total_contract": totalContract,
        "total_contract_pending": totalContractPending,
        "total_contract_active": totalContractActive,
        "total_contract_termination": totalContractTermination,
    };
}
