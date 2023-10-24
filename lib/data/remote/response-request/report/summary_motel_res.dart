class SummaryMotelRes {
  SummaryMotelRes({
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
  SummaryMotel? data;

  factory SummaryMotelRes.fromJson(Map<String, dynamic> json) =>
      SummaryMotelRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : SummaryMotel.fromJson(json["data"]),
      );
}

class SummaryMotel {
  SummaryMotel(
      {this.totalMotelRented,
      this.totalMotel,
      this.totalMotelFavorite,
      this.totalRenter,
      this.totalMotelAvailable,
      this.totalrenterRented});

  int? totalMotelRented;
  int? totalMotelAvailable;
  int? totalMotel;
  int? totalMotelFavorite;
  int? totalRenter;
  int? totalrenterRented;

  factory SummaryMotel.fromJson(Map<String, dynamic> json) => SummaryMotel(
      totalMotelRented: json["total_motel_rented"],
      totalMotel: json["total_motel"],
      totalMotelFavorite: json["total_motel_favorite"],
      totalRenter: json["total_renter"],
      totalMotelAvailable: json["total_motel_available"],
      totalrenterRented: json['total_renter_rented']);
}
