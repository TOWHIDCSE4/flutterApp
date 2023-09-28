import '../../../../model/bill.dart';

class UserBillRes {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Bill? bill;

  UserBillRes({this.code, this.success, this.msgCode, this.msg, this.bill});
  factory UserBillRes.fromJson(Map<String, dynamic> json) => UserBillRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        bill: json["data"] == null ? null : Bill.fromJson(json["data"]),
      );
}
