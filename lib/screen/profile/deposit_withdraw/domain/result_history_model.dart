// To parse this JSON data, do
//
//     final ResultHistoryModel = resultHistoryModelFromJson(jsonString);

import 'dart:convert';

ResultHistoryModel resultHistoryModelFromJson(Map<String, dynamic> str) => ResultHistoryModel.fromJson(str);

String resultHistoryModelToJson(ResultHistoryModel data) => json.encode(data.toJson());

class ResultHistoryModel {
    final int code;
    final bool success;
    final String msgCode;
    final String msg;
    final List<Result> data;

    ResultHistoryModel({
        required this.code,
        required this.success,
        required this.msgCode,
        required this.msg,
        required this.data,
    });

    factory ResultHistoryModel.fromJson(Map<String, dynamic> json) => ResultHistoryModel(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Result>.from(json["data"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<Result>.from(data.map((x) => x.toJson())),
    };
}

class Result {
    final int userId;
    final int amount;
    final String amountForeign;
    final String amountRequest;
    final String bank;
    final String cardBrand;
    final String cardInfo;

    final String token;
    final String cardName;
    final String hashCard;
    final String cardNumber;

    final String createdAt;
    final String currency;
    final String description;
    final String excRate;
    final String failureReason;
    final String foreignCurrency;
    final String invoiceNo;
    final String lang;
    final String method;
    final String paymentNo;
    final String status;
    final String tenor;



    Result({
        required this.userId,
        required this.amount,
        required this.amountForeign,
        required this.amountRequest,
        required this.bank,
        required this.cardBrand,
        required this.cardInfo,

        required this.token,
        required this.cardName,
        required this.hashCard,
        required this.cardNumber,

        required this.createdAt,
        required this.currency,
        required this.description,
        required this.excRate,
        required this.failureReason,
        required this.foreignCurrency,
        required this.invoiceNo,
        required this.lang,
        required this.method,
        required this.paymentNo,
        required this.status,
        required this.tenor,

    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        userId: json["user_id"] ?? 0,
        amount: json["amount"] ?? 0,
        amountForeign: json["amount_foreign"] ?? "",
        amountRequest: json["amount_request"] ?? "",
        bank: json["bank"] ?? "",
        cardBrand: json["card_brand"] ?? "",
        cardInfo: json["card_info"] ?? "",

        token: json["token"] ?? "",
        cardName: json["card_name"] ?? "",
        hashCard: json["hash_card"] ?? "",
        cardNumber: json["card_number     "] ?? "",

        createdAt: json["created_at"] ?? "",
        currency: json["currency"] ?? "",
        description: json["description"] ?? "",
        excRate: json["exc_rate"] ?? "",
        failureReason: json["failure_reason"] ?? "",
        foreignCurrency: json["foreign_currency"] ?? "",
        invoiceNo: json["invoice_no"] ?? "",
        lang: json["lang"] ?? "",
        method: json["method"] ?? "",
        paymentNo: json["payment_no"] ?? "",
        status: json["status"] ?? "",
        tenor: json["tenor"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "amount": amount,
        "amount_foreign": amountForeign,
        "amount_request": amountRequest,
        "bank": bank,
        "card_brand": cardBrand,

        "card_info": cardInfo,
        "token": token,
        "card_name": cardName,
        "hash_card": hashCard,
        "card_number": cardNumber,

        "created_at": createdAt,
        "currency": currency,
        "description": description,
        "exc_rate": excRate,
        "failure_reason": failureReason,
        "foreign_currency": foreignCurrency,
        "invoice_no": invoiceNo,
        "lang": lang,
        "method": method,
        "payment_no": paymentNo,
        "status": status,
        "tenor": tenor,
    };
}