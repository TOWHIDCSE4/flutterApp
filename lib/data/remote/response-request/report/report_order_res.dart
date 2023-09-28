import '../../../../model/chart_order.dart';

class ReportOrderRes {
  ReportOrderRes({
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
  ReportOrder? data;

  factory ReportOrderRes.fromJson(Map<String, dynamic> json) => ReportOrderRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportOrder.fromJson(json["data"]),
      );
}

class ReportOrder {
  ReportOrder({
    this.charts,
    this.typeChart,
    this.totalOrderCount,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.totalFinal,
  });

  List<ChartOrder>? charts;
  String? typeChart;
  int? totalOrderCount;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? totalFinal;

  factory ReportOrder.fromJson(Map<String, dynamic> json) => ReportOrder(
        charts: json["charts"] == null
            ? null
            : List<ChartOrder>.from(
                json["charts"].map((x) => ChartOrder.fromJson(x))),
        typeChart: json["type_chart"],
        totalOrderCount: json["total_order_count"],
        totalShippingFee: json["total_shipping_fee"] == null
            ? null
            : json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"] == null
            ? null
            : json["total_before_discount"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
      );
}
