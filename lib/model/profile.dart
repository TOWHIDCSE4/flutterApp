
class Profile {
  Profile({
    this.name,
    this.nameStrFilter,
    this.areaCode,
    this.phoneNumber,
    this.email,
    this.storeName,
    this.addressDetail,
    this.province,
    this.district,
    this.wards,
    this.avatarImage,
    this.sex,
    this.isCompany,
    this.taxCode,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.password,
  });

  String? name;
  String? nameStrFilter;
  String? areaCode;
  String? phoneNumber;
  String? email;
  String? storeName;
  String? addressDetail;
  String? password;
  int? province;
  int? district;
  int? wards;
  String? avatarImage;
  int? sex;
  bool? isCompany;
  String? taxCode;
  String? provinceName;
  String? districtName;
  String? wardsName;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    nameStrFilter: json["name_str_filter"],
    areaCode: json["area_code"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    storeName: json["store_name"],
    addressDetail: json["address_detail"],
    province: json["province"],
    district: json["district"],
    wards: json["wards"],
    avatarImage: json["avatar_image"],
    sex: json["sex"],
    isCompany:json["is_company"],
    taxCode:json["tax_code"],
    provinceName: json["province_name"],
    districtName: json["district_name"],
    wardsName: json["wards_name"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone_number": phoneNumber,
    "password": password,
    "email": email,
    "address_detail": addressDetail,
    "province": province,
    "district": district,
    "wards": wards,
    "avatar_image": avatarImage,
    "sex": sex,
    "is_company": isCompany,
    "tax_code": taxCode,
  };
}
