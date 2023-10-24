

class ReportStaticBillRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportStaticBill? data;

    ReportStaticBillRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportStaticBillRes.fromJson(Map<String, dynamic> json) => ReportStaticBillRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportStaticBill.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ReportStaticBill {
    List<BillChart>? charts;
    String? typeChart;
    int? totalBill;
    int? totalBillPending;
    int? totalBillPendingConfirm;
    int? totalBillCompleted;

    ReportStaticBill({
        this.charts,
        this.typeChart,
        this.totalBill,
        this.totalBillPending,
        this.totalBillPendingConfirm,
        this.totalBillCompleted,
    });

    factory ReportStaticBill.fromJson(Map<String, dynamic> json) => ReportStaticBill(
        charts: json["charts"] == null ? [] : List<BillChart>.from(json["charts"]!.map((x) => BillChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalBill: json["total_bill"],
        totalBillPending: json["total_bill_pending"],
        totalBillPendingConfirm: json["total_bill_pending_confirm"],
        totalBillCompleted: json["total_bill_completed"],
    );

    Map<String, dynamic> toJson() => {
        "charts": charts == null ? [] : List<dynamic>.from(charts!.map((x) => x.toJson())),
        "type_chart": typeChart,
        "total_bill": totalBill,
        "total_bill_pending": totalBillPending,
        "total_bill_pending_confirm": totalBillPendingConfirm,
        "total_bill_completed": totalBillCompleted,
    };
}

class BillChart {
    DateTime? time;
    int? totalBill;
    int? totalBillPending;
    int? totalBillPendingConfirm;
    int? totalBillCompleted;

    BillChart({
        this.time,
        this.totalBill,
        this.totalBillPending,
        this.totalBillPendingConfirm,
        this.totalBillCompleted,
    });

    factory BillChart.fromJson(Map<String, dynamic> json) => BillChart(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalBill: json["total_bill"],
        totalBillPending: json["total_bill_pending"],
        totalBillPendingConfirm: json["total_bill_pending_confirm"],
        totalBillCompleted: json["total_bill_completed"],
    );

    Map<String, dynamic> toJson() => {
        "time": "${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}",
        "total_bill": totalBill,
        "total_bill_pending": totalBillPending,
        "total_bill_pending_confirm": totalBillPendingConfirm,
        "total_bill_completed": totalBillCompleted,
    };
}
