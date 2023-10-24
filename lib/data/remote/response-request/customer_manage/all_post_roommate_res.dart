import '../../../../model/furniture.dart';
import '../../../../model/post_roommate.dart';
import '../../../../model/service.dart';

class AllPostRoommateRes {
  AllPostRoommateRes({
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

  factory AllPostRoommateRes.fromJson(Map<String, dynamic> json) =>
      AllPostRoommateRes(
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
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
    this.total,
  });

  int? currentPage;
  List<PostRoommate>? data;
  String? nextPageUrl;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<PostRoommate>.from(
                json["data"]!.map((x) => PostRoommate.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "total": total,
      };
}
