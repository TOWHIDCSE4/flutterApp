class AdminBadgesRes {
  AdminBadgesRes({
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
  AdminBadges? data;

  factory AdminBadgesRes.fromJson(Map<String, dynamic> json) => AdminBadgesRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : AdminBadges.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class AdminBadges {
  AdminBadges({
    this.totalUser,
    this.totalMotel,
    this.totalContractActive,
    this.totalContractPending,
    this.totalRenter,
    this.totalRenterHasMotel,
    this.totalRenterHasNotMotel,
    this.totalRenterUnconfirmedMotel,
  });

  int? totalUser;
  int? totalMotel;
  int? totalContractActive;
  int? totalContractPending;
  int? totalRenter;
  int? totalRenterHasMotel;
  int? totalRenterHasNotMotel;
  int? totalRenterUnconfirmedMotel;

  factory AdminBadges.fromJson(Map<String, dynamic> json) => AdminBadges(
        totalUser: json["total_user"],
        totalMotel: json["total_motel"],
        totalContractActive: json["total_contract_active"],
        totalContractPending: json["total_contract_pending"],
        totalRenter: json["total_renter"],
        totalRenterHasMotel: json["total_renter_has_motel"],
        totalRenterHasNotMotel: json["total_renter_has_not_motel"],
        totalRenterUnconfirmedMotel:
            json["total_renter_unconfirmed_motel"],
      );

  Map<String, dynamic> toJson() => {
        "total_user": totalUser,
        "total_motel": totalMotel,
        "total_contract_active":
            totalContractActive,
        "total_contract_pending":
            totalContractPending,
        "total_renter": totalRenter,
        "total_renter_has_motel":
            totalRenterHasMotel,
        "total_renter_has_not_motel":
            totalRenterHasNotMotel,
        "total_renter_unconfirmed_motel": totalRenterUnconfirmedMotel,
      };
}
