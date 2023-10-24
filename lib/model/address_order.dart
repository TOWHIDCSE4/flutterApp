class AddressOrder {
    int? id;
    int? userId;
    int? province;
    int? district;
    int? wards;
    String? addressDetail;
    dynamic note;
    DateTime? createdAt;
    DateTime? updatedAt;
    
    String? wardsName;
    String? provinceName;
    String? districtName;

    AddressOrder({
        this.id,
        this.userId,
        this.province,
        this.district,
        this.wards,
        this.addressDetail,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.districtName,
        this.provinceName,this.wardsName
    });

    factory AddressOrder.fromJson(Map<String, dynamic> json) => AddressOrder(
        id: json["id"],
        userId: json["user_id"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail: json["address_detail"],
        note: json["note"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        wardsName: json["ward_name"],
        districtName: json["district_name"],
        provinceName: json["province_name"]

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}