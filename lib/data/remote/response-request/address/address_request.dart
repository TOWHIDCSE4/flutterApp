class AddressRequest {
  AddressRequest({
    this.name,
    this.addressDetail,
    this.country,
    this.province,
    this.district,
    this.wards,
    this.email,
    this.phone,
    this.isDefaultPickup,
    this.isDefaultReturn,
  });

  String? name;
  String? addressDetail;
  int? country;
  int? province;
  int? district;
  int? wards;
  String? email;
  String? phone;
  bool? isDefaultPickup;
  bool? isDefaultReturn;

  Map<String, dynamic> toJson() => {
        "name": name,
        "address_detail": addressDetail,
        "country": country,
        "province": province,
        "district": district,
        "wards": wards,
        "email": email,
        "phone": phone,
        "is_default_pickup": isDefaultPickup,
        "is_default_return": isDefaultReturn,
      };
}
