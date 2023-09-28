import 'package:gohomy/model/user.dart';

import 'motel_post.dart';

class CommissionManage {
  CommissionManage(
      {this.id,
      this.userId,
      this.userReferralId,
      this.contractId,
      this.motelId,
      this.dateReferSuccess,
      this.moneyCommissionAdmin,
      this.moneyCommissionUser,
      this.description,
      this.status,
      this.firstReceiveCommission,
      this.createdAt,
      this.updatedAt,
      this.host,
      this.moPost,
      this.imagesHostPaid,
      this.statusCommissionCollaborator,
      this.user,
      this.userReferral});

  int? id;
  int? userId;
  int? userReferralId;
  int? contractId;
  int? motelId;
  DateTime? dateReferSuccess;
  double? moneyCommissionAdmin;
  double? moneyCommissionUser;
  dynamic description;
  int? status;
  int? statusCommissionCollaborator;
  int? firstReceiveCommission;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? host;
  MotelPost? moPost;
  List<String>? imagesHostPaid;
  User? user;
  User? userReferral;

  factory CommissionManage.fromJson(Map<String, dynamic> json) =>
      CommissionManage(
        id: json["id"],
        userId: json["user_id"],
        userReferralId:
            json["user_referral_id"],
        contractId: json["contract_id"],
        motelId: json["motel_id"],
        dateReferSuccess: json["date_refer_success"] == null
            ? null
            : DateTime.parse(json["date_refer_success"]),
        moneyCommissionAdmin: json["money_commission_admin"] == null
            ? null
            : json["money_commission_admin"].toDouble(),
        moneyCommissionUser: json["money_commission_user"] == null
            ? null
            : json["money_commission_user"].toDouble(),
        description: json["description"],
        status: json["status"],
        firstReceiveCommission: json["first_receive_commission"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        moPost: json["mo_post"] == null
            ? null
            : MotelPost.fromJson(json["mo_post"]),
        imagesHostPaid: json['images_host_paid'] == null
            ? []
            : List<String>.from(json["images_host_paid"].map((x) => x)),
        statusCommissionCollaborator:
            json['status_commission_collaborator'],
        user: json['user'] == null ? null : User.fromJson(json['user']),
        userReferral: json['user_referral'] == null
            ? null
            : User.fromJson(json['user_referral']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_referral_id": userReferralId,
        "contract_id": contractId,
        "motel_id": motelId,
        "date_refer_success": dateReferSuccess == null
            ? null
            : dateReferSuccess?.toIso8601String(),
        "money_commission_admin":
            moneyCommissionAdmin,
        "money_commission_user":
            moneyCommissionUser,
        "description": description,
        "status": status,
        "first_receive_commission":
            firstReceiveCommission,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "host": host == null ? null : host?.toJson(),
        "mo_post": moPost == null ? null : moPost?.toJson(),
        "images_host_paid": imagesHostPaid == null
            ? null
            : List<dynamic>.from(imagesHostPaid!.map((x) => x)),
        "status_commission_collaborator": statusCommissionCollaborator
      };
}
