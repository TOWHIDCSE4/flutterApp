import '../../../../model/bank.dart';

class BankInfoRes {
  BankInfoRes({
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
  BankInfo? data;

  factory BankInfoRes.fromJson(Map<String, dynamic> json) => BankInfoRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : BankInfo.fromJson(json["data"]),
  );
}

class ListBankInfoRes {
  ListBankInfoRes({
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

  factory ListBankInfoRes.fromJson(Map<String, dynamic> json) =>
      ListBankInfoRes(
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
  List<BankInfo>? data;
  String? nextPageUrl;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null
        ? null
        : List<BankInfo>.from(
        json["data"].map((x) => BankInfo.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    total: json["total"],
  );
}
