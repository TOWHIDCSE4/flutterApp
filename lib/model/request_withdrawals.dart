import 'package:gohomy/model/user.dart';

class RequestWithdrawals {
  RequestWithdrawals(
      {this.id,
      this.userId,
      this.amountMoney,
      this.status,
      this.note,
      this.dateWithdrawalApproved,
      this.createdAt,
      this.updatedAt,
      this.adminId,
      this.user});

  int? id;
  int? userId;
  double? amountMoney;
  int? status;
  dynamic note;
  DateTime? dateWithdrawalApproved;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic adminId;
  User? user;

  factory RequestWithdrawals.fromJson(Map<String, dynamic> json) =>
      RequestWithdrawals(
        id: json["id"],
        userId: json["user_id"],
        amountMoney: json["amount_money"] == null
            ? null
            : json["amount_money"].toDouble(),
        status: json["status"],
        note: json["note"],
        dateWithdrawalApproved: json["date_withdrawal_approved"] == null
            ? null
            : DateTime.parse(json["date_withdrawal_approved"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        adminId: json["admin_id"],
        user: json['user'] == null ? null : User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount_money": amountMoney,
        "status": status,
        "note": note,
        "date_withdrawal_approved": dateWithdrawalApproved == null
            ? null
            : dateWithdrawalApproved?.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "admin_id": adminId,
      };
}
