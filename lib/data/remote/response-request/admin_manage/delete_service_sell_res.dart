class DeleteServiceSellRes {
  DeleteServiceSellRes({
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

  factory DeleteServiceSellRes.fromJson(Map<String, dynamic> json) =>
      DeleteServiceSellRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.idDeleted,
  });

  int? idDeleted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idDeleted: json["idDeleted"],
      );
}
