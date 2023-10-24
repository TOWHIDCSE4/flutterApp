import 'package:gohomy/model/order.dart';

class AllOrderRes {
  AllOrderRes({
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
  Data? data;

  factory AllOrderRes.fromJson(Map<String, dynamic> json) => AllOrderRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<Order>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? null : List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
    nextPageUrl: json["next_page_url"],
  );

}


