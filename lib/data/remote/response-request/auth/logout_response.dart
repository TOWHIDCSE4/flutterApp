import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.success,
    this.data,
    this.msg,
    this.errors,
    this.code,
  });

  bool? success;
  dynamic data;
  String? msg;
  dynamic errors;
  int? code;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
    success: json["success"],
    data: json["data"],
    msg: json["msg"],
    errors: json["errors"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "msg": msg,
    "errors": errors,
    "code": code,
  };
}