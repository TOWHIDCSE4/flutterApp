import 'package:gohomy/model/tower.dart';
import 'package:gohomy/model/user.dart';

class SupportManageTower {
    int? id;
    int? hostId;
    int? supporterId;
    String? name;
    String? phoneNumber;
    String? email;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? totalTowerManage;
    int? totalMotelManage;
    int? totalEmptyMotel;
    int? totalContract;
    List<Tower>? towers;
    User? user;

    SupportManageTower({
        this.id,
        this.hostId,
        this.supporterId,
        this.name,
        this.phoneNumber,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.totalTowerManage,
        this.totalMotelManage,
        this.totalEmptyMotel,
        this.totalContract,
        this.towers,this.user
    });

    factory SupportManageTower.fromJson(Map<String, dynamic> json) => SupportManageTower(
        id: json["id"],
        hostId: json["host_id"],
        supporterId: json["supporter_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        totalTowerManage: json["total_tower_manage"],
        totalMotelManage: json["total_motel_manage"],
        totalEmptyMotel: json["total_empty_motel"],
        totalContract: json["total_contract"],
        towers: json["towers"] == null ? [] : List<Tower>.from(json["towers"]!.map((x) => Tower.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "host_id": hostId,
        "supporter_id": supporterId,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_tower_manage": totalTowerManage,
        "total_motel_manage": totalMotelManage,
        "total_empty_motel": totalEmptyMotel,
        "total_contract": totalContract,
        "towers": towers == null ? [] : List<dynamic>.from(towers!.map((x) => x.toJson())),
    };
}