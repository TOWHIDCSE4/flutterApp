import '../../../../model/service_sell.dart';

class ReportServiceSellRes {
  ReportServiceSellRes({
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
  ReportServiceSell? data;

  factory ReportServiceSellRes.fromJson(Map<String, dynamic> json) =>
      ReportServiceSellRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : ReportServiceSell.fromJson(json["data"]),
      );
}

class ReportServiceSell {
  ReportServiceSell({
    this.topSellingServices,
    this.topRevenueServices,
  });

  List<TopSellingService>? topSellingServices;
  List<TopRevenueService>? topRevenueServices;

  factory ReportServiceSell.fromJson(Map<String, dynamic> json) =>
      ReportServiceSell(
        topSellingServices: json["top_selling_services"] == null
            ? null
            : List<TopSellingService>.from(json["top_selling_services"]
                .map((x) => TopSellingService.fromJson(x))),
        topRevenueServices: json["top_revenue_services"] == null
            ? null
            : List<TopRevenueService>.from(json["top_revenue_services"]
                .map((x) => TopRevenueService.fromJson(x))),
      );
}

class TopRevenueService {
  TopRevenueService({
    this.serviceSellId,
    this.totalPrice,
    this.serviceSell,
  });

  int? serviceSellId;
  double? totalPrice;
  ServiceSell? serviceSell;

  factory TopRevenueService.fromJson(Map<String, dynamic> json) =>
      TopRevenueService(
        serviceSellId:
            json["service_sell_id"],
        totalPrice: json["total_money_revenue"] == null
            ? null
            : json["total_money_revenue"].toDouble(),
        serviceSell: json["service_sell"] == null
            ? null
            : ServiceSell.fromJson(json["service_sell"]),
      );
}

class TopSellingService {
  TopSellingService({
    this.serviceSellId,
    this.quantity,
    this.serviceSell,
  });

  int? serviceSellId;
  double? quantity;
  ServiceSell? serviceSell;

  factory TopSellingService.fromJson(Map<String, dynamic> json) =>
      TopSellingService(
        serviceSellId:
            json["service_sell_id"],
        quantity: json["total_quantity_service_sold"] == null
            ? null
            : json["total_quantity_service_sold"].toDouble(),
        serviceSell: json["service_sell"] == null
            ? null
            : ServiceSell.fromJson(json["service_sell"]),
      );
}
