import '../../../../model/reservation_motel.dart';

class AllReservationMotelRes {
  AllReservationMotelRes({
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

  factory AllReservationMotelRes.fromJson(Map<String, dynamic> json) =>
      AllReservationMotelRes(
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
  });

  int? currentPage;
  List<ReservationMotel>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<ReservationMotel>.from(
                json["data"].map((x) => ReservationMotel.fromJson(x))),
        nextPageUrl:
            json["next_page_url"],
      );
}
