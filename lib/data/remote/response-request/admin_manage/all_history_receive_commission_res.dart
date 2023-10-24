import 'package:gohomy/model/motel_post.dart';
import 'package:gohomy/model/user.dart';

class AllHistoryReceiveCommissionRes {
  AllHistoryReceiveCommissionRes({
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

  factory AllHistoryReceiveCommissionRes.fromJson(Map<String, dynamic> json) =>
      AllHistoryReceiveCommissionRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<HistoryReceiveCommission>? data;

  dynamic nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<HistoryReceiveCommission>.from(
                json["data"].map((x) => HistoryReceiveCommission.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class HistoryReceiveCommission {
  HistoryReceiveCommission({
    this.id,
    this.userId,
    this.userReferralId,
    this.contractId,
    this.dateReferSuccess,
    this.moneyCommissionAdmin,
    this.moneyCommissionUser,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.motelId,
    this.host,
    this.moPost,
  });

  int? id;
  int? userId;
  int? userReferralId;
  int? contractId;
  DateTime? dateReferSuccess;
  int? moneyCommissionAdmin;
  int? moneyCommissionUser;
  dynamic description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? motelId;
  User? host;
  MotelPost? moPost;

  factory HistoryReceiveCommission.fromJson(Map<String, dynamic> json) =>
      HistoryReceiveCommission(
        id: json["id"],
        userId: json["user_id"],
        userReferralId:
            json["user_referral_id"],
        contractId: json["contract_id"],
        dateReferSuccess: json["date_refer_success"] == null
            ? null
            : DateTime.parse(json["date_refer_success"]),
        moneyCommissionAdmin: json["money_commission_admin"],
        moneyCommissionUser: json["money_commission_user"],
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        motelId: json["motel_id"],
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        moPost: json["mo_post"] == null
            ? null
            : MotelPost.fromJson(json["mo_post"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_referral_id": userReferralId,
        "contract_id": contractId,
        "date_refer_success": dateReferSuccess == null
            ? null
            : dateReferSuccess?.toIso8601String(),
        "money_commission_admin":
            moneyCommissionAdmin,
        "money_commission_user":
            moneyCommissionUser,
        "description": description,
        "status": status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "motel_id": motelId,
        "host": host == null ? null : host?.toJson(),
        "mo_post": moPost == null ? null : moPost?.toJson(),
      };
}
