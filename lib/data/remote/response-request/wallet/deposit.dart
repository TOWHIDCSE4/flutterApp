import '../../../../model/deposit.dart';

class DepositRes {
  DepositRes({
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
  Deposit? data;

  factory DepositRes.fromJson(Map<String, dynamic> json) => DepositRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Deposit.fromJson(json["data"]),
  );
}

class ListDepositsRes {
  ListDepositsRes({
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

  factory ListDepositsRes.fromJson(Map<String, dynamic> json) =>
      ListDepositsRes(
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
    this.total,
  });

  int? currentPage;
  List<Deposit>? data;
  String? nextPageUrl;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null
        ? null
        : List<Deposit>.from(
        json["data"].map((x) => Deposit.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    total: json["total"],
  );
}
