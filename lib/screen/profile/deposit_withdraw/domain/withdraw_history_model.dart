// To parse this JSON data, do
//
//     final withdrawHistoryModel = withdrawHistoryModelFromJson(jsonString);

import 'dart:convert';

WithdrawHistoryModel withdrawHistoryModelFromJson(String str) => WithdrawHistoryModel.fromJson(json.decode(str));

String withdrawHistoryModelToJson(WithdrawHistoryModel data) => json.encode(data.toJson());

class WithdrawHistoryModel {
    final int code;
    final bool success;
    final String msgCode;
    final String msg;
    final List<Withdraw> data;

    WithdrawHistoryModel({
        required this.code,
        required this.success,
        required this.msgCode,
        required this.msg,
        required this.data,
    });

    factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) => WithdrawHistoryModel(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Withdraw>.from(json["data"].map((x) => Withdraw.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Withdraw {
    final int userId;
    final int withdrawMoney;
    final String accountNumber;
    final String bankAccountHolderName;
    final String bankName;
    final String withdrawTradingCode;
    final String withdrawDateTime;
    final String withdrawContent;

    Withdraw({
        required this.userId,
        required this.withdrawMoney,
        required this.accountNumber,
        required this.bankAccountHolderName,
        required this.bankName,
        required this.withdrawTradingCode,
        required this.withdrawDateTime,
        required this.withdrawContent,
    });

    factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        userId: json["user_id"] ?? 0,
        withdrawMoney: json["withdraw_money"] ?? 0,
        accountNumber: json["account_number"] ?? "",
        bankAccountHolderName: json["bank_account_holder_name"] ?? "",
        bankName: json["bank_name"] ?? "",
        withdrawTradingCode: json["withdraw_trading_code"] ?? "",
        withdrawDateTime: json["withdraw_date_time"] ?? "",
        withdrawContent: json["withdraw_content"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "withdraw_money": withdrawMoney,
        "account_number": accountNumber,
        "bank_account_holder_name": bankAccountHolderName,
        "bank_name": bankName,
        "withdraw_trading_code": withdrawTradingCode,
        "withdraw_date_time": withdrawDateTime,
        "withdraw_content": withdrawContent,
    };
}
