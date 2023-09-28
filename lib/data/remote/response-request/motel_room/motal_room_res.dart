import 'package:gohomy/model/motel_room.dart';

class AllMotelRoomRes {
  AllMotelRoomRes({
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

  factory AllMotelRoomRes.fromJson(Map<String, dynamic> json) =>
      AllMotelRoomRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
    this.total,
  });

  int? currentPage;
  List<MotelRoom>? data;
  String? nextPageUrl;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<MotelRoom>.from(
                json["data"].map((x) => MotelRoom.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        total: json["total"],
      );
}
