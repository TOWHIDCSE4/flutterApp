

class AdminConfigRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    AdminConfig? data;

    AdminConfigRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AdminConfigRes.fromJson(Map<String, dynamic> json) => AdminConfigRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : AdminConfig.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class AdminConfig {
    int? id;
    String? currentVersion;
    String? introApp;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? type;

    AdminConfig({
        this.id,
        this.currentVersion,
        this.introApp,
        this.createdAt,
        this.updatedAt,
        this.type,
    });

    factory AdminConfig.fromJson(Map<String, dynamic> json) => AdminConfig(
        id: json["id"],
        currentVersion: json["current_version"],
        introApp: json["intro_app"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "current_version": currentVersion,
        "intro_app": introApp,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
    };
}
