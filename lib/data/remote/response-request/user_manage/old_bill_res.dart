import '../../../../model/bill.dart';
import '../../../../model/contract.dart';

class OldBillRes {
  OldBillRes({
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
  OldBill? data;

  factory OldBillRes.fromJson(Map<String, dynamic> json) => OldBillRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : OldBill.fromJson(json["data"]),
      );
}

class OldBill {
  OldBill({
    this.bills,
    this.contracts,
  });

  Bill? bills;
  Contract? contracts;

  factory OldBill.fromJson(Map<String, dynamic> json) => OldBill(
        bills: json["bill_closest"] == null
            ? null
            : Bill.fromJson(json["bill_closest"]),
        contracts: json["contract"] == null
            ? null
            : Contract.fromJson(json["contract"]),
      );
}
