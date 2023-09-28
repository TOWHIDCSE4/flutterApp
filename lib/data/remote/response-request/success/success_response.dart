import 'dart:convert';

SuccessResponse successResponseFromJson(String str) =>
    SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) =>
    json.encode(data.toJson());

class SuccessResponse {
  SuccessResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
  };
}
