// To parse this JSON data, do
//
//     final depositHistoryModel = depositHistoryModelFromJson(jsonString);

import 'dart:convert';

DepositHistoryModel depositHistoryModelFromJson(Map<String, dynamic> str) => DepositHistoryModel.fromJson(str);

String depositHistoryModelToJson(DepositHistoryModel data) => json.encode(data.toJson());

class DepositHistoryModel {
    final int code;
    final bool success;
    final String msgCode;
    final String msg;
    final List<Deposit> data;

    DepositHistoryModel({
        required this.code,
        required this.success,
        required this.msgCode,
        required this.msg,
        required this.data,
    });

    factory DepositHistoryModel.fromJson(Map<String, dynamic> json) => DepositHistoryModel(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Deposit>.from(json["data"].map((x) => Deposit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<Deposit>.from(data.map((x) => x.toJson())),
    };
}

class Deposit {

    Deposit({
        required this.userId,
        required this.depositMoney,
        this.accountNumber,
        this.bankAccountHolderName,
        this.bankName,
        this.depositTradingCode,
        this.depositDateTime,
        this.depositContent,
    });

    int userId;
    int depositMoney;
    String? accountNumber;
    String? bankAccountHolderName;
    String? bankName;
    String? depositTradingCode;
    String? depositDateTime;
    String? depositContent;

    factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        userId: json["user_id"],
        depositMoney: json["deposit_money"].toInt() ?? 0,
        accountNumber: json["account_number"] ?? "",
        bankAccountHolderName: json["bank_account_holder_name"] ?? "",
        bankName: json["bank_name"] ?? "",
        depositTradingCode: json["deposit_trading_code"] ?? "",
        depositDateTime: json["deposit_date_time"] ?? "",
        depositContent: json["deposit_content"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "deposit_money": depositMoney,
        "account_number": accountNumber,
        "bank_account_holder_name": bankAccountHolderName,
        "bank_name": bankName,
        "deposit_trading_code": depositTradingCode,
        "deposit_date_time": depositDateTime,
        "deposit_content": depositContent,
    };
}