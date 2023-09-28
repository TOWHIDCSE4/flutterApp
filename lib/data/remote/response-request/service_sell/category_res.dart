

import 'package:gohomy/model/category.dart';

class CategoryRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    Category? data;

    CategoryRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory CategoryRes.fromJson(Map<String, dynamic> json) => CategoryRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Category.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

