// To parse this JSON data, do
//
//     final inquireHistoryModel = inquireHistoryModelFromJson(jsonString);

import 'dart:convert';

InquireHistoryModel inquireHistoryModelFromJson(Map<String, dynamic> str) => InquireHistoryModel.fromJson(str);

String inquireHistoryModelToJson(InquireHistoryModel data) => json.encode(data.toJson());

class InquireHistoryModel {
    final int code;
    final bool success;
    final String msgCode;
    final String msg;
    final List<Inquire> data;

    InquireHistoryModel({
        required this.code,
        required this.success,
        required this.msgCode,
        required this.msg,
        required this.data,
    });

    factory InquireHistoryModel.fromJson(Map<String, dynamic> json) => InquireHistoryModel(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Inquire>.from(json["data"].map((x) => Inquire.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<Inquire>.from(data.map((x) => x.toJson())),
    };
}

class Inquire {
    final int userId;
    final int paymentNo;
    final int invoiceNo;
    final int currency;
    final int amount;
    final int amountActuallyReceived;
    final String description;
    final String method;
    final String cardBrand;
    final String status;
    final String failureReason;
    final String createdAt;

// AmountActuallyReceived
    Inquire({
        required this.userId,
        required this.paymentNo,
        required this.invoiceNo,
        required this.currency,
        required this.amount,
        required this.amountActuallyReceived,
        required this.description,
        required this.method,
        required this.cardBrand,
        required this.status,
        required this.failureReason,
        required this.createdAt,
    });

    factory Inquire.fromJson(Map<String, dynamic> json) => Inquire(
        userId: json["user_id"] ?? 0,
        paymentNo: json["payment_no"] ?? 0,
        invoiceNo: json["invoice_no"] ?? "",
        currency: json["currency"] ?? "",
        amount: json["amount"] ?? "",
        amountActuallyReceived: json["amount_actually_received"] ?? "",
        description: json["description"] ?? "",
        method: json["method"] ?? "",
        cardBrand: json["cardBrand"] ?? "",
        status: json["status"] ?? "",
        failureReason: json["failureReason"] ?? "",
        createdAt: json["createdAt"] ?? "",
  
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "payment_no": paymentNo,
        "invoice_no": invoiceNo,
        "currency": currency,
        "amount": amount,
        "amount_actually_received": amountActuallyReceived,
        "description": description,
        "method": method,
        "cardBrand": cardBrand,
        "status": status,
        "failureReason": failureReason,
        "createdAt": createdAt,
    };
}