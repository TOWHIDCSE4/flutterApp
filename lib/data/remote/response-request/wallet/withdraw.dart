import '../../../../model/withdraw.dart';

class WithdrawRes {
  WithdrawRes({
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
  Withdraw? data;

  factory WithdrawRes.fromJson(Map<String, dynamic> json) => WithdrawRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Withdraw.fromJson(json["data"]),
  );
}

class ListWithdrawsRes {
  ListWithdrawsRes({
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

  factory ListWithdrawsRes.fromJson(Map<String, dynamic> json) =>
      ListWithdrawsRes(
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
  List<Withdraw>? data;
  String? nextPageUrl;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null
        ? null
        : List<Withdraw>.from(
        json["data"].map((x) => Withdraw.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    total: json["total"],
  );
}
