class SummaryRes {
  SummaryRes({
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
  Summary? data;

  factory SummaryRes.fromJson(Map<String, dynamic> json) => SummaryRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Summary.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class Summary {
  Summary(
      {this.totalMotel,
      this.totalMotelFavorite,
      this.totalMotelRented,
      this.totalRenter,
      this.totalMotelAvailable,
      this.totalProblemDone,
      this.totalProblemNotDone});

  int? totalMotel;
  int? totalMotelFavorite;
  int? totalMotelRented;
  int? totalRenter;
  int? totalMotelAvailable;
  int? totalProblemDone;
  int? totalProblemNotDone;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
      totalMotel: json["total_motel"],
      totalMotelFavorite: json["total_motel_favorite"],
      totalMotelRented: json["total_motel_rented"],
      totalRenter: json["total_renter"],
      totalMotelAvailable: json["total_motel_available"],
      totalProblemDone: json['total_problem_done'],
      totalProblemNotDone: json['total_problem_not_done']);

  Map<String, dynamic> toJson() => {
        "total_motel": totalMotel,
        "total_motel_favorite":
            totalMotelFavorite,
        "total_motel_rented":
            totalMotelRented,
        "total_renter": totalRenter,
        "total_motel_available":
            totalMotelAvailable,
      };
}
